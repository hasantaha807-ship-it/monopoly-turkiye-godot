extends Node
# ==========================================================
# AĞ YÖNETİCİSİ (Autoload adı: Ag)
# Aynı Wi-Fi / hotspot üzerindeki cihazlar arasında oda kurma,
# odayı otomatik bulma (UDP yayını), lobi ve yeniden bağlanma.
# Oyun mantığının ağ kısmı node_2d.gd içindedir.
# ==========================================================

const SURUM := 2                 # Farklı sürümler birbirine bağlanmasın diye (2: ihale, tekel, enflasyon)
const OYUN_PORTU := 7777         # ENet (oyun trafiği)
const KESIF_PORTU := 7778        # UDP yayını (oda bulma)
const MAKS_OYUNCU := 4
const OYUN_KIMLIGI := "monopoly_turkiye"
const BAGLANMA_ZAMAN_ASIMI := 8.0

# Araba seçim ekranındaki renklerle aynı sıra
const RENKLER := [Color("ff5943"), Color("599eff"), Color("ffcc00"), Color("3de865"), Color("ff9a2e"), Color("b57bff"), Color("ff74c0"), Color("2fd8d0")]
const RENK_ADLARI := ["Kırmızı", "Mavi", "Sarı", "Yeşil", "Turuncu", "Mor", "Pembe", "Turkuaz"]
const ARABA_SAYISI := 5
const ENFLASYON_ADLARI := ["KAPALI", "NORMAL", "YÜKSEK"]
const ENFLASYON_ACIKLAMALARI := ["kiralar sabit kalır", "her 10 turda kira +%20", "her 8 turda kira +%25"]

signal lobi_degisti
signal odalar_degisti
signal durum_mesaji(metin: String)
signal oyuncu_sahneye_hazir(peer_id: int)
signal oyuncu_dustu(indeks: int)
signal oyuncu_geri_dondu(indeks: int, peer_id: int)

var online := false
var cevrimdisi_oda := false       # Tek cihazda botlara karşı oyun için aynı oda ekranı
var acilis_modu := ""             # Ana menü lobiyi "cevrimdisi" modda açmak isterse
var oyun_ayarlari := {"enflasyon": 1}   # Oda sahibinin seçtiği kurallar (0 kapalı, 1 normal, 2 yüksek)
var oyun_basladi := false
var yeniden_baglaniyor := false   # Oyun ortasında geri dönen istemci
var yuvalar: Array = []           # [{peer, isim, araba, renk(indeks), bot, bagli}]
var yerel_indeks := -1
var profil := {"isim": "", "araba": 0, "renk": 0}
var son_mesaj := ""               # Ana menüde gösterilecek bilgi
var bulunan_odalar := {}          # ip -> {oda, kisi, basladi, zaman}
var hazir_peerler := {}           # Oyun sahnesini yüklemiş peer'lar (sunucuda)
var oyun_sahnesi: Node = null     # Komutların iletileceği oyun sahnesi (node_2d)
var _bekleyen_komutlar: Array = []  # Sahne yüklenmeden gelen komutlar

var _yayinci: PacketPeerUDP = null
var _dinleyici: PacketPeerUDP = null
var _yayin_sayaci := 0.0
var _baglaniyor := false
var _baglanma_suresi := 0.0


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func sunucu_mu() -> bool:
	return cevrimdisi_oda or (online and multiplayer.is_server())


# Çevrimdışı oyun: ağ yok, aynı oda ekranı; sen + botlar
func yerel_oda_kur():
	ayril()
	cevrimdisi_oda = true
	yuvalar = [_yuva_olustur(1, _isim_temizle(profil["isim"]), int(profil["araba"]), int(profil["renk"]), false)]
	yerel_indeks = 0
	bot_ekle()


func yerel_isim_degistir(isim: String):
	if not cevrimdisi_oda or yuvalar.is_empty():
		return
	profil["isim"] = isim
	yuvalar[0]["isim"] = _isim_temizle(isim)
	lobi_degisti.emit()


