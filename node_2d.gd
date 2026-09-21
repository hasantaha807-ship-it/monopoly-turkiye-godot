extends Node2D

# --- ARAYÜZ BAĞLANTILARI ---
@onready var tapu_karti = $Arayuz/TapuKarti
@onready var renk_bandi = $Arayuz/TapuKarti/RenkBandi
@onready var sehir_adi_etiketi = $Arayuz/TapuKarti/RenkBandi/SehirAdi
@onready var detay_yazisi = $Arayuz/TapuKarti/DetayYazisi
@onready var sayac_etiketi = $Arayuz/TapuKarti/ColorRect/Sayac
@onready var bakiye_etiketi = $Arayuz/OyuncuPaneli/ScrollContainer/BakiyeYazisi 
@onready var karar_timer = $Arayuz/TapuKarti/KararTimer
@onready var satin_al_butonu = $Arayuz/TapuKarti/SatinAlButonu
@onready var pas_gec_butonu = $Arayuz/TapuKarti/PasGecButonu
@onready var path_2d = $Path2D

@onready var bildirim_paneli = $Arayuz/BildirimPaneli
@onready var bildirim_yazisi = $Arayuz/BildirimPaneli/BildirimYazisi
@onready var tamam_butonu = $Arayuz/BildirimPaneli/TamamButonu

@onready var oyun_bitti_paneli = $Arayuz/OyunBittiPaneli
@onready var kazanan_yazisi = $Arayuz/OyunBittiPaneli/KazananYazisi
@onready var yeniden_baslat_butonu = $Arayuz/OyunBittiPaneli/YenidenBaslatButonu

@onready var yukseltme_paneli = $Arayuz/YukseltmePaneli
@onready var soru_yazisi = $Arayuz/YukseltmePaneli/SoruYazisi
@onready var evet_butonu = $Arayuz/YukseltmePaneli/EvetButonu
@onready var hayir_butonu = $Arayuz/YukseltmePaneli/HayirButonu

@onready var sans_karti_paneli = $Arayuz/SansKartiPaneli
@onready var olay_yazisi = $Arayuz/SansKartiPaneli/OlayYazisi
@onready var karti_kapat_butonu = $Arayuz/SansKartiPaneli/KartiKapatButonu

@onready var hapishane_paneli = $Arayuz/HapishanePaneli
@onready var hapis_yazisi = $Arayuz/HapishanePaneli/HapisYazisi
@onready var kefalet_butonu = $Arayuz/HapishanePaneli/KefaletButonu
@onready var yat_butonu = $Arayuz/HapishanePaneli/YatButonu

@onready var zar_paneli = $Arayuz/ZarPaneli
@onready var zar_gorseli = $Arayuz/ZarPaneli/ZarGorseli
@onready var ekstra_zar_gorseli = $Arayuz/ZarPaneli/EkstraZarGorseli
@onready var kira_etiketleri = $KiraEtiketleri

@onready var satis_paneli = $Arayuz/SatisPaneli
@onready var mulk_listesi = $Arayuz/SatisPaneli/MulkListesi
@onready var sat_butonu = $Arayuz/SatisPaneli/SatButonu
@onready var ihaleye_cikar_butonu = $Arayuz/SatisPaneli/IhaleyeCikarButonu 

@onready var ihale_paneli = $Arayuz/IhalePaneli
@onready var ihale_baslik = $Arayuz/IhalePaneli/BaslikYazisi
@onready var ihale_mulk_bilgisi = $Arayuz/IhalePaneli/MulkBilgisi
@onready var ihale_durum_yazisi = $Arayuz/IhalePaneli/DurumYazisi
@onready var ihale_timer = $Arayuz/IhalePaneli/IhaleTimer
@onready var sure_yazisi = $Arayuz/IhalePaneli/SureYazisi
@onready var teklif_butonu = $Arayuz/IhalePaneli/TeklifButonu
@onready var pas_butonu = $Arayuz/IhalePaneli/PasButonu

@onready var zar_secim_paneli = $Arayuz/ZarSecimPaneli
@onready var normal_zar_butonu = $Arayuz/ZarSecimPaneli/NormalZarButonu
@onready var taktiksel_zar_butonu = $Arayuz/ZarSecimPaneli/TaktikselZarButonu

@onready var piyon_kirmizi = $Path2D/KirmiziPiyon
@onready var piyon_mavi = $Path2D/MaviPiyon
@onready var piyon_sari = $Path2D/SariPiyon
@onready var piyon_yesil = $Path2D/YesilPiyon

# --- SES BAĞLANTILARI ---
@onready var muzik_calar = $MuzikCalar
@onready var zar_sesi_player = $ZarSesi
@onready var para_sesi_player = $ParaSesi
@onready var sans_karti_sesi_player = $SansKartiSesi

var toplam_kare_sayisi = 23
var hareket_ediyor = false 
var tur_maasi = 200
var ev_ikonu = preload("res://Arabalar/ev.png")       # Kendi ev.png dosyanın adını ve yolunu yaz
var plaza_ikonu = preload("res://Arabalar/plaza.png") # Kendi plaza.png dosyanın adını ve yolunu yaz

# YENİ: Haritada arabaları yüklemek için kaplama listemiz
var araba_kaplamalari = [
	preload("res://Arabalar/porsche.png"),
	preload("res://Arabalar/vosvos.png"),
	preload("res://Arabalar/f1.png"),
	preload("res://Arabalar/jeep.png"),
	preload("res://Arabalar/kamyonet.png")
]

var harita_sirasi = [
	"Baslangic", "Samsun", "Trabzon", "Sivas", "Kastamonu", 
	"Sinop", "Sans_Karti", "Bayburt", "Kars", "Ordu", 
	"Konya", "Hapishane", "Sakarya", "Eskisehir", "Sans_Karti", 
	"Adana", "Gaziantep", "Kocaeli", "Bursa", "Adiyaman", 
	"Sans_Karti", "Ankara", "Istanbul"
]

var oyuncular = []
var aktif_oyuncu_indeksi = 0 
var mülkiyet_durumu = {} 
var bekleyen_kira = {"aktif": false, "odeyen": -1, "alan": -1, "miktar": 0}
var bekleyen_sans_karti_degeri = 0 

var ihale_suresi = 8
var ihale_aktif = false
var ihale_verileri = {"sehir": "", "guncel_teklif": 0, "kazanan_indeks": -1, "satici": -1, "cekilenler": []}

