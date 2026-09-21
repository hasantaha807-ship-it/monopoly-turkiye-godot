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
var secili_renk = Color.RED # Varsayılan renk kırmızı

# Arabaların isimleri ve görsellerini bir sözlükte tutuyoruz
var arabalar = [
	{"isim": "Porsche 911", "gorsel": preload("res://Arabalar/porsche.png")},
	{"isim": "Klasik Vosvos", "gorsel": preload("res://Arabalar/vosvos.png")},
	{"isim": "Formula 1", "gorsel": preload("res://Arabalar/f1.png")},
	{"isim": "Arazi Jeep", "gorsel": preload("res://Arabalar/jeep.png")},
	{"isim": "Kamyonet", "gorsel": preload("res://Arabalar/kamyonet.png")}
]

func _ready():
	# Butonların tıklanma sinyallerini bağlıyoruz
	sol_ok.pressed.connect(_on_sol_ok_basildi)
	sag_ok.pressed.connect(_on_sag_ok_basildi)
	onayla_butonu.pressed.connect(_on_onayla_basildi)
	
	# Renk butonlarını bağlıyoruz ve onlara renk parametresi gönderiyoruz
	kirmizi_buton.pressed.connect(func(): _renk_degistir(Color.RED))
	mavi_buton.pressed.connect(func(): _renk_degistir(Color.BLUE))
	sari_buton.pressed.connect(func(): _renk_degistir(Color.YELLOW))
	yesil_buton.pressed.connect(func(): _renk_degistir(Color.GREEN))
	
	# İlk oyuncunun ekranını kuruyoruz
	ekrani_hazirla()

# --- EKRAN GÜNCELLEMELERİ ---
func ekrani_hazirla():
	baslik_etiketi.text = str(su_anki_oyuncu_indeksi + 1) + ". OYUNCU SEÇİMİ"
	isim_kutusu.text = "" # Yeni oyuncu için isim kutusunu temizle
	
	# Oyuncuya göre varsayılan renk belirleyelim (1. Kırmızı, 2. Mavi, 3. Sarı, 4. Yeşil)
	var varsayilan_renkler = [Color.RED, Color.BLUE, Color.YELLOW, Color.GREEN]
	secili_renk = varsayilan_renkler[su_anki_oyuncu_indeksi]
	
	arabayi_guncelle()

func arabayi_guncelle():
	var su_anki_araba = arabalar[secili_araba_indeksi]
	araba_gorseli.texture = su_anki_araba["gorsel"]
	araba_ismi.text = su_anki_araba["isim"]
	
	# Arabayı ve altındaki ismini seçili renge boyuyoruz!
	araba_gorseli.modulate = secili_renk
	araba_ismi.modulate = secili_renk

func _renk_degistir(yeni_renk: Color):
	secili_renk = yeni_renk
	arabayi_guncelle()

# --- BUTON ETKİLEŞİMLERİ ---
func _on_sol_ok_basildi():
	secili_araba_indeksi -= 1
	if secili_araba_indeksi < 0:
		secili_araba_indeksi = arabalar.size() - 1 # En başa gelince sona sar
	arabayi_guncelle()

func _on_sag_ok_basildi():
	secili_araba_indeksi += 1
	if secili_araba_indeksi >= arabalar.size():
		secili_araba_indeksi = 0 # En sona gelince başa sar
	arabayi_guncelle()

func _on_onayla_basildi():
	# 1. Girilen ismi al (Eğer boş bırakılırsa varsayılan isim ver)
	var girilen_isim = isim_kutusu.text.strip_edges()
	if girilen_isim == "":
		girilen_isim = "Oyuncu " + str(su_anki_oyuncu_indeksi + 1)
		
	# 2. Seçimleri Global hafızaya kaydet
	Global.oyuncu_ayarlari[su_anki_oyuncu_indeksi]["isim"] = girilen_isim
	Global.oyuncu_ayarlari[su_anki_oyuncu_indeksi]["araba_indeksi"] = secili_araba_indeksi
	Global.oyuncu_ayarlari[su_anki_oyuncu_indeksi]["renk"] = secili_renk

	# 3. Sıradaki oyuncuya geç
	su_anki_oyuncu_indeksi += 1
	
	# 4. Eğer tüm oyuncular seçimini yaptıysa asıl oyuna başla!
	if su_anki_oyuncu_indeksi >= Global.oyuncu_sayisi:
		get_tree().change_scene_to_file("res://node_2d.tscn") # Asıl oyun sahnesinin adı neyse buraya onu yaz
	else:
		ekrani_hazirla() # Hala seçecek oyuncu varsa ekranı sıfırla