# ----------------------------------------------------------
# ODA KURMA (sunucu)
# ----------------------------------------------------------
func oda_kur() -> bool:
	ayril()
	var peer := ENetMultiplayerPeer.new()
	var hata := peer.create_server(OYUN_PORTU, MAKS_OYUNCU - 1)
	if hata != OK:
		durum_mesaji.emit("Oda kurulamadı. %d portu başka bir uygulama tarafından kullanılıyor olabilir." % OYUN_PORTU)
		return false
	multiplayer.multiplayer_peer = peer
	online = true
	oyun_basladi = false
	yuvalar = [_yuva_olustur(1, _isim_temizle(profil["isim"]), int(profil["araba"]), int(profil["renk"]), false)]
	yerel_indeks = 0
	_yayinci = PacketPeerUDP.new()
	_yayinci.set_broadcast_enabled(true)
	_yayin_sayaci = 0.0
	lobi_degisti.emit()
	return true


func bot_ekle():
	if not sunucu_mu() or oyun_basladi or yuvalar.size() >= MAKS_OYUNCU:
		return
	var no := 1
	while _isim_var_mi("Bot " + str(no)):
		no += 1
	yuvalar.append(_yuva_olustur(0, "Bot " + str(no), randi() % ARABA_SAYISI, _bos_renk(), true))
	_lobi_yayinla()


func bot_cikar(indeks: int = -1):
	if not sunucu_mu() or oyun_basladi:
		return
	if indeks >= 0:
		if indeks < yuvalar.size() and yuvalar[indeks]["bot"]:
			yuvalar.remove_at(indeks)
			_lobi_yayinla()
		return
	for i in range(yuvalar.size() - 1, -1, -1):
		if yuvalar[i]["bot"]:
			yuvalar.remove_at(i)
			_lobi_yayinla()
			return


# Odadaki oyuncu arabasını / rengini değiştirir (renk başkasındaysa reddedilir)
func secim_degistir(araba: int, renk: int):
	if (not online and not cevrimdisi_oda) or oyun_basladi:
		return
	if multiplayer.is_server():
		_secimi_uygula(1, araba, renk)
	else:
		_secim_istegi.rpc_id(1, araba, renk)


func renk_sahibi(renk: int) -> int:
	for i in yuvalar.size():
		if int(yuvalar[i]["renk"]) == renk:
			return i
	return -1


func _secimi_uygula(peer_id: int, araba: int, renk: int):
	var i := peer_indeksi(peer_id)
	if i == -1:
		return
	yuvalar[i]["araba"] = clampi(araba, 0, ARABA_SAYISI - 1)
	if renk >= 0 and renk < RENKLER.size():
		var sahip := renk_sahibi(renk)
		if sahip == -1 or sahip == i:
			yuvalar[i]["renk"] = renk
	_lobi_yayinla()


# Oda sahibi (veya çevrimdışı oyuncu) oyun kuralını değiştirir; herkese yayınlanır
func ayar_degistir(anahtar: String, deger):
	if not sunucu_mu() or oyun_basladi:
		return
	oyun_ayarlari[anahtar] = deger
	_lobi_yayinla()


func oyunu_baslat():
	if not sunucu_mu() or oyun_basladi or yuvalar.size() < 2:
		return
	if cevrimdisi_oda:
		_globali_doldur()
		cevrimdisi_oda = false
		get_tree().change_scene_to_file("res://node_2d.tscn")
		return
	oyun_basladi = true
	hazir_peerler.clear()
	_oyunu_baslat_rpc.rpc(yuvalar, oyun_ayarlari)


# ----------------------------------------------------------
# ODA ARAMA VE KATILMA (istemci)
# ----------------------------------------------------------
func oda_aramaya_basla():
	oda_aramayi_durdur()
	bulunan_odalar.clear()
	_dinleyici = PacketPeerUDP.new()
	if _dinleyici.bind(KESIF_PORTU) != OK:
		_dinleyici = null
		durum_mesaji.emit("Otomatik oda arama başlatılamadı. IP adresiyle bağlanmayı dene.")
	odalar_degisti.emit()


func oda_aramayi_durdur():
	if _dinleyici:
		_dinleyici.close()
	_dinleyici = null


func katil(ip: String) -> bool:
	ip = ip.strip_edges()
	if not ip.is_valid_ip_address():
		durum_mesaji.emit("Geçersiz IP adresi: " + ip)
		return false
	oda_aramayi_durdur()
	ayril()
	var peer := ENetMultiplayerPeer.new()
	if peer.create_client(ip, OYUN_PORTU) != OK:
		durum_mesaji.emit("Bağlantı başlatılamadı.")
		return false
	multiplayer.multiplayer_peer = peer
	online = true
	_baglaniyor = true
	_baglanma_suresi = 0.0
	durum_mesaji.emit("Bağlanılıyor: " + ip + " ...")
	return true