var sehirler = {
	"Samsun": {"fiyat": 180, "baslangic_kirasi": 40, "renk": Color(0.8, 0.4, 0.6)},
	"Trabzon": {"fiyat": 160, "baslangic_kirasi": 35, "renk": Color(0.8, 0.4, 0.6)},
	"Sivas": {"fiyat": 140, "baslangic_kirasi": 30, "renk": Color(0.4, 0.8, 0.9)},
	"Kastamonu": {"fiyat": 120, "baslangic_kirasi": 25, "renk": Color(0.4, 0.8, 0.9)},
	"Sinop": {"fiyat": 100, "baslangic_kirasi": 20, "renk": Color(0.4, 0.8, 0.9)},
	"Bayburt": {"fiyat": 80, "baslangic_kirasi": 15, "renk": Color(0.5, 0.3, 0.2)},
	"Kars": {"fiyat": 60, "baslangic_kirasi": 10, "renk": Color(0.5, 0.3, 0.2)},
	"Ordu": {"fiyat": 80, "baslangic_kirasi": 15, "renk": Color(0.9, 0.6, 0.2)},
	"Konya": {"fiyat": 220, "baslangic_kirasi": 50, "renk": Color(0.9, 0.6, 0.2)},
	"Sakarya": {"fiyat": 240, "baslangic_kirasi": 55, "renk": Color(0.8, 0.2, 0.2)},
	"Eskisehir": {"fiyat": 260, "baslangic_kirasi": 60, "renk": Color(0.8, 0.2, 0.2)},
	"Adana": {"fiyat": 280, "baslangic_kirasi": 65, "renk": Color(0.8, 0.2, 0.2)},
	"Gaziantep": {"fiyat": 300, "baslangic_kirasi": 70, "renk": Color(0.9, 0.8, 0.2)},
	"Kocaeli": {"fiyat": 320, "baslangic_kirasi": 75, "renk": Color(0.9, 0.8, 0.2)},
	"Bursa": {"fiyat": 350, "baslangic_kirasi": 80, "renk": Color(0.2, 0.6, 0.3)},
	"Adiyaman": {"fiyat": 400, "baslangic_kirasi": 150, "renk": Color(0.2, 0.6, 0.3)},
	"Ankara": {"fiyat": 450, "baslangic_kirasi": 100, "renk": Color(0.2, 0.4, 0.8)},
	"Istanbul": {"fiyat": 500, "baslangic_kirasi": 120, "renk": Color(0.2, 0.4, 0.8)}
}

