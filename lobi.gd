extends Control
# ==========================================================
# ÇEVRİMİÇİ LOBİ (Aynı Wi-Fi / hotspot)
# 1. ekran: isim + oda kur / odaya katıl
# 2. ekran (oda): oyuncu kartları + araba ve renk seçimi.
#    Renkler oda içinde seçilir; başkasının aldığı renk kilitlenir.
# Arayüz tamamen koddan kurulur; lobi.tscn sadece bu scripti taşır.
# ==========================================================

var arabalar = [
	{"isim": "Porsche 911", "gorsel": preload("res://Arabalar/porsche.png")},
	{"isim": "Klasik Vosvos", "gorsel": preload("res://Arabalar/vosvos.png")},
	{"isim": "Formula 1", "gorsel": preload("res://Arabalar/f1.png")},
	{"isim": "Arazi Jeep", "gorsel": preload("res://Arabalar/jeep.png")},
	{"isim": "Kamyonet", "gorsel": preload("res://Arabalar/kamyonet.png")}
]

const AYAR_DOSYASI := "user://cevrimici_profil.cfg"

const RENK_KART := Color(0.06, 0.08, 0.12, 0.94)
const RENK_SOLUK := Color(0.68, 0.72, 0.8)
const RENK_VURGU := Color(1, 0.82, 0.3)
const RENK_YESIL := Color(0.17, 0.55, 0.13)
const RENK_KIRMIZI := Color(0.62, 0.12, 0.12)

# 1. ekran
var profil_ekrani: Control
var isim_kutusu: LineEdit
var oda_listesi: VBoxContainer
var ip_kutusu: LineEdit
var durum_etiketi: Label

# 2. ekran
var oda_ekrani: Control
var oda_baslik: Label
var oda_sayac: Label
var ip_bilgisi: Label
var yuva_satiri: HBoxContainer
var araba_gorseli: TextureRect
var araba_ismi: Label
var renk_satiri: HBoxContainer
var baslat_butonu: Button
var bekleme_etiketi: Label
var oda_durum_etiketi: Label
var oda_isim_satiri: HBoxContainer
var oda_isim_kutusu: LineEdit
var cik_butonu: Button
var enf_butonu: Button

# Kaydedilen tercih (bir sonraki odaya bununla girilir)
var tercih_araba := 0
var tercih_renk := 0
var cevrimdisi := false   # "Oyuna Başla" ile gelindiyse: ağ yok, sen + botlar
var ayar_dosyasi_enflasyon := -1   # Kayıtlı enflasyon tercihi (oda kurarken kullanılır)


func _ready():
	var tema := Theme.new()
	tema.default_font_size = 32
	theme = tema

	# Arka plan: oyun tahtası, üzerine koyu perde
	var arka := TextureRect.new()
	arka.texture = preload("res://harita.png")
	arka.set_anchors_preset(Control.PRESET_FULL_RECT)
	arka.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	arka.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	add_child(arka)
	var perde := ColorRect.new()
	perde.color = Color(0.02, 0.03, 0.06, 0.78)
	perde.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(perde)

	_profil_ayarlarini_yukle()
	_profil_ekranini_kur()
	_oda_ekranini_kur()

	Ag.lobi_degisti.connect(_lobi_yenile)
	Ag.odalar_degisti.connect(_odalari_yenile)
	Ag.durum_mesaji.connect(_durum_goster)

	if Ag.acilis_modu == "cevrimdisi":
		Ag.acilis_modu = ""
		cevrimdisi = true
		Ag.yerel_oda_kur()
		oda_isim_kutusu.text = Ag.yuvalar[0]["isim"] if Ag.profil["isim"] != "" else ""
		_lobi_yenile()
	else:
		_profil_ekranina_don()
		Ag.oda_aramaya_basla()


func _exit_tree():
	Ag.oda_aramayi_durdur()


# ----------------------------------------------------------
# STİL YARDIMCILARI
# ----------------------------------------------------------
func _stil(renk: Color, kose := 16) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = renk
	s.set_corner_radius_all(kose)
	s.content_margin_left = 24
	s.content_margin_right = 24
	s.content_margin_top = 10
	s.content_margin_bottom = 10
	s.anti_aliasing = true
	return s