func ayril():
	_baglaniyor = false
	cevrimdisi_oda = false
	_bekleyen_komutlar.clear()
	var eski_online := online
	online = false
	oyun_basladi = false
	yeniden_baglaniyor = false
	yuvalar = []
	yerel_indeks = -1
	hazir_peerler.clear()
	if _yayinci:
		_yayinci.close()
	_yayinci = null
	if eski_online and multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()


# Ağ hatasıyla oyundan düşüldüğünde ana menüye dön
func menuye_don(mesaj: String):
	son_mesaj = mesaj
	ayril()
	get_tree().paused = false
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://ana_menu.tscn")


func yerel_ipler() -> Array:
	var sonuc := []
	var sanal := []   # VirtualBox gibi sanal ağ bağdaştırıcıları sona
	for ip in IP.get_local_addresses():
		if ip.count(".") != 3 or ip.begins_with("127.") or ip.begins_with("169.254."):
			continue
		if ip.begins_with("192.168.56."):
			sanal.append(ip)
		else:
			sonuc.append(ip)
	return sonuc + sanal


# Oyun sahnesi yüklenince çağrılır
func sahne_hazir():
	if not online:
		return
	if multiplayer.is_server():
		hazir_peerler[1] = true
		oyuncu_sahneye_hazir.emit(1)
	else:
		_sahne_hazir_rpc.rpc_id(1)


func peer_indeksi(peer_id: int) -> int:
	for i in yuvalar.size():
		if yuvalar[i]["peer"] == peer_id and not yuvalar[i]["bot"]:
			return i
	return -1


# ----------------------------------------------------------
# OYUN KOMUTLARI
# Oyun mesajları her zaman var olan bu düğüm üzerinden gider. Böylece
# karşı tarafta oyun sahnesi henüz yüklenmemişse "Node not found" hatası
# oluşmaz; komut sahne hazır olunca işlenir.
# ----------------------------------------------------------
func oyun_sahnesi_kaydet(sahne: Node):
	oyun_sahnesi = sahne
	var liste := _bekleyen_komutlar
	_bekleyen_komutlar = []
	for k in liste:
		sahne.call("_komutu_uygula", k[0], k[1])


func oyun_komutu_yayinla(ad: String, args: Array):
	_oyun_komutu.rpc(ad, args)


func oyun_komutu_gonder(peer_id: int, ad: String, args: Array):
	_oyun_komutu.rpc_id(peer_id, ad, args)


func oyun_istegi_gonder(ad: String, args: Array):
	_oyun_istegi.rpc_id(1, ad, args)


func _sahne_gecerli_mi() -> bool:
	return is_instance_valid(oyun_sahnesi) and oyun_sahnesi.is_inside_tree()


@rpc("authority", "call_local", "reliable")
func _oyun_komutu(ad: String, args: Array):
	if not online or not oyun_basladi:
		return
	if _sahne_gecerli_mi():
		oyun_sahnesi.call("_komutu_uygula", ad, args)
	else:
		_bekleyen_komutlar.append([ad, args])


@rpc("any_peer", "call_remote", "reliable")
func _oyun_istegi(ad: String, args: Array):
	if not sunucu_mu() or not _sahne_gecerli_mi():
		return
	oyun_sahnesi.call("_komut_istegi_isle", multiplayer.get_remote_sender_id(), ad, args)


# ----------------------------------------------------------
# DÖNGÜ: oda yayını ve oda dinleme
# ----------------------------------------------------------
func _process(delta):
	if _baglaniyor:
		_baglanma_suresi += delta
		if _baglanma_suresi > BAGLANMA_ZAMAN_ASIMI:
			ayril()
			durum_mesaji.emit("Bağlanılamadı. Aynı Wi-Fi ağında olduğunuzdan ve IP adresinin doğru olduğundan emin ol.")

	if _yayinci and sunucu_mu():
		_yayin_sayaci -= delta
		if _yayin_sayaci <= 0.0:
			_yayin_sayaci = 1.0
			_yayin_yap()

	if _dinleyici:
		var degisti := false
		while _dinleyici.get_available_packet_count() > 0:
			var paket := _dinleyici.get_packet()
			var ip := _dinleyici.get_packet_ip()
			var veri = JSON.parse_string(paket.get_string_from_utf8())
			if typeof(veri) == TYPE_DICTIONARY and veri.get("oyun", "") == OYUN_KIMLIGI and int(veri.get("surum", 0)) == SURUM:
				bulunan_odalar[ip] = {
					"oda": str(veri.get("oda", "?")),
					"kisi": int(veri.get("kisi", 0)),
					"basladi": bool(veri.get("basladi", false)),
					"zaman": Time.get_ticks_msec()
				}
				degisti = true
		var simdi := Time.get_ticks_msec()
		for ip in bulunan_odalar.keys():
			if simdi - int(bulunan_odalar[ip]["zaman"]) > 4000:
				bulunan_odalar.erase(ip)
				degisti = true
		if degisti:
			odalar_degisti.emit()