func _para_sesini_tek_cal():
	if para_sesi_player:
		para_sesi_player.stop() 
		para_sesi_player.play(0) 

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	tapu_karti.hide()
	bildirim_paneli.hide()
	oyun_bitti_paneli.hide()
	yukseltme_paneli.hide()
	sans_karti_paneli.hide()
	hapishane_paneli.hide()
	zar_paneli.hide()
	satis_paneli.hide()
	ihale_paneli.hide()
	zar_secim_paneli.hide()
	
	oyuncular = [
		{"isim": "Oyuncu 1", "para": 1500, "konum": 0, "renk": Color.RED, "piyon": piyon_kirmizi, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": false, "aktif_mi": true},
		{"isim": "Bot 1", "para": 1500, "konum": 0, "renk": Color.BLUE, "piyon": piyon_mavi, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": true, "aktif_mi": true},
		{"isim": "Bot 2", "para": 1500, "konum": 0, "renk": Color.YELLOW, "piyon": piyon_sari, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": true, "aktif_mi": true},
		{"isim": "Bot 3", "para": 1500, "konum": 0, "renk": Color.GREEN, "piyon": piyon_yesil, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": true, "aktif_mi": true}
	]
	if Global.oyuncu_sayisi == 2:
		oyuncular[2]["aktif_mi"] = false
		oyuncular[2]["piyon"].hide()
		oyuncular[3]["aktif_mi"] = false
		oyuncular[3]["piyon"].hide()
	elif Global.oyuncu_sayisi == 3:
		oyuncular[3]["aktif_mi"] = false
		oyuncular[3]["piyon"].hide()
		
	# DİKKAT: For döngüsünü bir sekme (Tab) sola, if ve elif ile aynı hizaya çektik!
	# --- YENİ: BÜTÜN PİYONLARI (GİZLİ OLSALAR BİLE) ZORLA ARABAYA ÇEVİR ---
	for i in range(4):
		var ayarlar = Global.oyuncu_ayarlari[i]
		oyuncular[i]["isim"] = ayarlar["isim"]
		oyuncular[i]["renk"] = ayarlar["renk"]
		
		var p = oyuncular[i]["piyon"]
		var araba_sprite = null
		
		# Piyonun içindeki Sprite2D'yi bul
		for alt_dugum in p.get_children():
			if alt_dugum is Sprite2D:
				araba_sprite = alt_dugum
				break
		
		# Bulduğu an acımadan arabaya çevir ve sağa döndür
		if araba_sprite != null:
			araba_sprite.texture = araba_kaplamalari[ayarlar["araba_indeksi"]]
			araba_sprite.modulate = ayarlar["renk"]
			araba_sprite.scale = Vector2(0.18, 0.18)
			araba_sprite.rotation_degrees = 90
	
	arayuzu_guncelle()
	
	var buton_baglantilari = [
		[satin_al_butonu, _on_satin_al_basildi],
		[pas_gec_butonu, _on_pas_gec_basildi],
		[tamam_butonu, _on_tamam_basildi],
		[yeniden_baslat_butonu, _on_yeniden_baslat_basildi],
		[evet_butonu, _on_evet_basildi],
		[hayir_butonu, _on_hayir_basildi],
		[karti_kapat_butonu, _on_karti_kapat_basildi],
		[kefalet_butonu, _on_kefalet_basildi],
		[yat_butonu, _on_yat_basildi],
		[sat_butonu, _on_sat_butonu_basildi],
		[ihaleye_cikar_butonu, _on_ihaleye_cikar_basildi],
		[teklif_butonu, _on_teklif_butonu_basildi],
		[pas_butonu, _on_pas_butonu_basildi],
		[normal_zar_butonu, _on_normal_zar_basildi],
		[taktiksel_zar_butonu, _on_taktiksel_zar_basildi]
	]
	
	for baglanti in buton_baglantilari:
		if baglanti[0]:
			for c in baglanti[0].pressed.get_connections():
				baglanti[0].pressed.disconnect(c.callable)
			baglanti[0].pressed.connect(baglanti[1])
			
	if karar_timer:
		for c in karar_timer.timeout.get_connections():
			karar_timer.timeout.disconnect(c.callable)
		karar_timer.timeout.connect(_on_sure_bitti)
		
	if ihale_timer:
		for c in ihale_timer.timeout.get_connections():
			ihale_timer.timeout.disconnect(c.callable)
		ihale_timer.timeout.connect(_on_ihale_timer_timeout)
	
	# ... (diğer timer ve buton bağlantıları)
	if ihale_timer:
		for c in ihale_timer.timeout.get_connections():
			ihale_timer.timeout.disconnect(c.callable)
		ihale_timer.timeout.connect(_on_ihale_timer_timeout)
	
	# YENİ EKLENEN SATIR: Oyun başlar başlamaz başlangıç karesindeki arabaları yan yana diz
	piyonlarin_konumlarini_duzenle()
	
	siradaki_turu_baslat()
	# TEST KODU: Oyun başlar başlamaz 10. kareye (Konya) Kırmızı bir Gökdelen (Seviye 4) diker
	
func _process(_delta):
	if !karar_timer.is_stopped():
		sayac_etiketi.text = str(int(karar_timer.time_left))

func arayuzu_guncelle():
	var bakiye_metni = ""
	
	for i in range(Global.oyuncu_sayisi):
		var o = oyuncular[i]
		if o["aktif_mi"]:
			# Oyuncunun rengini metin rengi (Hex) koduna çeviriyoruz (Örn: #ff5959)
			var hex_renk = o["renk"].to_html(false) 
			
			if i == aktif_oyuncu_indeksi:
				bakiye_metni += "[b][color=#" + hex_renk + "]▶ " + o["isim"] + " : " + str(o["para"]) + " ₺[/color][/b]\n\n"
			else:
				bakiye_metni += "[color=#" + hex_renk + "]   " + o["isim"] + " : " + str(o["para"]) + " ₺[/color]\n\n"
				
	if bakiye_etiketi:
		bakiye_etiketi.text = bakiye_metni

func sirayi_sonraki_oyuncuya_gecir():
	var dongu_korumasi = 0
	while dongu_korumasi < 4:
		aktif_oyuncu_indeksi = (aktif_oyuncu_indeksi + 1) % 4 
		if oyuncular[aktif_oyuncu_indeksi]["aktif_mi"]:
			break
		dongu_korumasi += 1
		
	arayuzu_guncelle()
	zar_paneli.hide() 
	siradaki_turu_baslat()

func siradaki_turu_baslat():
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	
	if o_oyuncu["hapiste_mi"] and o_oyuncu["hapis_turu"] == 2:
		o_oyuncu["hapiste_mi"] = false
		o_oyuncu["hapis_turu"] = 0
		
	if o_oyuncu["hapiste_mi"]:
		zar_at_ve_ilerle(false)
	else:
		if o_oyuncu["yapay_zeka"]:
			ai_hamle_yap()
		else:
			if o_oyuncu["para"] < 100:
				taktiksel_zar_butonu.disabled = true
			else:
				taktiksel_zar_butonu.disabled = false
			zar_secim_paneli.show()

func _on_normal_zar_basildi():
	if not zar_secim_paneli.visible: return
	zar_secim_paneli.hide()
	zar_at_ve_ilerle(false)

func _on_taktiksel_zar_basildi():
	if not zar_secim_paneli.visible: return
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	if o_oyuncu["para"] >= 100:
		o_oyuncu["para"] -= 100
		arayuzu_guncelle()
		zar_secim_paneli.hide()
		zar_at_ve_ilerle(true)

func ai_hamle_yap():
	await get_tree().create_timer(1.0).timeout 
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	var ekstra_zar_kullan = false
	
	if not o_oyuncu["hapiste_mi"] and o_oyuncu["para"] > 800:
		if randi() % 100 < 30:
			o_oyuncu["para"] -= 100
			ekstra_zar_kullan = true
			arayuzu_guncelle()
			
	zar_at_ve_ilerle(ekstra_zar_kullan)

func zar_at_ve_ilerle(ekstra_zar: bool):
	if hareket_ediyor or tapu_karti.visible or bildirim_paneli.visible or oyun_bitti_paneli.visible or yukseltme_paneli.visible or sans_karti_paneli.visible or hapishane_paneli.visible or satis_paneli.visible or ihale_paneli.visible:
		return
		
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	
	if o_oyuncu["hapiste_mi"]:
		if o_oyuncu["hapis_turu"] == 1:
			hapis_yazisi.text = o_oyuncu["isim"] + " OYUNCUSU HAPİSTESİN!\n\n300 TL kefalet ödeyip hemen zarı atabilir veya 1 tur içeride yatabilirsin."
			kefalet_butonu.text = "300 TL\nKefalet Öde"
			# YENİ: Bot hapisteyken butonlar kitlenir
			kefalet_butonu.disabled = o_oyuncu["yapay_zeka"]
			yat_butonu.disabled = o_oyuncu["yapay_zeka"]
			kefalet_butonu.show()
			hapishane_paneli.show()
			if o_oyuncu["yapay_zeka"]:
				await get_tree().create_timer(2.0).timeout
				if o_oyuncu["para"] >= 300:
					_on_kefalet_basildi()
				else:
					_on_yat_basildi()
			return
			
	zari_at_ve_hareketi_baslat(o_oyuncu, ekstra_zar)

func zari_at_ve_hareketi_baslat(o_oyuncu, ekstra_zar: bool):
	hareket_ediyor = true
	
	# 1. Zarların kaç geleceğini hesapla
	var zar1 = randi_range(1, 6)
	var zar2 = 0
	if ekstra_zar:
		zar2 = randi_range(1, 3)
		
	var toplam_zar = zar1 + zar2
	
	# 2. Zar panellerini görünür yap
	zar_paneli.show()
	zar_gorseli.show()
	if ekstra_zar:
		ekstra_zar_gorseli.show()
	else:
		ekstra_zar_gorseli.hide()
		
	# 3. Zarların final resimlerini (sayılarını) ekrana bas
	var zar_kareleri = {6: 0, 5: 1, 4: 2, 3: 3, 2: 4, 1: 5} 
	zar_gorseli.frame = zar_kareleri[zar1]
	if ekstra_zar:
		ekstra_zar_gorseli.frame = zar_kareleri[zar2]
		
	# 4. İŞTE SİHİR BURADA: Eski takılan animasyon yerine bizim havalı animasyonu beklet!
	await zar_animasyonu_oynat()
	
	# 5. Animasyon bittikten sonra araba harekete başlasın
	var curve = path_2d.curve
	for i in range(toplam_zar):
		o_oyuncu["konum"] += 1
		var basa_sardi = false
	
		
		if o_oyuncu["konum"] >= toplam_kare_sayisi:
			o_oyuncu["konum"] = 0
			basa_sardi = true
			o_oyuncu["para"] += tur_maasi 
			arayuzu_guncelle()
			
		var guvenli_indeks = clampi(o_oyuncu["konum"], 0, curve.get_point_count() - 1)
		var hedef_pozisyon = curve.get_point_position(guvenli_indeks)
		var hedef_progress = curve.get_closest_offset(hedef_pozisyon)
		
		if basa_sardi:
			hedef_progress = curve.get_baked_length()
			
		var tween = create_tween()
		tween.tween_property(o_oyuncu["piyon"], "progress", hedef_progress, 0.25).set_trans(Tween.TRANS_SINE)
		await tween.finished 
		
		if basa_sardi:
			o_oyuncu["piyon"].progress = 0.0 
			
		await get_tree().create_timer(0.05).timeout
		
	hareket_ediyor = false
	piyonlarin_konumlarini_duzenle()
	var durulan_yer = harita_sirasi[o_oyuncu["konum"]]
	
	if durulan_yer == "Sans_Karti":
		sans_kartini_cek(o_oyuncu)
	elif durulan_yer == "Hapishane":
		o_oyuncu["hapiste_mi"] = true
		o_oyuncu["hapis_turu"] = 1
# ESKİ: bildirim_yazisi.text = "\n\nKODES BOYLADI!\n\nPolis çevirmesine takıldın. Doğruca hapishaneye gidiyorsun!"
		bildirim_yazisi.text = "[center]\n\n\n[font_size=20][b][color=#ff3333]KADER MAHKÛMU![/color][/b][/font_size]\n\nPolis çevirmesine takıldın. Doğruca hapishaneye gidiyorsun![/center]"		# YENİ: Bot hapise girdiğinde buton kilitlenir
		tamam_butonu.disabled = o_oyuncu["yapay_zeka"]
		bildirim_paneli.show()
		if o_oyuncu["yapay_zeka"]:
			await get_tree().create_timer(2.0).timeout
			_on_tamam_basildi()
			
	elif sehirler.has(durulan_yer):
		var fiyat = sehirler[durulan_yer]["fiyat"]
		if mülkiyet_durumu.has(durulan_yer):
			var sahip_indeksi = mülkiyet_durumu[durulan_yer]["sahip"]
			var mevcut_seviye = mülkiyet_durumu[durulan_yer]["seviye"]
			
			if sahip_indeksi == aktif_oyuncu_indeksi:
				if mevcut_seviye < 4:
					var yukseltme_bedeli = int(fiyat * [0.5, 0.75, 1.0, 1.5][mevcut_seviye])
					var sonraki_kira = int(fiyat * [0.5, 1.0, 1.5, 2.0][mevcut_seviye])
					
					soru_yazisi.text = "\n"+durulan_yer.to_upper() + " (Seviye " + str(mevcut_seviye) + ")\n\nYükseltmek ister misin?\nBedel: " + str(yukseltme_bedeli) + " TL\nYeni Kira: " + str(sonraki_kira) + " TL"
					# YENİ: Bot yükseltme düşünürken butonlar kilitlenir
					evet_butonu.disabled = o_oyuncu["yapay_zeka"]
					hayir_butonu.disabled = o_oyuncu["yapay_zeka"]
					yukseltme_paneli.show()
					
					if o_oyuncu["yapay_zeka"]:
						await get_tree().create_timer(1.5).timeout
						if o_oyuncu["para"] >= yukseltme_bedeli:
							_on_evet_basildi()
						else:
							_on_hayir_basildi()
				else:
					sirayi_sonraki_oyuncuya_gecir()
			else:
				var kira_bedeli = 0
				if mevcut_seviye == 0:
					kira_bedeli = sehirler[durulan_yer]["baslangic_kirasi"]
				else:
					kira_bedeli = int(fiyat * [0.5, 1.0, 1.5, 2.0][mevcut_seviye-1])
					
				bekleyen_kira = {"aktif": true, "odeyen": aktif_oyuncu_indeksi, "alan": sahip_indeksi, "miktar": kira_bedeli}
# ESKİ: bildirim_yazisi.text = "\nKİRA ÖDEMESİ!\n\n" + oyuncular[sahip_indeksi]["isim"] + " oyuncusuna ait " + durulan_yer.to_upper() + " şehrine bastın.\n\nÖdemen Gereken: " + str(kira_bedeli) + " TL\n\n(Tamam'a bastığında bakiyenden düşülecektir)"
				bildirim_yazisi.text = "[center]\n[b][color=#ffaa00]KİRA ÖDEMESİ![/color][/b]\n\n" + oyuncular[sahip_indeksi]["isim"] + " oyuncusuna ait " + durulan_yer.to_upper() + " şehrine bastın.\n\n[b]Ödemen Gereken: " + str(kira_bedeli) + " TL[/b]\n\n(Tamam'a bastığında bakiyenden düşülecektir)[/center]"				# YENİ: Bot kira öderken buton kilitlenir
				tamam_butonu.disabled = o_oyuncu["yapay_zeka"]
				bildirim_paneli.show()
				
				if o_oyuncu["yapay_zeka"]:
					await get_tree().create_timer(2.0).timeout
					_on_tamam_basildi()
		else:
			tapu_kartini_goster(durulan_yer)
	else:
		sirayi_sonraki_oyuncuya_gecir()

func sans_kartini_cek(oyuncu):
	var kartlar = [
		{"metin": "Burs yattı! 200 TL çektin.", "deger": 200},
		{"metin": "Radar cezası yedin! Polise 100 TL öde.", "deger": -100},
		{"metin": "Vergi İadesi! 150 TL kazandın.", "deger": 150},
		{"metin": "Telefon ekranı kırıldı. 150 TL öde.", "deger": -150}
	]
	var secilen = kartlar[randi() % kartlar.size()]
	
	bekleyen_sans_karti_degeri = secilen["deger"]
	
	olay_yazisi.text = "\nSÜRPRİZ!\n\n" + secilen["metin"]
	if (oyuncu["para"] + bekleyen_sans_karti_degeri) < 0:
		olay_yazisi.text += "\n\nDİKKAT: BAKİYEN EKSİYE DÜŞECEK!"
		
	if sans_karti_sesi_player:
		sans_karti_sesi_player.stop()
		sans_karti_sesi_player.play(0)
		
	# YENİ: Temiz kilit kontrolü
	karti_kapat_butonu.disabled = oyuncu["yapay_zeka"]
	sans_karti_paneli.show()
	
	if oyuncu["yapay_zeka"]:
		await get_tree().create_timer(2.5).timeout
		if sans_karti_paneli.visible:
			_on_karti_kapat_basildi()

func _on_karti_kapat_basildi():
	if not sans_karti_paneli.visible: return
	sans_karti_paneli.hide()
	
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	
	if bekleyen_sans_karti_degeri != 0:
		o_oyuncu["para"] += bekleyen_sans_karti_degeri
		_para_sesini_tek_cal()
		
	bekleyen_sans_karti_degeri = 0
	arayuzu_guncelle()
	
	if o_oyuncu["para"] < 0:
		borc_kontrolu()
	else:
		sirayi_sonraki_oyuncuya_gecir()

func _on_tamam_basildi():
	if not bildirim_paneli.visible: return
	bildirim_paneli.hide()
	
	if bekleyen_kira["aktif"]:
		var odeyen = oyuncular[bekleyen_kira["odeyen"]]
		var alan = oyuncular[bekleyen_kira["alan"]]
		
		odeyen["para"] -= bekleyen_kira["miktar"]
		alan["para"] += bekleyen_kira["miktar"]
		_para_sesini_tek_cal() 
		bekleyen_kira["aktif"] = false
		arayuzu_guncelle()
		
		if odeyen["para"] < 0:
			borc_kontrolu()
		else:
			sirayi_sonraki_oyuncuya_gecir()
		return
		
	if oyuncular[aktif_oyuncu_indeksi]["para"] < 0:
		borc_kontrolu()
	else:
		sirayi_sonraki_oyuncuya_gecir()

func borc_kontrolu():
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	var satilabilir_mulkler = satilabilir_mulkleri_getir(aktif_oyuncu_indeksi)
	
	if satilabilir_mulkler.size() == 0:
		satis_paneli.hide()
		ihale_paneli.hide()
		o_oyuncu["aktif_mi"] = false
		o_oyuncu["piyon"].hide() 
		
		var kalan = []
		for p in oyuncular:
			if p["aktif_mi"]:
				kalan.append(p)
				
		if kalan.size() == 1:
			kazanan_yazisi.text = "\nOYUN BİTTİ!\n\nŞAMPİYON: " + kalan[0]["isim"]
			oyun_bitti_paneli.show()
		else:
# ESKİ: bildirim_yazisi.text = o_oyuncu["isim"] + " İFLAS ETTİ!\n\n(Oyun 5 saniye içinde devam edecek...)"
			bildirim_yazisi.text = "[center]\n\n\n[font_size=20][b][color=#aa0000]" + o_oyuncu["isim"] + " İFLAS ETTİ![/color][/b][/font_size]\n\n(Oyun 5 saniye içinde devam edecek...)[/center]"
			tamam_butonu.hide()
			bildirim_paneli.show()
			
			await get_tree().create_timer(5.0).timeout
			
			bildirim_paneli.hide()
			tamam_butonu.show()
			sirayi_sonraki_oyuncuya_gecir()
	else:
		if o_oyuncu["yapay_zeka"]:
			ai_mulk_sat(satilabilir_mulkler) 
		else:
			satis_panelini_doldur(satilabilir_mulkler)
			satis_paneli.show()

func satilabilir_mulkleri_getir(o_indeks):
	var liste = []
	for sehir in mülkiyet_durumu.keys():
		if mülkiyet_durumu[sehir]["sahip"] == o_indeks:
			var f = sehirler[sehir]["fiyat"]
			var s = mülkiyet_durumu[sehir]["seviye"]
			var harcanan = f
			if s >= 1: harcanan += int(f * 0.50)
			if s >= 2: harcanan += int(f * 0.75)
			if s >= 3: harcanan += int(f * 1.00)
			if s >= 4: harcanan += int(f * 1.50)
			
			liste.append({"sehir_adi": sehir, "satis_bedeli": int(harcanan / 2)})
	return liste

func satis_panelini_doldur(satilabilir_liste):
	mulk_listesi.clear()
	for m in satilabilir_liste:
		mulk_listesi.add_item(m["sehir_adi"] + " (Banka: " + str(m["satis_bedeli"]) + " TL)")
		mulk_listesi.set_item_metadata(mulk_listesi.get_item_count() - 1, m["sehir_adi"])

func _on_sat_butonu_basildi():
	if not satis_paneli.visible: return
	var secili_index = mulk_listesi.selected
	if secili_index == -1: return
	var sehir_adi = mulk_listesi.get_item_metadata(secili_index)
	var bedel = 0
	
	for m in satilabilir_mulkleri_getir(aktif_oyuncu_indeksi): 
		if m["sehir_adi"] == sehir_adi:
			bedel = m["satis_bedeli"]
			
	mulku_bankaya_sat(sehir_adi, bedel)

func ai_mulk_sat(satilabilir_liste):
	await get_tree().create_timer(1.0).timeout
	_ihale_kurulumu_yap(satilabilir_liste[0]["sehir_adi"], satilabilir_liste[0]["satis_bedeli"])

func mulku_bankaya_sat(sehir_adi, satis_bedeli):
	oyuncular[aktif_oyuncu_indeksi]["para"] += satis_bedeli
	_para_sesini_tek_cal()
	var konum = harita_sirasi.find(sehir_adi)
	
	for i in range(5): 
		var ev_node = path_2d.get_node_or_null("Ev_" + str(konum) + "_" + str(i))
		if ev_node: ev_node.queue_free()
		
	mülkiyet_durumu.erase(sehir_adi)
	haritadaki_kirayi_guncelle(sehir_adi, 0)
	arayuzu_guncelle()
	
	if oyuncular[aktif_oyuncu_indeksi]["para"] < 0:
		borc_kontrolu()
	else:
		satis_paneli.hide()
		sirayi_sonraki_oyuncuya_gecir()

func _on_ihaleye_cikar_basildi():
	if not satis_paneli.visible: return
	var secili_index = mulk_listesi.selected
	if secili_index == -1: return
	var sehir = mulk_listesi.get_item_metadata(secili_index)
	var bedel = 0
	
	for m in satilabilir_mulkleri_getir(aktif_oyuncu_indeksi): 
		if m["sehir_adi"] == sehir:
			bedel = m["satis_bedeli"]
			
	_ihale_kurulumu_yap(sehir, bedel)

func _ihale_kurulumu_yap(sehir_adi, baslangic_fiyati):
	satis_paneli.hide()
	ihale_verileri["sehir"] = sehir_adi
	ihale_verileri["guncel_teklif"] = baslangic_fiyati
	ihale_verileri["kazanan_indeks"] = -1
	ihale_verileri["satici"] = aktif_oyuncu_indeksi
	ihale_verileri["cekilenler"].clear()
	
	ihale_mulk_bilgisi.text = "Satılan Mülk:\n" + sehir_adi.to_upper() + " (Başlangıç: " + str(baslangic_fiyati) + " TL)"
	ihale_durum_yazisi.text = "AÇIK ARTIRMA BAŞLADI!\nTeklifler bekleniyor..."
	ihale_suresi = 8
	sure_yazisi.text = "Kalan Süre: 8"
	
	teklif_butonu.show()
	pas_butonu.show()
	

	# YENİ VE DÜZELTİLMİŞ İHALE KİLİT SİSTEMİ
	# 1. Eğer insan oyuncu (0. indeks) ihaleyi YAPAN (satan) kişiyse VEYA iflas etmişse butonlar kitlenir.
	# 2. Eğer insan oyuncu hayattaysa ve ihaleye dışarıdan katılıyorsa butonlar açık kalır.
	if aktif_oyuncu_indeksi == 0 or oyuncular[0]["aktif_mi"] == false:
		teklif_butonu.disabled = true
		pas_butonu.disabled = true
	else:
		teklif_butonu.disabled = false
		pas_butonu.disabled = false
	ihale_paneli.show()
	ihale_aktif = true
	ihale_timer.start(1.0) 

func _on_ihale_timer_timeout():
	if not ihale_aktif: return
	ihale_suresi -= 1
	sure_yazisi.text = "Kalan Süre: " + str(ihale_suresi)
	
	if ihale_suresi > 0 and ihale_suresi <= 5: 
		var adaylar = []
		
		var ihaledeki_sehir = ihale_verileri["sehir"]
		var f = sehirler[ihaledeki_sehir]["fiyat"]
		var gercek_deger = f
		
		if mülkiyet_durumu.has(ihaledeki_sehir):
			var s = mülkiyet_durumu[ihaledeki_sehir]["seviye"]
			if s >= 1: gercek_deger += int(f * 0.50)
			if s >= 2: gercek_deger += int(f * 0.75)
			if s >= 3: gercek_deger += int(f * 1.00)
			if s >= 4: gercek_deger += int(f * 1.50)
		
		var maksimum_teklif_siniri = int(gercek_deger * 1.5)
		
		for i in range(1, 4):
			if oyuncular[i]["aktif_mi"] and i != ihale_verileri["satici"] and not ihale_verileri["cekilenler"].has(i) and i != ihale_verileri["kazanan_indeks"]:
				var verilecek_teklif = ihale_verileri["guncel_teklif"] + 50
				
				if oyuncular[i]["para"] >= verilecek_teklif and verilecek_teklif <= maksimum_teklif_siniri:
					adaylar.append(i)
				elif verilecek_teklif > maksimum_teklif_siniri:
					if not ihale_verileri["cekilenler"].has(i):
						ihale_verileri["cekilenler"].append(i)
					
		if adaylar.size() > 0:
			var sans = 25
			if ihale_suresi <= 3: sans = 50
			if ihale_suresi == 1: sans = 80
			if randi() % 100 < sans:
				_teklifi_artir(adaylar[randi() % adaylar.size()])
				
	if ihale_suresi <= 0:
		_ihale_sonuclandir()

func _on_teklif_butonu_basildi():
	if not ihale_paneli.visible: return
	if not oyuncular[0]["aktif_mi"]: return # İFLAS ETTİYSEN MÜDAHALE EDEMEZSİN!
	
	if oyuncular[0]["para"] >= ihale_verileri["guncel_teklif"] + 50:
		_teklifi_artir(0)
	else:
		sure_yazisi.text = "BAKİYE\nYETERSİZ!"

func _on_pas_butonu_basildi():
	if not ihale_paneli.visible: return
	if not oyuncular[0]["aktif_mi"]: return # İFLAS ETTİYSEN MÜDAHALE EDEMEZSİN!
	
	ihale_verileri["cekilenler"].append(0)
	teklif_butonu.disabled = true
	pas_butonu.disabled = true
	sure_yazisi.text = "İHALEDEN\nÇEKİLDİN"

func _teklifi_artir(veren_indeks):
	ihale_verileri["guncel_teklif"] += 50
	ihale_verileri["kazanan_indeks"] = veren_indeks
	ihale_suresi = 8
	sure_yazisi.text = "Kalan Süre: 8"
	ihale_durum_yazisi.text = oyuncular[veren_indeks]["isim"] + " teklifi " + str(ihale_verileri["guncel_teklif"]) + " TL'ye yükseltti!\nBaşka artıran var mı?"

func _ihale_sonuclandir():
	ihale_aktif = false
	ihale_timer.stop()
	teklif_butonu.hide()
	pas_butonu.hide()
	
	var s = ihale_verileri["sehir"]
	var k = ihale_verileri["kazanan_indeks"]
	var bedel = ihale_verileri["guncel_teklif"]
	var satici = oyuncular[ihale_verileri["satici"]]
	
	if k != -1:
		var alici = oyuncular[k]
		alici["para"] -= bedel
		satici["para"] += bedel
		_para_sesini_tek_cal() 
		mülkiyet_durumu[s]["sahip"] = k
		
		var konum = harita_sirasi.find(s)
		for i in range(5): 
			var ev_node = path_2d.get_node_or_null("Ev_" + str(konum) + "_" + str(i))
			if ev_node: ev_node.modulate = alici["renk"]
			
		ihale_durum_yazisi.text = "İHALE BİTTİ!\n\nSATILAN KİŞİ: " + alici["isim"] + "\nÖDENEN TUTAR: " + str(bedel) + " TL"
	else:
		satici["para"] += bedel
		var konum = harita_sirasi.find(s)
		for i in range(5): 
			var ev_node = path_2d.get_node_or_null("Ev_" + str(konum) + "_" + str(i))
			if ev_node: ev_node.queue_free()
			
		mülkiyet_durumu.erase(s)
		haritadaki_kirayi_guncelle(s, 0)
		ihale_durum_yazisi.text = "İHALE BİTTİ!\n\nKimse teklif vermedi.\nMülk bankaya iade edildi."
		
	arayuzu_guncelle()
	await get_tree().create_timer(3.0).timeout
	ihale_paneli.hide()
	
	if satici["para"] < 0:
		borc_kontrolu() 
	else:
		if ihale_verileri["satici"] == aktif_oyuncu_indeksi:
			sirayi_sonraki_oyuncuya_gecir()

func haritadaki_kirayi_guncelle(sehir_adi: String, yeni_seviye: int):
	if kira_etiketleri == null: return 
	var etiket = kira_etiketleri.get_node_or_null(sehir_adi)
	
	if etiket: 
		var fiyat = sehirler[sehir_adi]["fiyat"]
		var yeni_kira = 0
		if yeni_seviye == 0: yeni_kira = sehirler[sehir_adi]["baslangic_kirasi"]
		elif yeni_seviye == 1: yeni_kira = int(fiyat * 0.50)
		elif yeni_seviye == 2: yeni_kira = int(fiyat * 1.00)
		elif yeni_seviye == 3: yeni_kira = int(fiyat * 1.50)
		elif yeni_seviye == 4: yeni_kira = int(fiyat * 2.00)
		
		etiket.text = "Fiyat: " + str(fiyat) + " TL\nKira: " + str(yeni_kira) + " TL"

func _on_kefalet_basildi():
	if not hapishane_paneli.visible: return
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	if o_oyuncu["para"] >= 300:
		o_oyuncu["para"] -= 300
		_para_sesini_tek_cal() 
		o_oyuncu["hapiste_mi"] = false
		o_oyuncu["hapis_turu"] = 0
		arayuzu_guncelle()
		hapishane_paneli.hide()
		
		if o_oyuncu["yapay_zeka"]:
			ai_hamle_yap()
		else:
			if o_oyuncu["para"] < 100:
				taktiksel_zar_butonu.disabled = true
			else:
				taktiksel_zar_butonu.disabled = false
			zar_secim_paneli.show()
	else:
		hapis_yazisi.text = "YETERSİZ BAKİYE!\n\n300 TL kefalet ödeyecek paran yok!"
		kefalet_butonu.hide()
		
func _on_yat_basildi():
	if not hapishane_paneli.visible: return
	oyuncular[aktif_oyuncu_indeksi]["hapis_turu"] = 2
	hapishane_paneli.hide()
# ESKİ: bildirim_yazisi.text = "\nCEZANI ÇEKİYORSUN!\n\n\nBu turu hapiste yatarak geçiriyorsun."
	bildirim_yazisi.text = "[center]\n\n\n[font_size=20][b][color=#ff3333]CEZANI ÇEKİYORSUN![/color][/b][/font_size]\n\nBu turu hapiste yatarak geçiriyorsun.[/center]"	# YENİ: Bot hapiste yatmayı seçtiğinde de buton kilitlenir
	tamam_butonu.disabled = oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"]
	bildirim_paneli.show()
	
	if oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"]:
		await get_tree().create_timer(2.0).timeout
		_on_tamam_basildi()

func tapu_kartini_goster(sehir_anahtari: String):
	var f = sehirler[sehir_anahtari]["fiyat"]
	sehir_adi_etiketi.text = sehir_anahtari.to_upper()
	renk_bandi.color = sehirler[sehir_anahtari]["renk"]
	
	detay_yazisi.text = "Satın Alma Bedeli: %d TL\n\nBaşlangıç Kirası: %d TL\n1. Seviye Kira: %d TL\n2. Seviye Kira: %d TL\n3. Seviye Kira: %d TL\n4. Seviye Kira: %d TL" % [f, sehirler[sehir_anahtari]["baslangic_kirasi"], int(f * 0.50), int(f * 1.00), int(f * 1.50), int(f * 2.00)]
	
	karar_timer.start(15)
	
	# YENİ: Bot satınalma kararı verirken butonlar kilitlenir
	satin_al_butonu.disabled = oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"]
	pas_gec_butonu.disabled = oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"]
	tapu_karti.show()
	
	if oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"]:
		await get_tree().create_timer(1.0).timeout
		if oyuncular[aktif_oyuncu_indeksi]["para"] >= f:
			_on_satin_al_basildi()
		else:
			_on_pas_gec_basildi()

func _on_satin_al_basildi():
	if not tapu_karti.visible: return
	var o = oyuncular[aktif_oyuncu_indeksi]
	var dy = harita_sirasi[o["konum"]]
	var f = sehirler[dy]["fiyat"]
	
	if o["para"] >= f:
		o["para"] -= f
		_para_sesini_tek_cal() 
		mülkiyet_durumu[dy] = {"sahip": aktif_oyuncu_indeksi, "seviye": 0}
		arayuzu_guncelle()
		insaa_et_gorsel_ev(o["konum"], o["renk"], 0)
		tapu_karti.hide()
		karar_timer.stop()
		sirayi_sonraki_oyuncuya_gecir()

func _on_evet_basildi():
	if not yukseltme_paneli.visible: return
	var o = oyuncular[aktif_oyuncu_indeksi]
	var dy = harita_sirasi[o["konum"]]
	var m_s = mülkiyet_durumu[dy]["seviye"]
	var bedel = int(sehirler[dy]["fiyat"] * [0.5, 0.75, 1.0, 1.5][m_s])
	
	if o["para"] >= bedel:
		o["para"] -= bedel
		_para_sesini_tek_cal() 
		mülkiyet_durumu[dy]["seviye"] += 1
		haritadaki_kirayi_guncelle(dy, mülkiyet_durumu[dy]["seviye"])
		arayuzu_guncelle()
		insaa_et_gorsel_ev(o["konum"], o["renk"], mülkiyet_durumu[dy]["seviye"]) 
		yukseltme_paneli.hide()
		sirayi_sonraki_oyuncuya_gecir()
	else:
		yukseltme_paneli.hide()
		sirayi_sonraki_oyuncuya_gecir()

func _on_hayir_basildi():
	if not yukseltme_paneli.visible: return
	yukseltme_paneli.hide()
	sirayi_sonraki_oyuncuya_gecir()

func _on_pas_gec_basildi():
	if not tapu_karti.visible: return
	tapu_karti.hide()
	karar_timer.stop()
	sirayi_sonraki_oyuncuya_gecir()

func _on_sure_bitti():
	if not tapu_karti.visible: return
	tapu_karti.hide()
	sirayi_sonraki_oyuncuya_gecir()

func _on_yeniden_baslat_basildi():
	get_tree().reload_current_scene()

func insaa_et_gorsel_ev(indeks: int, renk: Color, ev_sirasi: int):
	# Eğer oyuncu 4. seviyeye (Plaza/Otel) ulaştıysa, önce arsadaki eski 4 küçük evi yık!
	if ev_sirasi == 4:
		for i in range(4):
			var eski_ev = path_2d.get_node_or_null("Ev_" + str(indeks) + "_" + str(i))
			if eski_ev:
				eski_ev.queue_free()
				
	var ev = Sprite2D.new()
	
	# Eğer 4. seviye ise Plaza ikonunu kullan, değilse Ev ikonunu kullan
	if ev_sirasi == 4:
		ev.texture = plaza_ikonu
		ev.scale = Vector2(0.06, 0.06) # Plazanın boyutu (resminin büyüklüğüne göre ayarlarsın)
	else:
		ev.texture = ev_ikonu
		ev.scale = Vector2(0.04, 0.04) # Evin boyutu (resminin büyüklüğüne göre ayarlarsın)
		
	ev.modulate = renk
	# Plaza da olsa adı "Ev_indeks_4" olacak ki, arsa satıldığında kolayca silinebilsin
	ev.name = "Ev_" + str(indeks) + "_" + str(ev_sirasi)
	
	# Şehrin konumunu al
	var kordinat = path_2d.curve.get_point_position(clampi(indeks, 0, path_2d.curve.get_point_count() - 1))
	
	# Plaza yapılıyorsa karenin tam ortasına koy, Ev yapılıyorsa yan yana diz
	if ev_sirasi == 4:
		ev.position = kordinat + Vector2(0, -7) 
	else:
		# Evleri yan yana dizmek için matematik (-30'dan başla, her evde 20 piksel sağa kay)
		ev.position = kordinat + Vector2(-30 + (ev_sirasi * 20), -20)
		
	path_2d.add_child(ev)
	
	
	# --- OTOPARK (VALE) SİSTEMİ ---
func piyonlarin_konumlarini_duzenle():
	# Haritadaki tüm kareleri (0'dan 22'ye) tek tek kontrol et
	for kare in range(toplam_kare_sayisi):
		var bu_karedeki_oyuncular = []
		
		# Bu karede duran "aktif" oyuncuları listeye al
		for i in range(Global.oyuncu_sayisi):
			if oyuncular[i]["aktif_mi"] and oyuncular[i]["konum"] == kare:
				bu_karedeki_oyuncular.append(i)
		
		var kisi_sayisi = bu_karedeki_oyuncular.size()
		
		# Eğer karede birden fazla araba varsa onlara park yeri ayarla
		for i in range(kisi_sayisi):
			var o_indeks = bu_karedeki_oyuncular[i]
			var p = oyuncular[o_indeks]["piyon"]
			
			var araba_sprite = null
			for alt_dugum in p.get_children():
				if alt_dugum is Sprite2D:
					araba_sprite = alt_dugum
					break
					
			if araba_sprite != null:
				var ofset = Vector2.ZERO
				
				# Arabaları kare içindeki sayısına göre yan yana/alt alta kaydır (20 piksellik boşluklar)
				if kisi_sayisi == 2:
					ofset = [Vector2(-20, 0), Vector2(20, 0)][i]
				elif kisi_sayisi == 3:
					ofset = [Vector2(-20, -15), Vector2(20, -15), Vector2(0, 15)][i]
				elif kisi_sayisi == 4:
					ofset = [Vector2(-20, -20), Vector2(20, -20), Vector2(-20, 20), Vector2(20, 20)][i]
					
				# Arabayı anında ışınlamak yerine yumuşakça (0.3 saniyede) park yerine kaydır
				var tween = create_tween()
				tween.tween_property(araba_sprite, "position", ofset, 0.3).set_trans(Tween.TRANS_SINE)

# --- ZAR ANİMASYONU ---
func zar_animasyonu_oynat():
	# Zar sesini başlat
	if zar_sesi_player:
		zar_sesi_player.play()
		
	# Açıları başlangıçta sıfırla
	zar_gorseli.rotation_degrees = 0
	if ekstra_zar_gorseli: ekstra_zar_gorseli.rotation_degrees = 0
		
	# 1. Aşama: Zarları havaya fırlat (Büyüt ve Döndür)
	var yukari_tween = create_tween().set_parallel(true)
	yukari_tween.tween_property(zar_gorseli, "scale", Vector2(0.28, 0.28), 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	yukari_tween.tween_property(zar_gorseli, "rotation_degrees", 360.0, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	if ekstra_zar_gorseli and ekstra_zar_gorseli.visible:
		yukari_tween.tween_property(ekstra_zar_gorseli, "scale", Vector2(0.28, 0.28), 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		# Ekstra zarı ters yöne döndürelim, daha havalı dursun
		yukari_tween.tween_property(ekstra_zar_gorseli, "rotation_degrees", -360.0, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	# Havadayken 0.3 saniye bekle
	await get_tree().create_timer(0.3).timeout
	
	# 2. Aşama: Zarları yere vur (Küçült ve Sektir)
	var asagi_tween = create_tween().set_parallel(true)
	asagi_tween.tween_property(zar_gorseli, "scale", Vector2(0.25, 0.25), 0.2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	if ekstra_zar_gorseli and ekstra_zar_gorseli.visible:
		asagi_tween.tween_property(ekstra_zar_gorseli, "scale", Vector2(0.25, 0.25), 0.2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		
	# Animasyonun tamamen bitmesi ve arabanın hareketine geçmesi için biraz daha bekle
	await get_tree().create_timer(0.3).timeout
