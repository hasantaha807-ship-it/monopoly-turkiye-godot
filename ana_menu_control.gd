extends Control

# --- ARAYÜZ DÜĞÜMLERİ ---
@onready var baslik_etiketi = $BaslikEtiketi
@onready var isim_kutusu = $IsimKutusu
@onready var araba_gorseli = $Galeri/ArabaGorseli
@onready var araba_ismi = $Galeri/ArabaIsmi
@onready var sol_ok = $Galeri/SolOkButonu
@onready var sag_ok = $Galeri/SagOkButonu
@onready var kirmizi_buton = $RenkPaleti/KirmiziButon
@onready var mavi_buton = $RenkPaleti/MaviButon
@onready var sari_buton = $RenkPaleti/SariButon
@onready var yesil_buton = $RenkPaleti/YesilButon
@onready var onayla_butonu = $OnaylaButonu

# --- ARAÇ LİSTESİ VE HAFIZA ---
var su_anki_oyuncu_indeksi = 0
var secili_araba_indeksi = 0

# YENİ: Göz yormayan pastel (soft) renk paleti
var renk_kirmizi = Color("ff5943")
var renk_mavi = Color("599eff") # İstediğin o tatlı, yumuşak mavi
var renk_sari = Color("ffcc00")
var renk_yesil = Color("3de865")

var secili_renk = renk_kirmizi # Varsayılan

var arabalar = [
	{"isim": "Porsche 911", "gorsel": preload("res://Arabalar/porsche.png")},
	{"isim": "Klasik Vosvos", "gorsel": preload("res://Arabalar/vosvos.png")},
	{"isim": "Formula 1", "gorsel": preload("res://Arabalar/f1.png")},
	{"isim": "Arazi Jeep", "gorsel": preload("res://Arabalar/jeep.png")},
	{"isim": "Kamyonet", "gorsel": preload("res://Arabalar/kamyonet.png")}
]

func _ready():
	sol_ok.pressed.connect(_on_sol_ok_basildi)
	sag_ok.pressed.connect(_on_sag_ok_basildi)
	onayla_butonu.pressed.connect(_on_onayla_basildi)
	
	# Butonlara yeni yumuşak renkleri gönderiyoruz
	kirmizi_buton.pressed.connect(func(): _renk_degistir(renk_kirmizi))
	mavi_buton.pressed.connect(func(): _renk_degistir(renk_mavi))
	sari_buton.pressed.connect(func(): _renk_degistir(renk_sari))
	yesil_buton.pressed.connect(func(): _renk_degistir(renk_yesil))
	
	ekrani_hazirla()

func ekrani_hazirla():
	baslik_etiketi.text = str(su_anki_oyuncu_indeksi + 1) + ". OYUNCU SEÇİMİ"
	isim_kutusu.text = "" 
	
	var varsayilan_renkler = [renk_kirmizi, renk_mavi, renk_sari, renk_yesil]
	secili_renk = varsayilan_renkler[su_anki_oyuncu_indeksi]
	
	arabayi_guncelle()

func arabayi_guncelle():
	var su_anki_araba = arabalar[secili_araba_indeksi]
	araba_gorseli.texture = su_anki_araba["gorsel"]
	araba_ismi.text = su_anki_araba["isim"]
	araba_gorseli.modulate = secili_renk
	araba_ismi.modulate = secili_renk

func _renk_degistir(yeni_renk: Color):
	secili_renk = yeni_renk
	arabayi_guncelle()

func _on_sol_ok_basildi():
	secili_araba_indeksi -= 1
	if secili_araba_indeksi < 0:
		secili_araba_indeksi = arabalar.size() - 1 
	arabayi_guncelle()

func _on_sag_ok_basildi():
	secili_araba_indeksi += 1
	if secili_araba_indeksi >= arabalar.size():
		secili_araba_indeksi = 0 
	arabayi_guncelle()

func _on_onayla_basildi():
	var girilen_isim = isim_kutusu.text.strip_edges()
	if girilen_isim == "":
		girilen_isim = "Oyuncu " + str(su_anki_oyuncu_indeksi + 1)
		
	Global.oyuncu_ayarlari[su_anki_oyuncu_indeksi]["isim"] = girilen_isim
	Global.oyuncu_ayarlari[su_anki_oyuncu_indeksi]["araba_indeksi"] = secili_araba_indeksi
	Global.oyuncu_ayarlari[su_anki_oyuncu_indeksi]["renk"] = secili_renk
	
	su_anki_oyuncu_indeksi += 1
	
	if su_anki_oyuncu_indeksi >= Global.oyuncu_sayisi:
		get_tree().change_scene_to_file("res://node_2d.tscn") 
	else:
		ekrani_hazirla()