func _yayin_yap():
	var veri := JSON.stringify({
		"oyun": OYUN_KIMLIGI,
		"surum": SURUM,
		"oda": yuvalar[0]["isim"] if yuvalar.size() > 0 else "Oda",
		"kisi": yuvalar.size(),
		"basladi": oyun_basladi
	}).to_utf8_buffer()
	var hedefler := ["255.255.255.255"]
	for ip in yerel_ipler():
		var p: PackedStringArray = ip.split(".")
		hedefler.append(p[0] + "." + p[1] + "." + p[2] + ".255")
	for hedef in hedefler:
		_yayinci.set_dest_address(hedef, KESIF_PORTU)
		_yayinci.put_packet(veri)


# ----------------------------------------------------------
# BAĞLANTI OLAYLARI
# ----------------------------------------------------------
func _on_peer_connected(_id: int):
	pass  # Katılım, istemci _katil_istegi gönderince işlenir


func _on_peer_disconnected(id: int):
	if not sunucu_mu():
		return
	hazir_peerler.erase(id)
	var i := peer_indeksi(id)
	if i == -1:
		return
	if oyun_basladi:
		yuvalar[i]["bagli"] = false
		yuvalar[i]["peer"] = 0
		oyuncu_dustu.emit(i)
	else:
		yuvalar.remove_at(i)
		_lobi_yayinla()


func _on_connected_to_server():
	_baglaniyor = false
	_katil_istegi.rpc_id(1, _isim_temizle(profil["isim"]), int(profil["araba"]), int(profil["renk"]), SURUM)


func _on_connection_failed():
	if not online:
		return
	ayril()
	durum_mesaji.emit("Bağlanılamadı. Oda kapanmış ya da IP adresi yanlış olabilir.")


func _on_server_disconnected():
	if not online:
		return
	menuye_don("Oda sahibiyle bağlantı koptu.")


# ----------------------------------------------------------
# RPC'LER
# ----------------------------------------------------------
@rpc("any_peer", "call_remote", "reliable")
func _katil_istegi(isim, araba, renk, surum):
	if not sunucu_mu():
		return
	var peer_id := multiplayer.get_remote_sender_id()
	isim = _isim_temizle(str(isim))
	if int(surum) != SURUM:
		_reddet(peer_id, "Oyun sürümleri farklı. Herkes oyunun aynı sürümünü kullanmalı.")
		return

	if oyun_basladi:
		# Kopan oyuncu aynı isimle geri dönebilir
		for i in yuvalar.size():
			var y = yuvalar[i]
			if not y["bot"] and not y["bagli"] and str(y["isim"]).to_lower() == isim.to_lower():
				y["peer"] = peer_id
				y["bagli"] = true
				_yeniden_katil_rpc.rpc_id(peer_id, yuvalar, i, oyun_ayarlari)
				oyuncu_geri_dondu.emit(i, peer_id)
				return
		_reddet(peer_id, "Bu odada oyun başladı. Oyundan koptuysan aynı isimle tekrar katıl.")
		return

	if yuvalar.size() >= MAKS_OYUNCU:
		_reddet(peer_id, "Oda dolu (en fazla %d oyuncu)." % MAKS_OYUNCU)
		return

	var temel = isim
	var no := 2
	while _isim_var_mi(isim):
		isim = temel + " " + str(no)
		no += 1
	var renk_indeksi := int(renk)
	if renk_indeksi < 0 or renk_indeksi >= RENKLER.size() or _renk_kullaniliyor(renk_indeksi):
		renk_indeksi = _bos_renk()
	yuvalar.append(_yuva_olustur(peer_id, isim, clampi(int(araba), 0, ARABA_SAYISI - 1), renk_indeksi, false))
	_lobi_yayinla()