func _buton(metin: String, islev: Callable, tur := "ikincil", yukseklik := 84) -> Button:
	var b := Button.new()
	b.text = metin
	b.custom_minimum_size = Vector2(0, yukseklik)
	b.focus_mode = Control.FOCUS_NONE
	var normal: Color
	var ustunde: Color
	var basili: Color
	match tur:
		"birincil":
			normal = RENK_YESIL
			ustunde = RENK_YESIL.lightened(0.15)
			basili = RENK_YESIL.darkened(0.2)
		"tehlike":
			normal = RENK_KIRMIZI
			ustunde = RENK_KIRMIZI.lightened(0.15)
			basili = RENK_KIRMIZI.darkened(0.2)
		_:
			normal = Color(1, 1, 1, 0.08)
			ustunde = Color(1, 1, 1, 0.15)
			basili = Color(1, 1, 1, 0.04)
	b.add_theme_stylebox_override("normal", _stil(normal))
	b.add_theme_stylebox_override("hover", _stil(ustunde))
	b.add_theme_stylebox_override("pressed", _stil(basili))
	b.add_theme_stylebox_override("disabled", _stil(Color(normal.r, normal.g, normal.b, normal.a * 0.35)))
	b.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	for anahtar in ["font_color", "font_hover_color", "font_pressed_color", "font_focus_color", "font_hover_pressed_color"]:
		b.add_theme_color_override(anahtar, Color.WHITE)
	b.add_theme_color_override("font_disabled_color", Color(1, 1, 1, 0.35))
	b.pressed.connect(islev)
	return b


func _etiket(metin: String, boyut := 32, renk := Color.WHITE, hiza := HORIZONTAL_ALIGNMENT_CENTER) -> Label:
	var l := Label.new()
	l.text = metin
	l.horizontal_alignment = hiza
	l.add_theme_font_size_override("font_size", boyut)
	l.add_theme_color_override("font_color", renk)
	return l


func _metin_kutusu(ipucu: String) -> LineEdit:
	var e := LineEdit.new()
	e.placeholder_text = ipucu
	e.custom_minimum_size = Vector2(0, 76)
	var normal := _stil(Color(1, 1, 1, 0.07), 14)
	var odak := _stil(Color(1, 1, 1, 0.1), 14)
	odak.border_color = RENK_VURGU
	odak.set_border_width_all(2)
	e.add_theme_stylebox_override("normal", normal)
	e.add_theme_stylebox_override("focus", odak)
	e.add_theme_color_override("font_placeholder_color", Color(1, 1, 1, 0.3))
	return e


func _ayirici(metin: String) -> HBoxContainer:
	var satir := HBoxContainer.new()
	satir.add_theme_constant_override("separation", 20)
	for i in 2:
		var cizgi := HSeparator.new()
		cizgi.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var stil := StyleBoxLine.new()
		stil.color = Color(1, 1, 1, 0.15)
		stil.thickness = 2
		cizgi.add_theme_stylebox_override("separator", stil)
		satir.add_child(cizgi)
		if i == 0:
			satir.add_child(_etiket(metin, 24, RENK_SOLUK))
	return satir


# Ortada, gölgeli yuvarlak köşeli kart. İçindeki VBox'ı döndürür.
func _kart_olustur(genislik: float) -> VBoxContainer:
	var merkez := CenterContainer.new()
	merkez.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(merkez)
	var kart := PanelContainer.new()
	kart.custom_minimum_size = Vector2(genislik, 0)
	var s := _stil(RENK_KART, 28)
	s.border_color = Color(1, 1, 1, 0.08)
	s.set_border_width_all(2)
	s.shadow_color = Color(0, 0, 0, 0.55)
	s.shadow_size = 30
	s.content_margin_left = 56
	s.content_margin_right = 56
	s.content_margin_top = 36
	s.content_margin_bottom = 36
	kart.add_theme_stylebox_override("panel", s)
	merkez.add_child(kart)
	var kutu := VBoxContainer.new()
	kutu.add_theme_constant_override("separation", 18)
	kart.add_child(kutu)
	kutu.set_meta("ekran", merkez)
	return kutu