@rpc("any_peer", "call_remote", "reliable")
func _secim_istegi(araba, renk):
	if not sunucu_mu() or oyun_basladi:
		return
	_secimi_uygula(multiplayer.get_remote_sender_id(), int(araba), int(renk))


@rpc("authority", "call_remote", "reliable")
func _reddedildi(mesaj: String):
	ayril()
	durum_mesaji.emit(mesaj)


@rpc("authority", "call_local", "reliable")
func _lobi_guncelle(liste: Array, ayarlar: Dictionary):
	yuvalar = liste
	oyun_ayarlari = ayarlar
	_yerel_indeksi_bul()
	lobi_degisti.emit()


@rpc("authority", "call_local", "reliable")
func _oyunu_baslat_rpc(liste: Array, ayarlar: Dictionary):
	yuvalar = liste
	oyun_ayarlari = ayarlar
	_yerel_indeksi_bul()
	oyun_basladi = true
	yeniden_baglaniyor = false
	_bekleyen_komutlar.clear()
	oyun_sahnesi = null
	_globali_doldur()
	oda_aramayi_durdur()
	get_tree().change_scene_to_file("res://node_2d.tscn")


@rpc("authority", "call_remote", "reliable")
func _yeniden_katil_rpc(liste: Array, indeks: int, ayarlar: Dictionary):
	yuvalar = liste
	oyun_ayarlari = ayarlar
	yerel_indeks = indeks
	oyun_basladi = true
	yeniden_baglaniyor = true
	_bekleyen_komutlar.clear()
	oyun_sahnesi = null
	_globali_doldur()
	oda_aramayi_durdur()
	get_tree().change_scene_to_file("res://node_2d.tscn")


@rpc("any_peer", "call_remote", "reliable")
func _sahne_hazir_rpc():
	if not sunucu_mu():
		return
	var id := multiplayer.get_remote_sender_id()
	hazir_peerler[id] = true
	oyuncu_sahneye_hazir.emit(id)


# ----------------------------------------------------------
# YARDIMCILAR
# ----------------------------------------------------------
func _lobi_yayinla():
	if cevrimdisi_oda:
		lobi_degisti.emit()
		return
	_lobi_guncelle.rpc(yuvalar, oyun_ayarlari)


func _reddet(peer_id: int, mesaj: String):
	_reddedildi.rpc_id(peer_id, mesaj)
	await get_tree().create_timer(0.5).timeout
	if online and multiplayer.multiplayer_peer is ENetMultiplayerPeer:
		multiplayer.multiplayer_peer.disconnect_peer(peer_id)


func _yerel_indeksi_bul():
	yerel_indeks = -1
	var benim := multiplayer.get_unique_id()
	for i in yuvalar.size():
		if yuvalar[i]["peer"] == benim and not yuvalar[i]["bot"]:
			yerel_indeks = i


func _globali_doldur():
	Global.oyuncu_sayisi = yuvalar.size()
	for i in range(4):
		if i < yuvalar.size():
			var y = yuvalar[i]
			Global.oyuncu_ayarlari[i] = {
				"isim": y["isim"],
				"araba_indeksi": int(y["araba"]),
				"renk": RENKLER[int(y["renk"])]
			}
		else:
			Global.oyuncu_ayarlari[i] = {"isim": "Oyuncu " + str(i + 1), "araba_indeksi": 0, "renk": RENKLER[i]}


func _yuva_olustur(peer_id: int, isim: String, araba: int, renk: int, bot: bool) -> Dictionary:
	return {"peer": peer_id, "isim": isim, "araba": araba, "renk": renk, "bot": bot, "bagli": true}


func _isim_temizle(isim: String) -> String:
	isim = isim.strip_edges()
	if isim == "":
		isim = "Oyuncu"
	if isim.length() > 14:
		isim = isim.substr(0, 14)
	return isim


func _isim_var_mi(isim: String) -> bool:
	for y in yuvalar:
		if str(y["isim"]).to_lower() == isim.to_lower():
			return true
	return false


func _renk_kullaniliyor(renk: int) -> bool:
	for y in yuvalar:
		if int(y["renk"]) == renk:
			return true
	return false


func _bos_renk() -> int:
	for i in RENKLER.size():
		if not _renk_kullaniliyor(i):
			return i
	return 0