# ----------------------------------------------------------
# 1. EKRAN: İSİM + ODA KUR / KATIL
# ----------------------------------------------------------
func _profil_ekranini_kur():
	var k := _kart_olustur(1100)
	profil_ekrani = k.get_meta("ekran")

	k.add_child(_etiket("ÇEVRİMİÇİ OYUN", 58))
	k.add_child(_etiket("Aynı Wi-Fi ağındaki ya da aynı hotspot'a bağlı arkadaşlarınla oyna", 26, RENK_SOLUK))

	k.add_child(_etiket("İSMİN", 22, RENK_SOLUK, HORIZONTAL_ALIGNMENT_LEFT))
	isim_kutusu = _metin_kutusu("İsmini yaz")
	isim_kutusu.max_length = 14
	isim_kutusu.alignment = HORIZONTAL_ALIGNMENT_CENTER
	isim_kutusu.text = Ag.profil["isim"]
	k.add_child(isim_kutusu)

	k.add_child(_buton("ODA KUR", _on_oda_kur_basildi, "birincil", 96))

	k.add_child(_ayirici("veya bir odaya katıl"))

	oda_listesi = VBoxContainer.new()
	oda_listesi.add_theme_constant_override("separation", 12)
	k.add_child(oda_listesi)

	var ip_satiri := HBoxContainer.new()
	ip_satiri.add_theme_constant_override("separation", 16)
	ip_kutusu = _metin_kutusu("Oda listede yoksa IP yaz (ör. 192.168.1.23)")
	ip_kutusu.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	ip_satiri.add_child(ip_kutusu)
	var ip_butonu := _buton("BAĞLAN", func(): _katil(ip_kutusu.text), "ikincil", 76)
	ip_butonu.custom_minimum_size.x = 220
	ip_satiri.add_child(ip_butonu)
	k.add_child(ip_satiri)

	durum_etiketi = _etiket("", 26, RENK_VURGU)
	durum_etiketi.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	k.add_child(durum_etiketi)

	k.add_child(_buton("GERİ", _on_geri_basildi, "ikincil", 72))


# ----------------------------------------------------------
# 2. EKRAN: ODA
# ----------------------------------------------------------
func _oda_ekranini_kur():
	var k := _kart_olustur(1560)
	oda_ekrani = k.get_meta("ekran")

	var ust := HBoxContainer.new()
	oda_baslik = _etiket("ODA", 50, Color.WHITE, HORIZONTAL_ALIGNMENT_LEFT)
	oda_baslik.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	ust.add_child(oda_baslik)
	oda_sayac = _etiket("", 28, RENK_SOLUK, HORIZONTAL_ALIGNMENT_RIGHT)
	oda_sayac.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	ust.add_child(oda_sayac)
	k.add_child(ust)

	ip_bilgisi = _etiket("", 24, RENK_SOLUK, HORIZONTAL_ALIGNMENT_LEFT)
	ip_bilgisi.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	k.add_child(ip_bilgisi)

	yuva_satiri = HBoxContainer.new()
	yuva_satiri.add_theme_constant_override("separation", 20)
	yuva_satiri.alignment = BoxContainer.ALIGNMENT_CENTER
	k.add_child(yuva_satiri)

	k.add_child(_ayirici("araban ve rengin"))

	# Sadece çevrimdışı oyunda: isim burada girilir
	oda_isim_satiri = HBoxContainer.new()
	oda_isim_satiri.add_theme_constant_override("separation", 16)
	var isim_etiketi := _etiket("İSMİN", 26, RENK_SOLUK)
	isim_etiketi.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	oda_isim_satiri.add_child(isim_etiketi)
	oda_isim_kutusu = _metin_kutusu("İsmini yaz")
	oda_isim_kutusu.max_length = 14
	oda_isim_kutusu.alignment = HORIZONTAL_ALIGNMENT_CENTER
	oda_isim_kutusu.custom_minimum_size = Vector2(520, 70)
	oda_isim_kutusu.text_changed.connect(_on_oda_isim_degisti)
	oda_isim_satiri.add_child(oda_isim_kutusu)
	oda_isim_satiri.alignment = BoxContainer.ALIGNMENT_CENTER
	oda_isim_satiri.visible = false
	k.add_child(oda_isim_satiri)

	# Araba + renk seçici tek satır
	var secici := HBoxContainer.new()
	secici.alignment = BoxContainer.ALIGNMENT_CENTER
	secici.add_theme_constant_override("separation", 18)
	var sol := _buton("<", func(): _araba_degistir(-1), "ikincil", 110)
	sol.custom_minimum_size.x = 76
	secici.add_child(sol)
	araba_gorseli = TextureRect.new()
	araba_gorseli.custom_minimum_size = Vector2(200, 110)
	araba_gorseli.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	araba_gorseli.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	secici.add_child(araba_gorseli)
	var sag := _buton(">", func(): _araba_degistir(1), "ikincil", 110)
	sag.custom_minimum_size.x = 76
	secici.add_child(sag)
	araba_ismi = _etiket("", 30)
	araba_ismi.custom_minimum_size.x = 230
	secici.add_child(araba_ismi)
	var ara := VSeparator.new()
	var ara_stil := StyleBoxLine.new()
	ara_stil.color = Color(1, 1, 1, 0.15)
	ara_stil.thickness = 2
	ara_stil.vertical = true
	ara.add_theme_stylebox_override("separator", ara_stil)
	secici.add_child(ara)
	renk_satiri = HBoxContainer.new()
	renk_satiri.add_theme_constant_override("separation", 12)
	renk_satiri.alignment = BoxContainer.ALIGNMENT_CENTER
	secici.add_child(renk_satiri)
	k.add_child(secici)

	oda_durum_etiketi = _etiket("", 26, RENK_VURGU)
	oda_durum_etiketi.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	k.add_child(oda_durum_etiketi)

	var alt := HBoxContainer.new()
	alt.add_theme_constant_override("separation", 20)
	cik_butonu = _buton("ODADAN ÇIK", _on_odadan_cik_basildi, "tehlike", 100)
	cik_butonu.custom_minimum_size.x = 380
	alt.add_child(cik_butonu)
	# Enflasyon kuralı: oda sahibi basınca Kapalı → Normal → Yüksek arasında döner
	enf_butonu = _buton("", _on_enf_basildi, "ikincil", 100)
	enf_butonu.custom_minimum_size.x = 360
	enf_butonu.add_theme_font_size_override("font_size", 24)
	alt.add_child(enf_butonu)
	baslat_butonu = _buton("OYUNU BAŞLAT", _on_baslat_basildi, "birincil", 100)
	baslat_butonu.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	baslat_butonu.add_theme_font_size_override("font_size", 38)
	alt.add_child(baslat_butonu)
	bekleme_etiketi = _etiket("Oda sahibinin oyunu başlatması bekleniyor...", 28, RENK_SOLUK)
	bekleme_etiketi.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bekleme_etiketi.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	alt.add_child(bekleme_etiketi)
	k.add_child(alt)


func _ekran_goster(profil: bool):
	profil_ekrani.visible = profil
	oda_ekrani.visible = not profil


# Bir oyuncu yuvası kartı (dolu ya da boş)
func _yuva_karti(i: int) -> PanelContainer:
	var kart := PanelContainer.new()
	kart.custom_minimum_size = Vector2(340, 250)
	var v := VBoxContainer.new()
	v.alignment = BoxContainer.ALIGNMENT_CENTER
	v.add_theme_constant_override("separation", 6)
	kart.add_child(v)
	var sunucu := Ag.sunucu_mu()

	if i < Ag.yuvalar.size():
		var y = Ag.yuvalar[i]
		var renk: Color = Ag.RENKLER[int(y["renk"])]
		var s := _stil(Color(renk.r, renk.g, renk.b, 0.13), 20)
		s.border_color = renk
		if i == Ag.yerel_indeks:
			s.set_border_width_all(3)
		s.border_width_top = 8
		kart.add_theme_stylebox_override("panel", s)

		var resim := TextureRect.new()
		resim.texture = arabalar[clampi(int(y["araba"]), 0, arabalar.size() - 1)]["gorsel"]
		resim.custom_minimum_size = Vector2(0, 110)
		resim.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		resim.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		resim.modulate = renk
		v.add_child(resim)

		var isim := _etiket(str(y["isim"]), 34)
		isim.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		isim.clip_text = true
		v.add_child(isim)

		var etiketler := []
		if i == 0 and not cevrimdisi:
			etiketler.append("Oda sahibi")
		if i == Ag.yerel_indeks:
			etiketler.append("Sen")
		if y["bot"]:
			etiketler.append("Bot")
		v.add_child(_etiket(" · ".join(PackedStringArray(etiketler)) if etiketler.size() > 0 else " ", 22, renk.lightened(0.3)))

		if sunucu and y["bot"]:
			var indeks := i
			var cikar := _buton("ÇIKAR", func(): Ag.bot_cikar(indeks), "ikincil", 48)
			cikar.add_theme_font_size_override("font_size", 22)
			v.add_child(cikar)
	else:
		var s := _stil(Color(1, 1, 1, 0.03), 20)
		s.border_color = Color(1, 1, 1, 0.12)
		s.set_border_width_all(2)
		kart.add_theme_stylebox_override("panel", s)
		v.add_child(_etiket("Boş yer", 30, Color(1, 1, 1, 0.35)))
		if sunucu:
			var ekle := _buton("+ BOT EKLE", func(): Ag.bot_ekle(), "ikincil", 60)
			ekle.add_theme_font_size_override("font_size", 24)
			v.add_child(ekle)
		else:
			v.add_child(_etiket("Arkadaş bekleniyor", 22, Color(1, 1, 1, 0.3)))
	return kart


# ----------------------------------------------------------
# SEÇİMLER
# ----------------------------------------------------------
# Bu cihazdaki oyuncunun yuvası; odada değilsek boş sözlük
func _benim_yuvam() -> Dictionary:
	if Ag.yerel_indeks >= 0 and Ag.yerel_indeks < Ag.yuvalar.size():
		return Ag.yuvalar[Ag.yerel_indeks]
	return {}


func _araba_degistir(yon: int):
	var y := _benim_yuvam()
	if y.is_empty():
		return
	_secim_gonder(posmod(int(y["araba"]) + yon, arabalar.size()), int(y["renk"]))


func _renk_sec(renk: int):
	var y := _benim_yuvam()
	if y.is_empty() or int(y["renk"]) == renk:
		return
	_secim_gonder(int(y["araba"]), renk)


func _secim_gonder(araba: int, renk: int):
	tercih_araba = araba
	tercih_renk = renk
	_profili_kaydet()
	Ag.secim_degistir(araba, renk)


func _profili_kaydet():
	var isim := isim_kutusu.text.strip_edges()
	if isim == "":
		isim = "Oyuncu"
	Ag.profil = {"isim": isim, "araba": tercih_araba, "renk": tercih_renk}
	var ayar := ConfigFile.new()
	ayar.set_value("profil", "isim", isim)
	ayar.set_value("profil", "araba", tercih_araba)
	ayar.set_value("profil", "renk", tercih_renk)
	ayar.set_value("profil", "son_ip", ip_kutusu.text.strip_edges())
	if Ag.sunucu_mu():
		ayar_dosyasi_enflasyon = int(Ag.oyun_ayarlari.get("enflasyon", 1))
		ayar.set_value("oyun", "enflasyon", ayar_dosyasi_enflasyon)
	elif ayar_dosyasi_enflasyon >= 0:
		ayar.set_value("oyun", "enflasyon", ayar_dosyasi_enflasyon)
	ayar.save(AYAR_DOSYASI)


func _profil_ayarlarini_yukle():
	var ayar := ConfigFile.new()
	if ayar.load(AYAR_DOSYASI) == OK:
		Ag.profil["isim"] = str(ayar.get_value("profil", "isim", ""))
		tercih_araba = clampi(int(ayar.get_value("profil", "araba", 0)), 0, arabalar.size() - 1)
		tercih_renk = clampi(int(ayar.get_value("profil", "renk", 0)), 0, Ag.RENKLER.size() - 1)
		set_meta("son_ip", str(ayar.get_value("profil", "son_ip", "")))
		ayar_dosyasi_enflasyon = clampi(int(ayar.get_value("oyun", "enflasyon", 1)), 0, 2)
	# Odayı biz kuracaksak kayıtlı enflasyon tercihiyle başla (katılınca oda sahibininki gelir)
	if not Ag.online:
		Ag.oyun_ayarlari["enflasyon"] = ayar_dosyasi_enflasyon if ayar_dosyasi_enflasyon >= 0 else 1


# ----------------------------------------------------------
# BUTONLAR
# ----------------------------------------------------------
func _on_oda_kur_basildi():
	_profili_kaydet()
	# Başka bir odadan çıkıp kendi odamızı kuruyorsak kendi enflasyon tercihimize dön
	Ag.oyun_ayarlari["enflasyon"] = ayar_dosyasi_enflasyon if ayar_dosyasi_enflasyon >= 0 else 1
	Ag.oda_aramayi_durdur()
	if Ag.oda_kur():
		_lobi_yenile()
	else:
		Ag.oda_aramaya_basla()


func _katil(ip: String):
	_profili_kaydet()
	if Ag.katil(ip):
		durum_etiketi.text = "Bağlanılıyor..."


func _on_oda_isim_degisti(yeni: String):
	isim_kutusu.text = yeni
	Ag.yerel_isim_degistir(yeni)


func _on_enf_basildi():
	var yeni = (int(Ag.oyun_ayarlari.get("enflasyon", 1)) + 1) % 3
	Ag.ayar_degistir("enflasyon", yeni)
	_profili_kaydet()


func _on_baslat_basildi():
	_profili_kaydet()
	Ag.oyunu_baslat()


func _on_odadan_cik_basildi():
	if cevrimdisi:
		_on_geri_basildi()
		return
	Ag.ayril()
	_profil_ekranina_don()
	Ag.oda_aramaya_basla()


func _on_geri_basildi():
	Ag.ayril()
	get_tree().change_scene_to_file("res://ana_menu.tscn")


func _profil_ekranina_don():
	_ekran_goster(true)
	durum_etiketi.text = ""
	if has_meta("son_ip") and ip_kutusu.text == "":
		ip_kutusu.text = get_meta("son_ip")
	_odalari_yenile()


func _durum_goster(metin: String):
	if Ag.online:
		oda_durum_etiketi.text = metin
	else:
		# Bağlantı koptuysa ya da reddedildiysek ilk ekrana dön
		_profil_ekranina_don()
		Ag.oda_aramaya_basla()
		durum_etiketi.text = metin


# ----------------------------------------------------------
# LİSTELER
# ----------------------------------------------------------
func _odalari_yenile():
	for c in oda_listesi.get_children():
		c.queue_free()
	if Ag.bulunan_odalar.is_empty():
		oda_listesi.add_child(_etiket("Odalar aranıyor...", 26, Color(1, 1, 1, 0.4)))
		return
	for ip in Ag.bulunan_odalar.keys():
		var oda = Ag.bulunan_odalar[ip]
		var metin = "%s  ·  %d/%d oyuncu" % [oda["oda"], oda["kisi"], Ag.MAKS_OYUNCU]
		if oda["basladi"]:
			metin += "  ·  oyun sürüyor, geri dön"
		var hedef_ip: String = ip
		var b := _buton(metin, func(): _katil(hedef_ip), "ikincil", 88)
		b.alignment = HORIZONTAL_ALIGNMENT_LEFT
		oda_listesi.add_child(b)


func _lobi_yenile():
	if not (Ag.online or Ag.cevrimdisi_oda) or Ag.yuvalar.is_empty():
		return
	_ekran_goster(false)
	var sunucu := Ag.sunucu_mu()
	oda_baslik.text = "YENİ OYUN" if cevrimdisi else "ODA: %s" % Ag.yuvalar[0]["isim"]
	oda_isim_satiri.visible = cevrimdisi
	cik_butonu.text = "GERİ" if cevrimdisi else "ODADAN ÇIK"
	oda_sayac.text = "%d/%d oyuncu" % [Ag.yuvalar.size(), Ag.MAKS_OYUNCU]

	if cevrimdisi:
		ip_bilgisi.text = "Rakiplerin botlar. Boş yerlere bot ekleyebilir, bot kartından çıkarabilirsin."
	elif sunucu:
		var ipler := Ag.yerel_ipler()
		if ipler.is_empty():
			ip_bilgisi.text = "Ağ bağlantısı bulunamadı. Wi-Fi'a bağlan ya da hotspot aç."
		else:
			ip_bilgisi.text = "Odayı listede göremeyenler şu adreslerden birini yazabilir:  " + "   ·   ".join(PackedStringArray(ipler))
	else:
		ip_bilgisi.text = "Araba ve rengini seç. Başkasının aldığı renkler kilitlidir."

	# Oyuncu kartları
	for c in yuva_satiri.get_children():
		c.queue_free()
	for i in Ag.MAKS_OYUNCU:
		yuva_satiri.add_child(_yuva_karti(i))

	# Seçici: kendi arabam ve renklerin durumu
	var y := _benim_yuvam()
	if not y.is_empty():
		var benim_renk: int = int(y["renk"])
		var araba: int = clampi(int(y["araba"]), 0, arabalar.size() - 1)
		araba_gorseli.texture = arabalar[araba]["gorsel"]
		araba_gorseli.modulate = Ag.RENKLER[benim_renk]
		araba_ismi.text = arabalar[araba]["isim"]

		for c in renk_satiri.get_children():
			c.queue_free()
		for r in Ag.RENKLER.size():
			var b := Button.new()
			b.custom_minimum_size = Vector2(60, 60)
			b.focus_mode = Control.FOCUS_NONE
			b.tooltip_text = Ag.RENK_ADLARI[r]
			var s := StyleBoxFlat.new()
			s.bg_color = Ag.RENKLER[r]
			s.set_corner_radius_all(30)
			s.anti_aliasing = true
			if r == benim_renk:
				s.border_color = Color.WHITE
				s.set_border_width_all(5)
			for durum in ["normal", "hover", "pressed", "disabled"]:
				b.add_theme_stylebox_override(durum, s)
			b.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
			var sahip := Ag.renk_sahibi(r)
			if sahip != -1 and sahip != Ag.yerel_indeks:
				b.disabled = true
				b.modulate.a = 0.2
				b.tooltip_text += " (" + str(Ag.yuvalar[sahip]["isim"]) + " seçti)"
			var renk_no := r
			b.pressed.connect(func(): _renk_sec(renk_no))
			renk_satiri.add_child(b)

	baslat_butonu.visible = sunucu
	bekleme_etiketi.visible = not sunucu
	var enf = clampi(int(Ag.oyun_ayarlari.get("enflasyon", 1)), 0, 2)
	enf_butonu.text = "ENFLASYON: " + Ag.ENFLASYON_ADLARI[enf] + "\n" + Ag.ENFLASYON_ACIKLAMALARI[enf]
	enf_butonu.disabled = not sunucu
	baslat_butonu.disabled = Ag.yuvalar.size() < 2
	if sunucu and Ag.yuvalar.size() < 2:
		oda_durum_etiketi.text = "Başlatmak için en az 2 oyuncu gerekli. Bot ekle." if cevrimdisi else "Başlatmak için en az 2 oyuncu gerekli. Arkadaşını bekle ya da bot ekle."
	else:
		oda_durum_etiketi.text = ""
