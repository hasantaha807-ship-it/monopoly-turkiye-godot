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
@onready var ayarlar_butonu = $Arayuz/AyarlarButonu

# --- YENİ: DURAKLATMA MENÜSÜ BAĞLANTILARI ---
@onready var duraklatma_ekrani = $Arayuz/DuraklatmaEkrani
@onready var tam_ekran_butonu = $Arayuz/DuraklatmaEkrani/Panel/VBoxContainer/TamEkranButonu
@onready var hiz_slider = $Arayuz/DuraklatmaEkrani/Panel/VBoxContainer/HizSlider
@onready var muzik_slider = $Arayuz/DuraklatmaEkrani/Panel/VBoxContainer/MuzikSlider
@onready var efekt_slider = $Arayuz/DuraklatmaEkrani/Panel/VBoxContainer/EfektSlider
@onready var devam_butonu = $Arayuz/DuraklatmaEkrani/Panel/VBoxContainer/DevamButonu
@onready var yeniden_baslat_butonu_menu = $Arayuz/DuraklatmaEkrani/Panel/VBoxContainer/YenidenBaslatButonu
@onready var ana_menu_butonu = $Arayuz/DuraklatmaEkrani/Panel/VBoxContainer/AnaMenuButonu

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
var eski_bakiyeler = [0, 0, 0, 0]
var hareket_ediyor = false 
var tur_maasi = 200
var ev_ikonu = preload("res://Mulkler/ev.png")       
var plaza_ikonu = preload("res://Mulkler/plaza.png") 

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

var ihale_suresi = 8
var ihale_aktif = false
var ihale_verileri = {"sehir": "", "guncel_teklif": 0, "kazanan_indeks": -1, "satici": -1, "artis": 50, "cekilenler": []}

# --- RENK GRUPLARI (TEKEL) ---
var gruplar := {}                  # grup rengi -> tahtadaki sırasıyla şehirler
const GORUNEN_ADLAR := {"Eskisehir": "Eskişehir", "Adiyaman": "Adıyaman", "Istanbul": "İstanbul"}

# --- ENFLASYON ---
var tur_sayaci := 0                # tamamlanan tur (her oyuncu bir kez oynayınca +1)
var enf_kademe := 0                # kaç kez enflasyon oldu
var enf_aralik := 10               # kaç turda bir (0 = kapalı)
var enf_oran := 0.2                # her seferinde kira artışı

# --- YENİ ARAYÜZ PARÇALARI ---
var _gosterge: Label = null        # sol üstte "TUR 7 · KİRA ×1,20"
var _insa_butonu_kutusu: Control = null
var _insa_butonu: Button = null
var _insa_paneli: Control = null
var _insa_listesi: VBoxContainer = null
var _bilgi_kuyrugu: Array = []     # sırada bekleyen bilgi şeritleri
var _bilgi_oncelikli := false
var _salla_bekleme := 0.0
var _salla_ipucu_gosterildi := false
var _ekstra_zar_bekliyor := false   # telefonda: ekstra zar seçildi, sallama bekleniyor
var _ekstra_buton_metni := ""

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
	"Adiyaman": {"fiyat": 600, "baslangic_kirasi": 150, "renk": Color(0.2, 0.6, 0.3)},
	"Ankara": {"fiyat": 450, "baslangic_kirasi": 100, "renk": Color(0.2, 0.4, 0.8)},
	"Istanbul": {"fiyat": 500, "baslangic_kirasi": 120, "renk": Color(0.2, 0.4, 0.8)}
}


# ==========================================
# ŞANS DESTESİ (24 kart)
# ------------------------------------------
# tur: "oyuncu" (oyuncu seçtirir), "sehir" (şehir seçtirir), "herkes" (herkesi etkiler),
#      "el" (elde saklanır), "para", "hareket"
# ==========================================
const KART_BILGILERI := {
	"dogum_gunu": {"baslik": "DOĞUM GÜNÜ HEDİYESİ", "tur": "oyuncu", "metin": "Bugün senin doğum günün! İstediğin bir oyuncu sana [b]100 TL[/b] hediye eder."},
	"borc_senedi": {"baslik": "BORÇ SENEDİ", "tur": "oyuncu", "metin": "İstediğin bir oyuncudan [b]150 TL[/b] borç al. Karşılığında o oyuncu, senin bir sonraki turuna kadar şehirlerinde kira ödemez."},
	"hayirsever": {"baslik": "HAYIRSEVER", "tur": "oyuncu", "metin": "İstediğin bir oyuncuya [b]100 TL[/b] bağışla. İyilik karşılıksız kalmaz: eline bir [b]Kira Kalkanı[/b] kartı geçer."},
	"yer_degistirme": {"baslik": "YER DEĞİŞTİRME", "tur": "oyuncu", "metin": "İstediğin bir oyuncuyla arabanın yerini değiştir. Kimse kira ödemez, sadece arabalar yer değiştirir."},
	"komsu_pazarligi": {"baslik": "KOMŞU PAZARLIĞI", "tur": "sehir", "metin": "Başka bir oyuncunun katsız bir şehrini liste fiyatından satın alabilirsin; satmayı reddedemez. Tekel grubundaki şehirler alınamaz."},
	"hapse_yolla": {"baslik": "HAPSE YOLLA", "tur": "oyuncu", "metin": "İstediğin bir oyuncuyu doğruca [b]hapse[/b] gönder!"},
	"dugun": {"baslik": "DÜĞÜN DAVETİYESİ", "tur": "herkes", "metin": "Düğünün var! Her oyuncu sana [b]50 TL[/b] takı takar."},
	"cay_ocagi": {"baslik": "ÇAY OCAĞI", "tur": "herkes", "metin": "En zengin oyuncu herkese [b]30 TL[/b] çay parası öder."},
	"bayram_harcligi": {"baslik": "BAYRAM HARÇLIĞI", "tur": "herkes", "metin": "En fakir oyuncu bankadan [b]100 TL[/b] harçlık alır."},
	"yazi_tura": {"baslik": "YAZI TURA", "tur": "herkes", "metin": "Senden sonra oynayacak oyuncuyla [b]100 TL[/b]'sine yazı tura atıyorsun! Tura gelirse sen kazanırsın."},
	"dedikodu": {"baslik": "DEDİKODU", "tur": "herkes", "metin": "Mahallede dedikodu yayıldı: herkesin toplam serveti (para + mülk) ortaya döküldü!"},
	"torpil": {"baslik": "TORPİL", "tur": "el", "metin": "Elinde saklanır. Hapse girmen gerektiğinde otomatik kullanılır ve [b]hapse girmezsin[/b]."},
	"kira_kalkani": {"baslik": "KİRA KALKANI", "tur": "el", "metin": "Elinde saklanır. Bir sonraki kira ödemende otomatik kullanılır, [b]o kirayı ödemezsin[/b]."},
	"cift_zar": {"baslik": "ÇİFT ZAR", "tur": "el", "metin": "Elinde saklanır. İstediğin bir turda Ekstra Zar'ı [b]bedava[/b] atarsın."},
	"ihale_karti": {"baslik": "İHALE KARTI", "tur": "el", "metin": "Elinde saklanır. Kazandığın bir sonraki banka ihalesinde [b]%20 indirim[/b] alırsın."},
	"vergi_affi": {"baslik": "VERGİ AFFI", "tur": "para", "metin": "Devlet vergi affı çıkardı! Bankadan [b]150 TL[/b] al."},
	"trafik_cezasi": {"baslik": "TRAFİK CEZASI", "tur": "para", "metin": "Radara yakalandın! Bankaya [b]100 TL[/b] öde."},
	"emlak_vergisi": {"baslik": "EMLAK VERGİSİ", "tur": "para", "metin": "Sahip olduğun her kat için [b]25 TL[/b] emlak vergisi öde. (Plaza 4 kat sayılır.)"},
	"bayram_trafigi": {"baslik": "BAYRAM TRAFİĞİ", "tur": "hareket", "metin": "Yollar kilit! [b]3 kare geri[/b] git."},
	"otoyol": {"baslik": "OTOYOL AÇILDI", "tur": "hareket", "metin": "Yeni otoyol açıldı! Doğruca [b]Başlangıç[/b]'a git ve maaşını al."},
	"ucak_bileti": {"baslik": "UÇAK BİLETİ", "tur": "sehir", "metin": "İstediğin [b]boş şehre[/b] uç! Almak isteyip istemediğine orada karar verirsin."},
	"yanlis_adres": {"baslik": "YANLIŞ ADRES", "tur": "hareket", "metin": "Polis seni başkasıyla karıştırdı! Doğruca [b]hapse[/b] git."},
	"kentsel_donusum": {"baslik": "KENTSEL DÖNÜŞÜM", "tur": "para", "metin": "Tekelindeki en ucuz şehre [b]bedava bir kat[/b] çıkılır. Kat çıkabileceğin şehir yoksa devlet [b]100 TL[/b] destek verir."},
	"piyango": {"baslik": "PİYANGO", "tur": "para", "metin": "Bilet aldın, zar atılıyor! [b]6[/b] gelirse [b]300 TL[/b] kazanırsın; gelmezse 30 TL bilet parası ödersin."}
}
const ELDE_KART_ADLARI := {"torpil": "Torpil", "kira_kalkani": "Kira Kalkanı", "cift_zar": "Çift Zar", "ihale_karti": "İhale Kartı"}
const EL_SINIRI := 2                          # Bir oyuncu elinde en fazla kaç kart tutabilir
# Deneme için: doluysa oyunun başında kartlar önce bu sırayla çekilir (ör. ["piyango", "torpil"])
const TEST_DESTESI: Array = []
const DESTE_KONUMU := Vector2(1461, 640)      # Tahtada zarların üstü: en üstteki kartın sol üst köşesi
const DESTE_KART_BOYU := Vector2(112, 146)

var _deste: Array = []              # Sunucu: çekilecek kartlar (sondan çekilir)
var _deste_kalan := 24              # Herkes: destede kalan kart sayısı (sağ üstteki rozet)
var _test_destesi_kullanildi := false
var _bekleyen_kart := ""            # Ekranda açık olan şans kartı
var _bekleyen_ek := 0               # Kartla birlikte sunucunun attığı zar (piyango, yazı tura)
var _bekleyen_secimli := false      # Kart bir oyuncu/şehir seçimi bekliyor mu?
var _muafiyetler: Array = []        # Borç senedi: {"odeyen": i, "alan": j} — j'nin sıradaki turuna kadar geçerli
var _deste_kartlari: Array = []     # Tahtadaki deste katmanları (0 = en üstteki)
var _deste_bos: Control = null
var _deste_sayac: Label = null
var _kart_kutu: PanelContainer = null
var _kart_baslik: Label = null
var _kart_etiket: Label = null
var _kart_etiket_stili: StyleBoxFlat = null
var _kart_metin: RichTextLabel = null
var _kart_ek_bilgi: RichTextLabel = null
var _kart_secenek_izgara: GridContainer = null
var _kart_durum: Label = null
var _serif: Font = null

# ==========================================
# ÇEVRİMİÇİ (AYNI Wİ-Fİ) ALTYAPISI
# ------------------------------------------
# Mantık: Oyunu kuran cihaz (sunucu) tek karar vericidir. Zar, şans kartı,
# bot kararları ve süreler sadece sunucuda üretilir. Her eylem bir "komut"
# olarak tüm cihazlara gönderilir ve her cihaz komutları AYNI SIRAYLA işler.
# Böylece herkes aynı oyunu görür. Çevrimdışı oyunda aynı komutlar doğrudan
# yerelde işlenir, yani tek oyunculu mod eskisi gibi çalışır.
# ==========================================
var online := false
var _kuyruk: Array = []
var _isleniyor := false
var _senkron_bekleniyor := false   # İstemci: sunucudan ilk durum gelene kadar komutları yok say
var _tur_basi := false             # Zar atılmayı bekleyen tur başı mı?
var _oyun_basladi_mi := false      # Sunucu: ilk tur başlatıldı mı?
var _devir_bekleyen: Array = []    # Sunucu: geri dönen ve sıradaki turda kontrolü alacak oyuncular
var _bilgi_etiketi: Label = null

# --- v2.3: tepkiler, efektler, ödüller, bot kişilikleri ---
const TEPKILER := ["Hahaha!", "Bravo!", "Of ya!", "Kirayı öde!", "Şanslısın!", "Hadi oyna!", "Bekle sen!", "GG"]
const TEPKI_ARALIGI_MS := 1200      # Bir oyuncu en fazla bu sıklıkla tepki atabilir (sunucu kontrol eder)
var _tepki_butonu: Button = null
var _tepki_paneli: PanelContainer = null
var _tepki_balonlari := {}          # oyuncu -> ekrandaki balon
var _son_tepki := {}                # Sunucu: oyuncu -> son tepki zamanı
var _son_yerel_tepki := -100000
var _sarsinti_tween: Tween = null
var _dunya_orijin := Vector2.ZERO
var _borca_dusenler := {}           # borca girip mülk satan oyuncular ("Son Anda Kurtulan")

# Bot kişilikleri isimden gelir (lobide bot eklenince bu isimler verilir)
const VARSAYILAN_KISILIK := {"alim_yedek": 0, "ihale": 1.0, "ihale_yedek": 100, "insa_yedek": 200, "insa_kat": 2, "yukselt_yedek": 0, "ekstra": 30, "ekstra_para": 800, "kefalet": 300, "tepki": 35}
const BOT_KISILIKLERI := {
	# Her şeyi alır, ihalede coşar, parasını tuğlaya gömer
	"Emlakçı Ekrem": {"alim_yedek": 0, "ihale": 1.3, "ihale_yedek": 50, "insa_yedek": 150, "insa_kat": 3, "yukselt_yedek": 0, "ekstra": 20, "ekstra_para": 600, "kefalet": 300, "tepki": 50},
	# Kenara para koyar, ihalede ucuzcudur, hapiste beklemeyi kefalete tercih eder
	"Temkinli Tülay": {"alim_yedek": 350, "ihale": 0.85, "ihale_yedek": 250, "insa_yedek": 500, "insa_kat": 1, "yukselt_yedek": 400, "ekstra": 0, "ekstra_para": 99999, "kefalet": 900, "tepki": 25},
	# Ekstra zara bayılır, riskten korkmaz
	"Kumarbaz Kemal": {"alim_yedek": 0, "ihale": 1.1, "ihale_yedek": 100, "insa_yedek": 150, "insa_kat": 2, "yukselt_yedek": 100, "ekstra": 70, "ekstra_para": 400, "kefalet": 300, "tepki": 70},
}
var _bilgi_kutusu: Control = null
var _bilgi_stili: StyleBoxFlat = null
var _bilgi_sayaci := 0.0

const SADECE_SUNUCU := ["hareket", "sans_karti", "ihale_sure", "ihale_bitti", "ihale_kapat", "sonraki_tur", "durum", "baslat", "dustu", "bilgi"]

func _yetkili() -> bool:
	return not online or multiplayer.is_server()

func _yerel() -> int:
	return Ag.yerel_indeks if online else 0

# Şu anki kararı bu cihazdaki oyuncu mu verecek?
func _kontrol_bende() -> bool:
	var o = oyuncular[aktif_oyuncu_indeksi]
	if o["yapay_zeka"]:
		return false
	if not online:
		return true
	return aktif_oyuncu_indeksi == Ag.yerel_indeks

func _panel_acik_mi() -> bool:
	return tapu_karti.visible or bildirim_paneli.visible or oyun_bitti_paneli.visible or yukseltme_paneli.visible or sans_karti_paneli.visible or hapishane_paneli.visible or satis_paneli.visible or ihale_paneli.visible

# Botlar, zamanlayıcılar ve sunucu mantığı için
func _komut(ad: String, args: Array = []):
	_komutu_gonder(ad, args, -1)

# Bu cihazdaki oyuncunun buton basışları için
func _oyuncu_komutu(ad: String, args: Array = []):
	if online and not multiplayer.is_server():
		if not _senkron_bekleniyor:
			Ag.oyun_istegi_gonder(ad, args)
		return
	_komutu_gonder(ad, args, _yerel())

func _komutu_gonder(ad: String, args: Array, gonderen: int):
	if not online:
		_komutu_uygula(ad, args)
		return
	if not multiplayer.is_server():
		return
	if not _komut_gecerli(ad, args, gonderen):
		return
	Ag.oyun_komutu_yayinla(ad, args)

# İstemciden gelen buton isteği (Ag üzerinden iletilir)
func _komut_istegi_isle(peer_id: int, ad: String, args: Array):
	if not online or not multiplayer.is_server():
		return
	if SADECE_SUNUCU.has(ad):
		return
	var indeks = Ag.peer_indeksi(peer_id)
	if indeks == -1:
		return
	_komutu_gonder(ad, args, indeks)

# Komutlar sırayla işlenir; zar hareketi bitmeden sonraki komut başlamaz
func _komutu_uygula(ad: String, args: Array):
	# Tepkiler oyun akışını etkilemez: sıraya girmeden hemen gösterilir
	if ad == "tepki":
		if args.size() == 2:
			_tepki_goster(int(args[0]), int(args[1]))
		return
	_kuyruk.append([ad, args])
	if _isleniyor:
		return
	_isleniyor = true
	while not _kuyruk.is_empty():
		var k = _kuyruk.pop_front()
		await _komutu_isle(k[0], k[1])
	_isleniyor = false

func _komutu_isle(ad: String, a: Array):
	if _senkron_bekleniyor and ad != "durum":
		return
	match ad:
		"baslat": siradaki_turu_baslat()
		"durum": _durumu_uygula(a[0])
		"zar": _zar_komutu(bool(a[0]))
		"hareket": await _hareketi_oynat(int(a[0]), int(a[1]), bool(a[2]))
		"sans_karti": sans_kartini_goster(str(a[0]), int(a[1]), int(a[2]), bool(a[3]))
		"karti_kapat": await _karti_kapat()
		"kart_secim": await _kart_secimi(str(a[0]), str(a[1]))
		"tamam": _tamam()
		"satin_al": _satin_al(str(a[0]))
		"pas_gec": _pas_gec()
		"insa": _insa(str(a[0]))
		"evet": _yukselt()
		"hayir": _yukseltme_iptal()
		"kefalet": _kefalet()
		"yat": _yat()
		"sat": _sat(str(a[0]))
		"ihaleye_cikar": _ihaleye_cikar(str(a[0]))
		"teklif": _teklifi_artir(int(a[0]))
		"ihale_pas": _ihale_pas(int(a[0]))
		"ihale_sure": _ihale_sure(int(a[0]))
		"ihale_bitti": _ihale_sonuclandir()
		"ihale_kapat": _ihale_kapat()
		"sonraki_tur": _iflas_sonrasi_devam()
		"dustu": _oyuncu_dustu(int(a[0]))
		"bilgi": _bilgi_goster(str(a[0]))

# Sunucu, her komutu göndermeden önce oyun durumuna uygun mu diye kontrol eder
func _komut_gecerli(ad: String, a: Array, g: int) -> bool:
	if ad == "tepki":
		return _tepki_gecerli(a, g)
	if g >= 0:
		if SADECE_SUNUCU.has(ad):
			return false
		if oyuncular[g]["yapay_zeka"] or not oyuncular[g]["aktif_mi"]:
			return false
		if ad == "teklif" or ad == "ihale_pas":
			if a.size() < 1 or int(a[0]) != g:
				return false
		elif g != aktif_oyuncu_indeksi:
			return false
	var o = oyuncular[aktif_oyuncu_indeksi]
	match ad:
		"zar":
			return a.size() == 1 and _tur_basi and not hareket_ediyor and not o["hapiste_mi"] and not _panel_acik_mi()
		"karti_kapat":
			return sans_karti_paneli.visible and not _bekleyen_secimli
		"kart_secim":
			return a.size() == 2 and sans_karti_paneli.visible and _bekleyen_secimli and str(a[0]) == _bekleyen_kart and _kart_secimi_gecerli(_bekleyen_kart, str(a[1]))
		"tamam":
			return bildirim_paneli.visible and tamam_butonu.visible
		"satin_al":
			return tapu_karti.visible and a.size() == 1 and str(a[0]) == harita_sirasi[o["konum"]]
		"pas_gec":
			return tapu_karti.visible
		"insa":
			if a.size() != 1 or not sehirler.has(str(a[0])):
				return false
			return _tur_basi and not hareket_ediyor and not o["hapiste_mi"] and not _panel_acik_mi() and _insa_edilebilir_mi(aktif_oyuncu_indeksi, str(a[0])) and o["para"] >= _insa_bedeli(str(a[0]))
		"evet", "hayir":
			return yukseltme_paneli.visible
		"kefalet", "yat":
			return hapishane_paneli.visible
		"sat", "ihaleye_cikar":
			if a.size() != 1 or ihale_aktif or o["para"] >= 0:
				return false
			var s = str(a[0])
			return mülkiyet_durumu.has(s) and mülkiyet_durumu[s]["sahip"] == aktif_oyuncu_indeksi
		"teklif":
			if a.size() != 1 or not ihale_aktif:
				return false
			var i = int(a[0])
			if i < 0 or i > 3:
				return false
			return oyuncular[i]["aktif_mi"] and i != ihale_verileri["satici"] and i != ihale_verileri["kazanan_indeks"] and not ihale_verileri["cekilenler"].has(i) and oyuncular[i]["para"] >= _siradaki_teklif()
		"ihale_pas":
			return ihale_aktif
		"ihale_bitti":
			return ihale_aktif
	return true

func _gecikmeli(sure: float, ad: String, args: Array = []):
	await get_tree().create_timer(sure).timeout
	if not is_inside_tree():
		return
	_komut(ad, args)

# --- DURUM EŞİTLEME (her tur başında ve yeniden bağlanmada) ---
func _durum_al() -> Dictionary:
	var liste = []
	for o in oyuncular:
		liste.append({"para": o["para"], "konum": o["konum"], "hapiste_mi": o["hapiste_mi"], "hapis_turu": o["hapis_turu"], "aktif_mi": o["aktif_mi"], "yapay_zeka": o["yapay_zeka"], "kartlar": o["kartlar"].duplicate(), "ist": o["ist"].duplicate()})
	return {"aktif": aktif_oyuncu_indeksi, "oyuncular": liste, "mulk": mülkiyet_durumu.duplicate(true), "tur_basi": _tur_basi, "tur": tur_sayaci, "enf": enf_kademe, "deste": _deste_kalan, "muaf": _muafiyetler.duplicate(true)}

func _durum_yayinla():
	if online and multiplayer.is_server():
		Ag.oyun_komutu_yayinla("durum", [_durum_al()])

func _durumu_uygula(d: Dictionary):
	if _yetkili():
		return
	var ilk = _senkron_bekleniyor
	_senkron_bekleniyor = false
	aktif_oyuncu_indeksi = int(d["aktif"])
	for i in range(4):
		var s = d["oyuncular"][i]
		var o = oyuncular[i]
		var konum_degisti = o["konum"] != int(s["konum"])
		o["konum"] = int(s["konum"])
		o["para"] = int(s["para"])
		o["hapiste_mi"] = bool(s["hapiste_mi"])
		o["hapis_turu"] = int(s["hapis_turu"])
		o["aktif_mi"] = bool(s["aktif_mi"])
		o["yapay_zeka"] = bool(s["yapay_zeka"])
		o["kartlar"] = s.get("kartlar", []).duplicate()
		if s.has("ist"):
			o["ist"] = s["ist"].duplicate()
		if konum_degisti and not hareket_ediyor:
			_piyonu_yerlestir(i)
		if i < Global.oyuncu_sayisi:
			o["piyon"].visible = o["aktif_mi"]
		if ilk:
			eski_bakiyeler[i] = o["para"]
	if not _mulkler_ayni_mi(d["mulk"]):
		mülkiyet_durumu = d["mulk"].duplicate(true)
		_evleri_yeniden_ciz()
	_tur_basi = bool(d["tur_basi"])
	tur_sayaci = int(d.get("tur", tur_sayaci))
	enf_kademe = int(d.get("enf", enf_kademe))
	_deste_kalan = int(d.get("deste", _deste_kalan))
	_muafiyetler = d.get("muaf", []).duplicate(true)
	_desteyi_ciz()
	_tum_kiralari_guncelle()
	_gostergeyi_guncelle()
	piyonlarin_konumlarini_duzenle()
	arayuzu_guncelle()
	_butonlari_yenile()
	if ilk:
		_bilgi_goster("Oyuna bağlandın!")
	# Sıra bize geçtiyse (ör. geri dönen oyuncu) zar panelini aç
	if _tur_basi and _kontrol_bende() and not oyuncular[aktif_oyuncu_indeksi]["hapiste_mi"] and not hareket_ediyor and not _panel_acik_mi() and not zar_secim_paneli.visible:
		_zar_panelini_goster()

func _mulkler_ayni_mi(diger: Dictionary) -> bool:
	if diger.size() != mülkiyet_durumu.size():
		return false
	for sehir in diger.keys():
		if not mülkiyet_durumu.has(sehir):
			return false
		if int(mülkiyet_durumu[sehir]["sahip"]) != int(diger[sehir]["sahip"]) or int(mülkiyet_durumu[sehir]["seviye"]) != int(diger[sehir]["seviye"]):
			return false
	return true

func _piyonu_yerlestir(i: int):
	var curve = path_2d.curve
	var k = clampi(oyuncular[i]["konum"], 0, curve.get_point_count() - 1)
	if k == 0:
		oyuncular[i]["piyon"].progress = 0.0
	else:
		oyuncular[i]["piyon"].progress = curve.get_closest_offset(curve.get_point_position(k))

func _evleri_yeniden_ciz():
	for c in path_2d.get_children():
		if str(c.name).begins_with("Ev_"):
			path_2d.remove_child(c)
			c.queue_free()
	for sehir in sehirler.keys():
		var seviye = 0
		if mülkiyet_durumu.has(sehir):
			seviye = int(mülkiyet_durumu[sehir]["seviye"])
			var konum = harita_sirasi.find(sehir)
			var renk = oyuncular[int(mülkiyet_durumu[sehir]["sahip"])]["renk"]
			if seviye >= 4:
				insaa_et_gorsel_ev(konum, renk, 4)
			else:
				for j in range(seviye + 1):
					insaa_et_gorsel_ev(konum, renk, j)
	_tum_kiralari_guncelle()

func _butonlari_yenile():
	var kontrol = not _kontrol_bende()
	satin_al_butonu.disabled = kontrol
	pas_gec_butonu.disabled = kontrol
	evet_butonu.disabled = kontrol
	hayir_butonu.disabled = kontrol
	karti_kapat_butonu.disabled = kontrol
	kefalet_butonu.disabled = kontrol
	yat_butonu.disabled = kontrol
	tamam_butonu.disabled = kontrol
	sat_butonu.disabled = kontrol
	ihaleye_cikar_butonu.disabled = kontrol
	_insa_arayuzunu_yenile()
	_kart_butonlarini_yenile()

# --- BAĞLANTI OLAYLARI (sunucu) ---
func _cevrimici_hazirla():
	Ag.oyun_sahnesi_kaydet(self)
	if multiplayer.is_server():
		_bilgi_goster("Diğer oyuncular bekleniyor...", 15.0)
		# Sahnesi bizden önce yüklenen istemcilere başlangıç durumunu "baslat"tan ÖNCE gönder
		for peer_id in Ag.hazir_peerler.keys():
			if peer_id != 1:
				Ag.oyun_komutu_gonder(peer_id, "durum", [_durum_al()])
		Ag.oyuncu_dustu.connect(func(i): _komut("dustu", [i]))
		Ag.oyuncu_geri_dondu.connect(_on_oyuncu_geri_dondu)
		Ag.oyuncu_sahneye_hazir.connect(_on_oyuncu_sahneye_hazir)
		# Yavaş bir telefon yüzünden oyun sonsuza kadar beklemesin
		get_tree().create_timer(15.0).timeout.connect(_baslangic_zaman_asimi)
		Ag.sahne_hazir()
	else:
		_senkron_bekleniyor = true
		_bilgi_goster("Oyuna bağlanılıyor...")
		Ag.oyun_sahnesi_kaydet(self)
		Ag.sahne_hazir()

func _baslangic_zaman_asimi():
	if is_inside_tree() and not _oyun_basladi_mi:
		_oyun_basladi_mi = true
		_komut("baslat")

func _on_oyuncu_sahneye_hazir(peer_id: int):
	if peer_id != 1:
		Ag.oyun_komutu_gonder(peer_id, "durum", [_durum_al()])
	_baslangici_kontrol_et()

func _baslangici_kontrol_et():
	if _oyun_basladi_mi:
		return
	for y in Ag.yuvalar:
		if not y["bot"] and y["bagli"] and not Ag.hazir_peerler.has(y["peer"]):
			return
	_oyun_basladi_mi = true
	_bilgi_goster("Herkes hazır!", 1.5)
	_komut("baslat")

func _on_oyuncu_geri_dondu(i: int, _peer_id: int):
	if not _devir_bekleyen.has(i):
		_devir_bekleyen.append(i)
	_komut("bilgi", [oyuncular[i]["isim"] + " geri döndü, sıradaki turdan itibaren oynayacak."])

func _oyuncu_dustu(i: int):
	oyuncular[i]["yapay_zeka"] = true
	_devir_bekleyen.erase(i)
	_bilgi_goster(oyuncular[i]["isim"] + " bağlantısı koptu. Geri dönene kadar bot oynuyor.")
	_butonlari_yenile()
	if online and multiplayer.is_server():
		_baslangici_kontrol_et()
		_bot_devral(i)

# Bağlantısı kopan oyuncunun bekleyen kararını bot versin
func _bot_devral(i: int):
	if i != aktif_oyuncu_indeksi or hareket_ediyor:
		return
	var o = oyuncular[i]
	if tapu_karti.visible:
		_bot_tapu_karari(harita_sirasi[o["konum"]])
	elif yukseltme_paneli.visible:
		var dy = harita_sirasi[o["konum"]]
		_bot_yukseltme_karari(int(sehirler[dy]["fiyat"] * [0.5, 0.75, 1.0, 1.5][mülkiyet_durumu[dy]["seviye"]]))
	elif sans_karti_paneli.visible:
		if _bekleyen_secimli:
			_bot_kart_secimi()
		else:
			_gecikmeli(1.0, "karti_kapat")
	elif hapishane_paneli.visible:
		_bot_hapis_karari()
	elif bildirim_paneli.visible and tamam_butonu.visible:
		_gecikmeli(1.0, "tamam")
	elif satis_paneli.visible:
		ai_mulk_sat(satilabilir_mulkleri_getir(i))
	elif _tur_basi and not o["hapiste_mi"]:
		ai_hamle_yap()

# --- BOT KARARLARI (sadece sunucuda) ---
func _bot_tapu_karari(sehir: String):
	await get_tree().create_timer(1.0).timeout
	if not is_inside_tree(): return
	var i = aktif_oyuncu_indeksi
	var para = oyuncular[i]["para"]
	var fiyat = sehirler[sehir]["fiyat"]
	if para >= fiyat and (para - fiyat >= int(_kisilik(i)["alim_yedek"]) or _grubu_tamamlar_mi(i, sehir)):
		_komut("satin_al", [sehir])
	else:
		_komut("pas_gec")

func _bot_yukseltme_karari(bedel: int):
	await get_tree().create_timer(1.5).timeout
	if not is_inside_tree(): return
	if oyuncular[aktif_oyuncu_indeksi]["para"] - bedel >= int(_kisilik(aktif_oyuncu_indeksi)["yukselt_yedek"]):
		_komut("evet")
	else:
		_komut("hayir")

func _bot_hapis_karari():
	await get_tree().create_timer(2.0).timeout
	if not is_inside_tree(): return
	if oyuncular[aktif_oyuncu_indeksi]["para"] >= maxi(300, int(_kisilik(aktif_oyuncu_indeksi)["kefalet"])):
		_komut("kefalet")
	else:
		_komut("yat")

# --- KISA BİLGİ YAZISI (ekranın üstünde) ---
func _bilgi_goster(metin: String, sure := 4.0, renk := Color(1, 0.82, 0.3), oncelikli := false):
	if _bilgi_etiketi == null:
		return
	# Ekranda önemli bir mesaj varsa yenisi sıraya girer (en fazla 3); yoksa hemen gösterilir
	if _bilgi_kutusu.visible and _bilgi_sayaci > 0 and (_bilgi_oncelikli or not _bilgi_kuyrugu.is_empty()):
		if _bilgi_kuyrugu.size() < 3:
			_bilgi_kuyrugu.append([metin, sure, renk, oncelikli])
		return
	_bilgi_oncelikli = oncelikli
	_bilgi_etiketi.text = metin
	# Kısa yazı tek satırda kalır; uzunsa en fazla BILGI_YAZI_MAKS genişliğinde alt satıra geçer
	var yazi_tipi = _bilgi_etiketi.get_theme_font("font")
	var yazi_boyu = _bilgi_etiketi.get_theme_font_size("font_size")
	var genislik = yazi_tipi.get_string_size(metin, HORIZONTAL_ALIGNMENT_LEFT, -1, yazi_boyu).x + 4
	_bilgi_etiketi.custom_minimum_size.x = minf(genislik, BILGI_YAZI_MAKS)
	_bilgi_stili.border_color = renk
	_bilgi_kutusu.visible = true
	_bilgi_sayaci = sure
	# Küçük bir "belirme" animasyonu
	_bilgi_kutusu.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(_bilgi_kutusu, "modulate:a", 1.0, 0.25)

# Bilgi şeridi ekranın tam ortasında, üstteki şehir kartlarının hemen altındaki bantta durur.
# Bakiye paneli ve tur göstergesi bu bandın altına indirildi (SOL_PANEL_KAYMA), ikisi çakışmaz.
const BILGI_YAZI_MAKS := 1160.0   # şerit en fazla x=340..1580 arası; uzun yazı 2 satıra iner
const SOL_PANEL_KAYMA := 100.0    # bakiye paneli 244 → 344, gösterge 472 → 572

func _bilgi_kutusunu_kur():
	# Şehir kartlarının hemen altında yuvarlak köşeli bilgi şeridi; uzun yazılar aşağı doğru iki satıra iner
	var merkez = HBoxContainer.new()
	merkez.alignment = BoxContainer.ALIGNMENT_CENTER
	merkez.anchor_left = 0.0
	merkez.anchor_right = 1.0
	merkez.offset_top = 212
	merkez.offset_bottom = 420
	merkez.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Arayuz.add_child(merkez)
	
	var kutu = PanelContainer.new()
	kutu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	kutu.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	_bilgi_stili = StyleBoxFlat.new()
	_bilgi_stili.bg_color = Color(0.05, 0.07, 0.1, 0.88)
	_bilgi_stili.set_corner_radius_all(36)
	_bilgi_stili.set_border_width_all(3)
	_bilgi_stili.border_color = Color(1, 0.82, 0.3)
	_bilgi_stili.shadow_color = Color(0, 0, 0, 0.45)
	_bilgi_stili.shadow_size = 14
	_bilgi_stili.content_margin_left = 40
	_bilgi_stili.content_margin_right = 40
	_bilgi_stili.content_margin_top = 10
	_bilgi_stili.content_margin_bottom = 12
	kutu.add_theme_stylebox_override("panel", _bilgi_stili)
	merkez.add_child(kutu)
	
	_bilgi_etiketi = Label.new()
	_bilgi_etiketi.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_bilgi_etiketi.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_bilgi_etiketi.add_theme_font_size_override("font_size", 32)
	_bilgi_etiketi.add_theme_color_override("font_color", Color.WHITE)
	_bilgi_etiketi.mouse_filter = Control.MOUSE_FILTER_IGNORE
	kutu.add_child(_bilgi_etiketi)
	
	_bilgi_kutusu = merkez
	_bilgi_kutusu.hide()

	# Bakiye panelini bilgi şeridinin altına indir (sahne dosyasına dokunmadan, kodla)
	$Arayuz/OyuncuPaneli.position.y += SOL_PANEL_KAYMA

# ==========================================
# OYUN
# ==========================================
func _para_sesini_tek_cal():
	if para_sesi_player:
		para_sesi_player.stop()
		para_sesi_player.play(0)

func _ready():
	online = Ag.online and Ag.oyun_basladi
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
	duraklatma_ekrani.hide()

	# --- YENİ: DURAKLATMA MENÜSÜ SİNYAL BAĞLANTILARI ---
	tam_ekran_butonu.toggled.connect(_on_tam_ekran_degisti)
	hiz_slider.value_changed.connect(_on_hiz_degisti)
	muzik_slider.value_changed.connect(_on_muzik_degisti)
	efekt_slider.value_changed.connect(_on_efekt_degisti)
	devam_butonu.pressed.connect(_on_devam_basildi)
	yeniden_baslat_butonu_menu.pressed.connect(_on_yeniden_baslat_basildi)
	ana_menu_butonu.pressed.connect(_on_ana_menu_basildi)
	ayarlar_butonu.pressed.connect(oyunu_duraklat_veya_devam_et)
	# Kodla sonradan eklenen arayüz parçaları (inşaat butonu, gösterge, uçan yazılar...)
	# Ayarlar ekranının üstüne çıkmasın: her yeni eklemede Ayarlar en üste alınır
	$Arayuz.child_entered_tree.connect(func(_n): _ayarlari_en_uste_al.call_deferred())
	# Başlangıç değerlerini senkronize et
	var muzik_bus = AudioServer.get_bus_index("Muzik")
	var efekt_bus = AudioServer.get_bus_index("Efekt")
	muzik_slider.value = AudioServer.get_bus_volume_db(muzik_bus)
	efekt_slider.value = AudioServer.get_bus_volume_db(efekt_bus)
	var mevcut_mod = DisplayServer.window_get_mode()
	tam_ekran_butonu.button_pressed = (mevcut_mod == DisplayServer.WINDOW_MODE_FULLSCREEN or mevcut_mod == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

	# Çevrimiçi oyunda oyun hızı herkeste aynı olmalı ve oyun tek kişi tarafından yeniden başlatılamaz
	if online:
		Engine.time_scale = 1.0
		hiz_slider.hide()
		var hiz_etiketi = duraklatma_ekrani.get_node_or_null("Panel/VBoxContainer/Label2")
		if hiz_etiketi: hiz_etiketi.hide()
		yeniden_baslat_butonu_menu.hide()
		yeniden_baslat_butonu.text = "ANA MENÜ"

	# Üstte kısa bilgi şeridi
	_bilgi_kutusunu_kur()

	# Renk grupları, enflasyon ayarı ve yeni arayüz parçaları
	_gruplari_hazirla()
	var enf_modu = int(Ag.oyun_ayarlari.get("enflasyon", 1))
	if enf_modu == 0:
		enf_aralik = 0
	elif enf_modu == 2:
		enf_aralik = 8
		enf_oran = 0.25
	else:
		enf_aralik = 10
		enf_oran = 0.2
	_grup_seritlerini_ciz()
	_gostergeyi_kur()
	_insa_arayuzunu_kur()
	_desteyi_kur()
	_kart_arayuzunu_kur()
	_ekstra_buton_metni = taktiksel_zar_butonu.text
	_tepki_arayuzunu_kur()
	_dunya_orijin = position

	# ----------------------------------------------------

	oyuncular = [
		{"isim": "Oyuncu 1", "para": 1500, "konum": 0, "renk": Color.RED, "piyon": piyon_kirmizi, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": false, "aktif_mi": true, "kartlar": []},
		{"isim": "Bot 1", "para": 1500, "konum": 0, "renk": Color.BLUE, "piyon": piyon_mavi, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": true, "aktif_mi": true, "kartlar": []},
		{"isim": "Bot 2", "para": 1500, "konum": 0, "renk": Color.YELLOW, "piyon": piyon_sari, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": true, "aktif_mi": true, "kartlar": []},
		{"isim": "Bot 3", "para": 1500, "konum": 0, "renk": Color.GREEN, "piyon": piyon_yesil, "hapiste_mi": false, "hapis_turu": 0, "yapay_zeka": true, "aktif_mi": true, "kartlar": []}
	]
	for o in oyuncular:
		o["ist"] = {"kira_aldi": 0, "kira_odedi": 0, "hapis": 0, "insa": 0, "kurtulus": 0}
	if online:
		for i in range(4):
			if i < Ag.yuvalar.size():
				var y = Ag.yuvalar[i]
				oyuncular[i]["yapay_zeka"] = y["bot"] or not y["bagli"]
	if Global.oyuncu_sayisi == 2:
		oyuncular[2]["aktif_mi"] = false
		oyuncular[2]["piyon"].hide()
		oyuncular[3]["aktif_mi"] = false
		oyuncular[3]["piyon"].hide()
	elif Global.oyuncu_sayisi == 3:
		oyuncular[3]["aktif_mi"] = false
		oyuncular[3]["piyon"].hide()

	for i in range(4):
		var ayarlar = Global.oyuncu_ayarlari[i]
		oyuncular[i]["isim"] = ayarlar["isim"]
		oyuncular[i]["renk"] = ayarlar["renk"]

		var p = oyuncular[i]["piyon"]
		var araba_sprite = null

		for alt_dugum in p.get_children():
			if alt_dugum is Sprite2D:
				araba_sprite = alt_dugum
				break

		if araba_sprite != null:
			araba_sprite.texture = araba_kaplamalari[ayarlar["araba_indeksi"]]
			araba_sprite.modulate = ayarlar["renk"]
			araba_sprite.scale = Vector2(0.18, 0.18)
			araba_sprite.rotation_degrees = 90

	for i in range(4):
		eski_bakiyeler[i] = oyuncular[i]["para"]
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

	if _yetkili():
		_desteyi_karistir()
	_desteyi_ciz()
	piyonlarin_konumlarini_duzenle()
	_tum_kiralari_guncelle()
	_gostergeyi_guncelle()
	if online:
		_cevrimici_hazirla()
	else:
		siradaki_turu_baslat()



func arayuzu_guncelle():
	var bakiye_metni = ""

	for i in range(Global.oyuncu_sayisi):
		var o = oyuncular[i]

		if o["aktif_mi"]:
			if eski_bakiyeler.size() > 0:
				var fark = o["para"] - eski_bakiyeler[i]
				if fark != 0:
					bakiye_degisim_animasyonu_oynat(i, fark)
					eski_bakiyeler[i] = o["para"]

			var hex_renk = o["renk"].to_html(false)
			var ek = ""
			if online and i == Ag.yerel_indeks:
				ek = " (sen)"
			elif online and o["yapay_zeka"] and i < Ag.yuvalar.size() and not Ag.yuvalar[i]["bot"]:
				ek = " (bağlantı yok)"

			if i == aktif_oyuncu_indeksi:
				bakiye_metni += "[b][color=#" + hex_renk + "]▶ " + o["isim"] + ek + " : " + str(o["para"]) + " ₺[/color][/b]\n" + _el_satiri(o) + "\n"
			else:
				bakiye_metni += "[color=#" + hex_renk + "]   " + o["isim"] + ek + " : " + str(o["para"]) + " ₺[/color]\n" + _el_satiri(o) + "\n"
		else:
			bakiye_metni += "[color=gray]   " + o["isim"] + " : (İFLAS)[/color]\n\n"

	if bakiye_etiketi:
		bakiye_etiketi.text = bakiye_metni

func sirayi_sonraki_oyuncuya_gecir():
	var onceki = aktif_oyuncu_indeksi
	# Borca girip mülk satarak ayakta kalan oyuncu
	if _borca_dusenler.has(onceki):
		_borca_dusenler.erase(onceki)
		if oyuncular[onceki]["aktif_mi"] and oyuncular[onceki]["para"] >= 0:
			oyuncular[onceki]["ist"]["kurtulus"] += 1
	var dongu_korumasi = 0
	while dongu_korumasi < 4:
		aktif_oyuncu_indeksi = (aktif_oyuncu_indeksi + 1) % 4
		if oyuncular[aktif_oyuncu_indeksi]["aktif_mi"]:
			break
		dongu_korumasi += 1
	# Sıra başa döndüyse bir tur tamamlandı
	if aktif_oyuncu_indeksi <= onceki:
		_tur_tamamlandi()

	arayuzu_guncelle()
	zar_paneli.hide()
	siradaki_turu_baslat()

func siradaki_turu_baslat():
	# Sunucu: geri dönen oyunculara kontrolü tur başında geri ver
	if online and multiplayer.is_server():
		for i in _devir_bekleyen:
			if i < Ag.yuvalar.size() and Ag.yuvalar[i]["bagli"]:
				oyuncular[i]["yapay_zeka"] = false
		_devir_bekleyen.clear()

	# Borç senedi muafiyeti, senedi veren oyuncunun sırası gelince biter
	var gecerli_muaf = []
	for m in _muafiyetler:
		if int(m["alan"]) != aktif_oyuncu_indeksi and oyuncular[int(m["odeyen"])]["aktif_mi"] and oyuncular[int(m["alan"])]["aktif_mi"]:
			gecerli_muaf.append(m)
	_muafiyetler = gecerli_muaf

	_tur_basi = true
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]

	if o_oyuncu["hapiste_mi"] and o_oyuncu["hapis_turu"] == 2:
		o_oyuncu["hapiste_mi"] = false
		o_oyuncu["hapis_turu"] = 0

	_durum_yayinla()
	arayuzu_guncelle()

	if _kontrol_bende():
		_titret(60)
		if online:
			_bilgi_goster("SIRA SENDE!", 2.5, o_oyuncu_rengi())

	if o_oyuncu["hapiste_mi"]:
		zar_at_ve_ilerle(false)
	else:
		if o_oyuncu["yapay_zeka"]:
			if _yetkili():
				ai_hamle_yap()
		elif _kontrol_bende():
			_zar_panelini_goster()

func o_oyuncu_rengi() -> Color:
	return oyuncular[aktif_oyuncu_indeksi]["renk"]

func _zar_panelini_goster():
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	taktiksel_zar_butonu.disabled = o_oyuncu["para"] < 100 and not _cift_zar_kartli()
	_ekstra_zar_secimini_sifirla()
	zar_secim_paneli.show()
	_insa_arayuzunu_yenile()
	if OS.has_feature("mobile") and not _salla_ipucu_gosterildi:
		_salla_ipucu_gosterildi = true
		_bilgi_goster("İpucu: Telefonu sallayarak zar atabilirsin! Ekstra zar için önce butona bas, sonra salla.", 4.0)

func _on_normal_zar_basildi():
	if not zar_secim_paneli.visible or not _kontrol_bende(): return
	_ekstra_zar_secimini_sifirla()
	_oyuncu_komutu("zar", [false])

# PC'de ekstra zar butona basınca direkt atılır.
# Telefonda önce seçilir ("Telefonu Salla!"), 100 TL ancak sallayınca düşer.
# Seçiliyken butona tekrar basılırsa sallamadan atılır.
func _on_taktiksel_zar_basildi():
	if not zar_secim_paneli.visible or not _kontrol_bende(): return
	if oyuncular[aktif_oyuncu_indeksi]["para"] < 100 and not _cift_zar_kartli(): return
	if OS.has_feature("mobile") and not _ekstra_zar_bekliyor:
		_ekstra_zar_bekliyor = true
		if _ekstra_buton_metni == "":
			_ekstra_buton_metni = taktiksel_zar_butonu.text
		taktiksel_zar_butonu.text = "SALLA!\n(KART)" if _cift_zar_kartli() else "SALLA!\n(-100 TL)"   # orijinal yazıdan geniş olmamalı, yoksa buton taşar
		taktiksel_zar_butonu.modulate = Color(1.25, 1.15, 0.6)
		_titret(40)
		_bilgi_goster("Ekstra zar seçildi — telefonu salla!", 2.5)
		return
	_ekstra_zar_at()

func _ekstra_zar_at():
	_ekstra_zar_secimini_sifirla()
	if oyuncular[aktif_oyuncu_indeksi]["para"] >= 100 or _cift_zar_kartli():
		_oyuncu_komutu("zar", [true])

func _ekstra_zar_secimini_sifirla():
	_ekstra_zar_bekliyor = false
	if _ekstra_buton_metni != "":
		taktiksel_zar_butonu.text = _ekstra_buton_yazisi()
	taktiksel_zar_butonu.modulate = Color.WHITE

func _zar_komutu(ekstra_zar: bool):
	_tur_basi = false
	zar_secim_paneli.hide()
	_insa_arayuzunu_yenile()
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	if ekstra_zar:
		if o_oyuncu["kartlar"].has("cift_zar"):
			o_oyuncu["kartlar"].erase("cift_zar")
			arayuzu_guncelle()
			_bilgi_goster(o_oyuncu["isim"] + " Çift Zar kartını kullandı: ekstra zar bedava!", 2.5, o_oyuncu["renk"])
		elif o_oyuncu["para"] >= 100:
			o_oyuncu["para"] -= 100
			eski_bakiyeler[aktif_oyuncu_indeksi] = o_oyuncu["para"]
			arayuzu_guncelle()
		else:
			ekstra_zar = false
	zar_at_ve_ilerle(ekstra_zar)

func ai_hamle_yap():
	await get_tree().create_timer(1.0).timeout
	if not is_inside_tree(): return
	# Tekeli varsa önce inşaat: en pahalı şehirden başlar; kat sayısı ve yedek para kişiliğe göre
	var kisilik = _kisilik(aktif_oyuncu_indeksi)
	for _kat in range(int(kisilik["insa_kat"])):
		var secenek = _insa_secenekleri(aktif_oyuncu_indeksi)
		if secenek.is_empty():
			break
		secenek.sort_custom(func(x, y): return sehirler[x]["fiyat"] > sehirler[y]["fiyat"])
		if oyuncular[aktif_oyuncu_indeksi]["para"] - _insa_bedeli(secenek[0]) < int(kisilik["insa_yedek"]):
			break
		_komut("insa", [secenek[0]])
		await get_tree().create_timer(0.7).timeout
		if not is_inside_tree(): return
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	var ekstra_zar_kullan = false

	if not o_oyuncu["hapiste_mi"] and o_oyuncu["para"] > int(kisilik["ekstra_para"]):
		if randi() % 100 < int(kisilik["ekstra"]):
			ekstra_zar_kullan = true
	if not o_oyuncu["hapiste_mi"] and o_oyuncu["kartlar"].has("cift_zar"):
		ekstra_zar_kullan = true

	_komut("zar", [ekstra_zar_kullan])

func zar_at_ve_ilerle(ekstra_zar: bool):
	if hareket_ediyor or tapu_karti.visible or bildirim_paneli.visible or oyun_bitti_paneli.visible or yukseltme_paneli.visible or sans_karti_paneli.visible or hapishane_paneli.visible or satis_paneli.visible or ihale_paneli.visible:
		return

	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]

	if o_oyuncu["hapiste_mi"]:
		if o_oyuncu["hapis_turu"] == 1:
			hapis_yazisi.text = o_oyuncu["isim"] + " OYUNCUSU HAPİSTESİN!\n\n300 TL kefalet ödeyip hemen zarı atabilir veya 1 tur içeride yatabilirsin."
			kefalet_butonu.text = "300 TL\nKefalet Öde"
			kefalet_butonu.disabled = not _kontrol_bende()
			yat_butonu.disabled = not _kontrol_bende()
			kefalet_butonu.show()
			hapishane_paneli.show()
			if o_oyuncu["yapay_zeka"] and _yetkili():
				_bot_hapis_karari()
			return

	# Zarı sadece sunucu atar, sonuç herkese gönderilir
	if _yetkili():
		var zar1 = randi_range(1, 6)
		var zar2 = 0
		if ekstra_zar:
			zar2 = randi_range(1, 3)
		_komut("hareket", [zar1, zar2, ekstra_zar])

func _hareketi_oynat(zar1: int, zar2: int, ekstra_zar: bool):
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	_tur_basi = false
	hareket_ediyor = true

	var toplam_zar = zar1 + zar2

	zar_paneli.show()
	zar_gorseli.show()
	# Tek zar tepsinin ortasında, iki zar yan yana
	zar_gorseli.position = Vector2(104, 48) if ekstra_zar else Vector2(149, 48)
	if ekstra_zar:
		ekstra_zar_gorseli.show()
	else:
		ekstra_zar_gorseli.hide()

	var zar_kareleri = {6: 0, 5: 1, 4: 2, 3: 3, 2: 4, 1: 5}
	zar_gorseli.frame = zar_kareleri[zar1]
	if ekstra_zar:
		ekstra_zar_gorseli.frame = zar_kareleri[zar2]

	await zar_animasyonu_oynat()

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

	_kareye_vardi()

# Araba bir kareye vardığında o karenin olayı: şans kartı, hapis, kira, tapu.
# Zar hareketinden sonra ve kartla gidilen karelerde (Bayram trafiği, Uçak bileti) kullanılır.
func _kareye_vardi():
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	hareket_ediyor = false
	piyonlarin_konumlarini_duzenle()
	var durulan_yer = harita_sirasi[o_oyuncu["konum"]]

	if durulan_yer == "Sans_Karti":
		sans_kartini_cek(o_oyuncu)
	elif durulan_yer == "Hapishane":
		if o_oyuncu["kartlar"].has("torpil"):
			o_oyuncu["kartlar"].erase("torpil")
			arayuzu_guncelle()
			bildirim_yazisi.text = "[center]\n\n\n[font_size=20][b][color=#55dd77]TORPİL![/color][/b][/font_size]\n\nPolis çevirmesinde tanıdık çıktı. Torpil kartın kullanıldı, hapse girmiyorsun![/center]"
		else:
			o_oyuncu["hapiste_mi"] = true
			o_oyuncu["hapis_turu"] = 1
			o_oyuncu["ist"]["hapis"] += 1
			_rastgele_bot_tepkisi(aktif_oyuncu_indeksi, 0, 0.6)
			if _kontrol_bende():
				_titret(300)
			bildirim_yazisi.text = "[center]\n\n\n[font_size=20][b][color=#ff3333]KADER MAHKÛMU![/color][/b][/font_size]\n\nPolis çevirmesine takıldın. Doğruca hapishaneye gidiyorsun![/center]"
		tamam_butonu.disabled = not _kontrol_bende()
		bildirim_paneli.show()
		if o_oyuncu["yapay_zeka"] and _yetkili():
			_gecikmeli(2.0, "tamam")

	elif sehirler.has(durulan_yer):
		var fiyat = sehirler[durulan_yer]["fiyat"]
		if mülkiyet_durumu.has(durulan_yer):
			var sahip_indeksi = mülkiyet_durumu[durulan_yer]["sahip"]
			var mevcut_seviye = mülkiyet_durumu[durulan_yer]["seviye"]

			if sahip_indeksi == aktif_oyuncu_indeksi:
				if mevcut_seviye < 4:
					var yukseltme_bedeli = int(fiyat * [0.5, 0.75, 1.0, 1.5][mevcut_seviye])
					var sonraki_kira = _kira_hesapla(durulan_yer, mevcut_seviye + 1)

					evet_butonu.disabled = not _kontrol_bende()
					hayir_butonu.disabled = not _kontrol_bende()
					yukseltme_panelini_goster(durulan_yer.to_upper(), mevcut_seviye, yukseltme_bedeli, sonraki_kira)

					if o_oyuncu["yapay_zeka"] and _yetkili():
						_bot_yukseltme_karari(yukseltme_bedeli)
				else:
					sirayi_sonraki_oyuncuya_gecir()
			else:
				var kira_bedeli = _kira_hesapla(durulan_yer)
				bekleyen_kira["aktif"] = false
				if _kira_muaf_mi(aktif_oyuncu_indeksi, sahip_indeksi):
					# Borç senedi: senedi veren oyuncunun şehirlerinde bu tur kira yok
					bildirim_yazisi.text = "[center]\n[font_size=20][b][color=#7fd4ff]BORÇ SENEDİ![/color][/b][/font_size]\n\n" + oyuncular[sahip_indeksi]["isim"] + " oyuncusuna ait " + durulan_yer.to_upper() + " şehrine bastın.\n\nBorç senedi sayesinde bu turluk kira ödemiyorsun.\n\n[s]" + str(kira_bedeli) + " TL[/s][/center]"
				elif o_oyuncu["kartlar"].has("kira_kalkani"):
					o_oyuncu["kartlar"].erase("kira_kalkani")
					arayuzu_guncelle()
					bildirim_yazisi.text = "[center]\n[font_size=20][b][color=#55dd77]KİRA KALKANI![/color][/b][/font_size]\n\n" + oyuncular[sahip_indeksi]["isim"] + " oyuncusuna ait " + durulan_yer.to_upper() + " şehrine bastın.\n\nKira Kalkanı kartın kullanıldı, bu kirayı ödemiyorsun.\n\n[s]" + str(kira_bedeli) + " TL[/s][/center]"
				else:
					# Kiranın neden yüksek olduğunu söyle: tekel ve/veya enflasyon
					var aciklama = "(Tamam'a bastığında bakiyenden düşülecektir)"
					var notlar = []
					if _tekel_mi(sahip_indeksi, durulan_yer):
						notlar.append("[color=gold]TEKEL: grubun tamamı onun[/color]")
					if enf_kademe > 0:
						notlar.append("[color=#ff7766]enflasyon ×" + _carpan_yazisi() + "[/color]")
					if not notlar.is_empty():
						aciklama = " · ".join(PackedStringArray(notlar))

					bekleyen_kira = {"aktif": true, "odeyen": aktif_oyuncu_indeksi, "alan": sahip_indeksi, "miktar": kira_bedeli}
					bildirim_yazisi.text = "[center]\n[font_size=20][b][color=#ffaa00]KİRA ÖDEMESİ![/color][/b][/font_size]\n\n" + oyuncular[sahip_indeksi]["isim"] + " oyuncusuna ait " + durulan_yer.to_upper() + " şehrine bastın.\n\n[b]Ödemen Gereken: " + str(kira_bedeli) + " TL[/b]\n\n" + aciklama + "[/center]"
					if _kontrol_bende():
						_titret(220)
				tamam_butonu.disabled = not _kontrol_bende()
				bildirim_paneli.show()

				if o_oyuncu["yapay_zeka"] and _yetkili():
					_gecikmeli(2.0, "tamam")
		else:
			tapu_kartini_goster(durulan_yer)
	else:
		sirayi_sonraki_oyuncuya_gecir()

# ==========================================
# ŞANS DESTESİ: ÇEKME, GÖSTERME, SEÇİM VE ETKİLER
# ------------------------------------------
# Desteyi sadece sunucu tutar ve karıştırır. Çekilen kart, destede kalan sayı ve
# kartın zarı (piyango, yazı tura) herkese "sans_karti" komutuyla gider. Seçim
# isteyen kartlarda kartı çeken oyuncu "kart_secim" gönderir, etki her cihazda
# aynı sırayla uygulanır.
# ==========================================
# Sunucu: desteyi elde tutulan kartlar hariç yeniden karıştırır
func _desteyi_karistir():
	var liste: Array = KART_BILGILERI.keys().duplicate()
	for o in oyuncular:
		for kart in o.get("kartlar", []):
			liste.erase(kart)
	liste.shuffle()
	if not _test_destesi_kullanildi:
		_test_destesi_kullanildi = true
		for i in range(TEST_DESTESI.size() - 1, -1, -1):
			var t = str(TEST_DESTESI[i])
			if liste.has(t):
				liste.erase(t)
				liste.append(t)
	_deste = liste
	_deste_kalan = _deste.size()

func sans_kartini_cek(_oyuncu):
	# Kartı sadece sunucu çeker
	if not _yetkili():
		return
	var karisti = false
	if _deste.is_empty():
		_desteyi_karistir()
		karisti = true
	var kart = str(_deste.pop_back())
	_komut("sans_karti", [kart, _deste.size(), randi_range(1, 6), karisti])

func sans_kartini_goster(kart: String, kalan: int, ek: int, karisti: bool):
	if not KART_BILGILERI.has(kart):
		kart = "vergi_affi"
	_deste_kalan = kalan
	_desteyi_ciz()
	if karisti:
		_bilgi_goster("Şans destesi karıştırıldı!", 2.0)

	_bekleyen_kart = kart
	_bekleyen_ek = ek
	var secenekler = _kart_secenekleri(kart)
	_bekleyen_secimli = not secenekler.is_empty()
	_kart_panelini_doldur(kart, secenekler)

	if sans_karti_sesi_player:
		sans_karti_sesi_player.stop()
		sans_karti_sesi_player.play(0)
	if _kontrol_bende():
		_titret(60)

	sans_karti_paneli.visible = true
	_kart_animasyonu()

	if oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"] and _yetkili():
		if _bekleyen_secimli:
			_bot_kart_secimi()
		else:
			_gecikmeli(3.0, "karti_kapat")

func _on_karti_kapat_basildi():
	if not sans_karti_paneli.visible or _bekleyen_secimli or not _kontrol_bende(): return
	_oyuncu_komutu("karti_kapat")

func _karti_kapat():
	if not sans_karti_paneli.visible:
		return
	sans_karti_paneli.hide()
	await _kart_etkisini_uygula(_bekleyen_kart, "")

func _on_kart_secenek_basildi(deger: String):
	if not sans_karti_paneli.visible or not _bekleyen_secimli or not _kontrol_bende():
		return
	for b in _kart_secenek_izgara.get_children():
		if b is Button:
			b.disabled = true
	_oyuncu_komutu("kart_secim", [_bekleyen_kart, deger])
	# İstek bir sebeple kabul edilmezse butonlar tekrar açılsın
	get_tree().create_timer(2.0).timeout.connect(_kart_butonlarini_yenile)

func _kart_secimi(kart: String, deger: String):
	if not sans_karti_paneli.visible or kart != _bekleyen_kart:
		return
	sans_karti_paneli.hide()
	await _kart_etkisini_uygula(kart, deger)

# Kartın seçenekleri (oyuncular ya da şehirler). Boş dizi: kart seçim beklemez.
# Her cihaz aynı oyun durumundan aynı listeyi üretir.
func _kart_secenekleri(kart: String) -> Array:
	var liste = []
	var ben = aktif_oyuncu_indeksi
	if str(KART_BILGILERI[kart]["tur"]) == "oyuncu":
		for i in range(4):
			if i == ben or not oyuncular[i]["aktif_mi"]:
				continue
			if (kart == "yer_degistirme" or kart == "hapse_yolla") and oyuncular[i]["hapiste_mi"]:
				continue
			liste.append({"deger": str(i), "yazi": oyuncular[i]["isim"] + "\n" + str(oyuncular[i]["para"]) + " ₺", "renk": oyuncular[i]["renk"], "aktif": true})
	elif kart == "ucak_bileti":
		for s in harita_sirasi:
			if sehirler.has(s) and not mülkiyet_durumu.has(s):
				liste.append({"deger": s, "yazi": _gorunen_ad(s) + "\n" + str(sehirler[s]["fiyat"]) + " TL", "renk": sehirler[s]["renk"], "aktif": true})
	elif kart == "komsu_pazarligi":
		for s in harita_sirasi:
			if not mülkiyet_durumu.has(s):
				continue
			var sahip = int(mülkiyet_durumu[s]["sahip"])
			if sahip == ben or not oyuncular[sahip]["aktif_mi"] or int(mülkiyet_durumu[s]["seviye"]) > 0 or _tekel_mi(sahip, s):
				continue
			liste.append({"deger": s, "yazi": _gorunen_ad(s) + "\n" + oyuncular[sahip]["isim"] + " · " + str(sehirler[s]["fiyat"]) + " TL", "renk": oyuncular[sahip]["renk"], "aktif": oyuncular[ben]["para"] >= sehirler[s]["fiyat"]})
		if not liste.is_empty():
			liste.append({"deger": "-", "yazi": "Vazgeç", "renk": Color(0.45, 0.4, 0.35), "aktif": true})
	return liste

func _kart_secimi_gecerli(kart: String, deger: String) -> bool:
	if not KART_BILGILERI.has(kart):
		return false
	for s in _kart_secenekleri(kart):
		if str(s["deger"]) == deger and s["aktif"]:
			return true
	return false

# Kartın etkisi (her cihazda aynı sırayla). Sonunda tur biter ya da gidilen karenin olayı başlar.
func _kart_etkisini_uygula(kart: String, deger: String):
	var ben = aktif_oyuncu_indeksi
	var o = oyuncular[ben]
	var ek = _bekleyen_ek
	var t = int(deger) if deger.is_valid_int() else -1
	if t >= 0 and (t == ben or t > 3 or not oyuncular[t]["aktif_mi"]):
		t = -1
	_bekleyen_kart = ""
	_bekleyen_secimli = false

	match kart:
		"dogum_gunu":
			if t >= 0:
				var miktar = _para_aktar(t, ben, 100)
				_hedefi_titret(t)
				_kart_bilgisi("DOĞUM GÜNÜ: " + oyuncular[t]["isim"] + " → " + o["isim"] + "  " + str(miktar) + " TL hediye")
		"borc_senedi":
			if t >= 0:
				var miktar = _para_aktar(t, ben, 150)
				_muafiyetler.append({"odeyen": t, "alan": ben})
				_hedefi_titret(t)
				_kart_bilgisi("BORÇ SENEDİ: " + oyuncular[t]["isim"] + " → " + o["isim"] + "  " + str(miktar) + " TL  ·  " + oyuncular[t]["isim"] + " bir tur kira ödemez")
		"hayirsever":
			if t >= 0:
				_para_aktar(ben, t, 100)
				var mesaj = "HAYIRSEVER: " + o["isim"] + " → " + oyuncular[t]["isim"] + "  100 TL"
				if _ele_kart_ekle(ben, "kira_kalkani"):
					mesaj += "  ·  Kira Kalkanı kazandı"
				_kart_bilgisi(mesaj)
		"yer_degistirme":
			if t >= 0:
				await _yer_degistir(ben, t)
				_kart_bilgisi("YER DEĞİŞTİRME: " + o["isim"] + " ve " + oyuncular[t]["isim"] + " yer değiştirdi")
		"komsu_pazarligi":
			if mülkiyet_durumu.has(deger):
				var sahip = int(mülkiyet_durumu[deger]["sahip"])
				var f = int(sehirler[deger]["fiyat"])
				if sahip != ben and o["para"] >= f:
					o["para"] -= f
					oyuncular[sahip]["para"] += f
					mülkiyet_durumu[deger]["sahip"] = ben
					_evleri_boya(deger, o["renk"])
					_tum_kiralari_guncelle()
					_para_sesini_tek_cal()
					_hedefi_titret(sahip)
					_kart_bilgisi("KOMŞU PAZARLIĞI: " + _gorunen_ad(deger) + ", " + oyuncular[sahip]["isim"] + " → " + o["isim"] + "  (" + str(f) + " TL)")
					_tekel_kontrol(ben, deger)
		"hapse_yolla":
			if t >= 0:
				_hedefi_titret(t)
				await _kartla_hapse(t)
		"dugun":
			var toplam = 0
			for i in range(4):
				if i != ben and oyuncular[i]["aktif_mi"]:
					toplam += _para_aktar(i, ben, 50)
			_kart_bilgisi("DÜĞÜN: " + o["isim"] + " toplam " + str(toplam) + " TL takı topladı")
		"cay_ocagi":
			var z = _en_zengin()
			for i in range(4):
				if i != z and oyuncular[i]["aktif_mi"]:
					_para_aktar(z, i, 30)
			_kart_bilgisi("ÇAY OCAĞI: " + oyuncular[z]["isim"] + " herkese 30 TL çay parası ödedi", oyuncular[z]["renk"])
		"bayram_harcligi":
			var f = _en_fakir()
			_para_aktar(-1, f, 100)
			_kart_bilgisi("BAYRAM HARÇLIĞI: " + oyuncular[f]["isim"] + " bankadan 100 TL aldı", oyuncular[f]["renk"])
		"yazi_tura":
			var r = _sonraki_aktif(ben)
			if r != ben:
				var tura = ek % 2 == 0
				var kazanan = ben if tura else r
				var kaybeden = r if tura else ben
				var miktar = _para_aktar(kaybeden, kazanan, 100)
				_kart_bilgisi(("TURA" if tura else "YAZI") + "!  " + oyuncular[kazanan]["isim"] + " kazandı  (+" + str(miktar) + " TL)", oyuncular[kazanan]["renk"])
		"dedikodu":
			pass
		"torpil", "kira_kalkani", "cift_zar", "ihale_karti":
			if _ele_kart_ekle(ben, kart):
				_kart_bilgisi(o["isim"] + " elinde saklıyor: " + str(ELDE_KART_ADLARI[kart]))
			else:
				_kart_bilgisi("Elin dolu (en fazla " + str(EL_SINIRI) + " kart)! " + str(ELDE_KART_ADLARI[kart]) + " desteye döndü.")
		"vergi_affi":
			_para_aktar(-1, ben, 150)
		"trafik_cezasi":
			_para_aktar(ben, -1, 100)
		"emlak_vergisi":
			var kat = _toplam_kat(ben)
			if kat > 0:
				_para_aktar(ben, -1, kat * 25)
				_kart_bilgisi("EMLAK VERGİSİ: " + str(kat) + " kat × 25 = " + str(kat * 25) + " TL")
		"bayram_trafigi":
			hareket_ediyor = true
			await _geri_yuru(ben, 3)
			_kareye_vardi()
			return
		"otoyol":
			hareket_ediyor = true
			await _baslangica_sur(ben)
			o["para"] += tur_maasi
			_para_sesini_tek_cal()
		"ucak_bileti":
			if sehirler.has(deger):
				hareket_ediyor = true
				await _isinla(ben, harita_sirasi.find(deger))
				_kareye_vardi()
				return
			_para_aktar(-1, ben, 100)   # Boş şehir kalmadı: bilet iadesi
		"yanlis_adres":
			await _kartla_hapse(ben)
		"kentsel_donusum":
			var hedef = _kentsel_donusum_hedefi(ben)
			if hedef != "":
				mülkiyet_durumu[hedef]["seviye"] += 1
				var yeni_kat = int(mülkiyet_durumu[hedef]["seviye"])
				insaa_et_gorsel_ev(harita_sirasi.find(hedef), o["renk"], yeni_kat)
				_tum_kiralari_guncelle()
				_kart_bilgisi("KENTSEL DÖNÜŞÜM: " + _gorunen_ad(hedef) + " → " + ("plaza" if yeni_kat == 4 else str(yeni_kat) + ". kat") + " (bedava)")
			else:
				_para_aktar(-1, ben, 100)
				_kart_bilgisi("KENTSEL DÖNÜŞÜM: devletten 100 TL destek")
		"piyango":
			if ek == 6:
				_para_aktar(-1, ben, 300)
				_kart_bilgisi("PİYANGO: zar 6 — KAZANDIN!  +300 TL")
			else:
				_para_aktar(ben, -1, 30)
				_kart_bilgisi("PİYANGO: zar " + str(ek) + " — olmadı, 30 TL bilet parası")
	_kart_turunu_bitir()

func _kart_turunu_bitir():
	hareket_ediyor = false
	piyonlarin_konumlarini_duzenle()
	arayuzu_guncelle()
	if oyuncular[aktif_oyuncu_indeksi]["para"] < 0:
		borc_kontrolu()
	else:
		sirayi_sonraki_oyuncuya_gecir()

# Para aktarımı (-1 = banka). Sırası gelmeyen oyuncu elindekinden fazlasını ödemez;
# sırası gelen oyuncu eksiye düşebilir (tur sonunda borç kontrolü yapılır).
func _para_aktar(odeyen: int, alan: int, miktar: int) -> int:
	var tutar = miktar
	if odeyen >= 0:
		if odeyen != aktif_oyuncu_indeksi:
			tutar = mini(tutar, maxi(int(oyuncular[odeyen]["para"]), 0))
		oyuncular[odeyen]["para"] -= tutar
	if alan >= 0:
		oyuncular[alan]["para"] += tutar
	if tutar > 0:
		_para_sesini_tek_cal()
	return tutar

func _ele_kart_ekle(i: int, kart: String) -> bool:
	if oyuncular[i]["kartlar"].size() >= EL_SINIRI:
		return false
	oyuncular[i]["kartlar"].append(kart)
	arayuzu_guncelle()
	return true

func _kart_bilgisi(metin: String, renk := Color(0, 0, 0, 0)):
	_bilgi_goster(metin, 3.5, o_oyuncu_rengi() if renk.a == 0.0 else renk)

# Kartın hedefi bu telefondaki oyuncuysa telefon titrer
func _hedefi_titret(i: int):
	if i == _yerel() and not oyuncular[i]["yapay_zeka"]:
		_titret(150)

func _kira_muaf_mi(odeyen: int, alan: int) -> bool:
	for m in _muafiyetler:
		if int(m["odeyen"]) == odeyen and int(m["alan"]) == alan:
			return true
	return false

func _en_zengin() -> int:
	var z = -1
	for i in range(4):
		if oyuncular[i]["aktif_mi"] and (z == -1 or oyuncular[i]["para"] > oyuncular[z]["para"]):
			z = i
	return z

func _en_fakir() -> int:
	var f = -1
	for i in range(4):
		if oyuncular[i]["aktif_mi"] and (f == -1 or oyuncular[i]["para"] < oyuncular[f]["para"]):
			f = i
	return f

func _sonraki_aktif(i: int) -> int:
	for adim in range(1, 4):
		var j = (i + adim) % 4
		if oyuncular[j]["aktif_mi"]:
			return j
	return i

func _toplam_kat(i: int) -> int:
	var kat = 0
	for s in mülkiyet_durumu.keys():
		if int(mülkiyet_durumu[s]["sahip"]) == i:
			kat += int(mülkiyet_durumu[s]["seviye"])
	return kat

# Toplam servet: para + şehirlerin alış fiyatı + dikilen katların maliyeti
func _servet(i: int) -> int:
	var toplam = int(oyuncular[i]["para"])
	var maliyet = [0.5, 0.75, 1.0, 1.5]
	for s in mülkiyet_durumu.keys():
		if int(mülkiyet_durumu[s]["sahip"]) == i:
			var f = sehirler[s]["fiyat"]
			toplam += f
			for x in range(int(mülkiyet_durumu[s]["seviye"])):
				toplam += int(f * maliyet[x])
	return toplam

func _servet_siralamasi() -> String:
	var liste = []
	for i in range(4):
		if oyuncular[i]["aktif_mi"]:
			liste.append(i)
	liste.sort_custom(func(a, b): return _servet(a) > _servet(b))
	var satirlar = []
	for n in range(liste.size()):
		satirlar.append(str(n + 1) + ".  " + _renkli_isim(liste[n]) + "  —  " + str(_servet(liste[n])) + " TL")
	return "\n".join(PackedStringArray(satirlar))

# Krem kart zemininde okunsun diye oyuncu rengi biraz koyulaştırılır
func _renkli_isim(i: int) -> String:
	return "[color=#" + oyuncular[i]["renk"].darkened(0.35).to_html(false) + "][b]" + oyuncular[i]["isim"] + "[/b][/color]"

func _kentsel_donusum_hedefi(i: int) -> String:
	var hedef = ""
	for s in _insa_secenekleri(i):
		if hedef == "" or sehirler[s]["fiyat"] < sehirler[hedef]["fiyat"]:
			hedef = s
	return hedef

func _evleri_boya(sehir: String, renk: Color):
	var konum = harita_sirasi.find(sehir)
	for i in range(5):
		var ev_node = path_2d.get_node_or_null("Ev_" + str(konum) + "_" + str(i))
		if ev_node:
			ev_node.modulate = renk

# Bakiye panelinde oyuncunun altındaki satır: elindeki kartlar
func _el_satiri(o: Dictionary) -> String:
	var kartlar: Array = o.get("kartlar", [])
	if kartlar.is_empty():
		return ""
	var adlar = []
	for k in kartlar:
		adlar.append(str(ELDE_KART_ADLARI.get(k, k)))
	# Sondaki normal boyutlu boşluk satır yüksekliğini korur (uçan para yazıları kaymasın)
	return "    [font_size=15][color=#ffd34d]Kart: " + " · ".join(PackedStringArray(adlar)) + "[/color][/font_size] "

func _cift_zar_kartli() -> bool:
	return oyuncular[aktif_oyuncu_indeksi]["kartlar"].has("cift_zar")

func _ekstra_buton_yazisi() -> String:
	if _cift_zar_kartli():
		return "Ekstra Zar\n(KART)"
	return _ekstra_buton_metni

# --- KARTLA HAREKET ---
# Araba yol boyunca sürmeden kaybolup yeni yerinde belirir
func _isinla(i: int, hedef: int):
	var p = oyuncular[i]["piyon"]
	var tw = create_tween()
	tw.tween_property(p, "modulate:a", 0.0, 0.25)
	await tw.finished
	oyuncular[i]["konum"] = hedef
	_piyonu_yerlestir(i)
	piyonlarin_konumlarini_duzenle()
	var tw2 = create_tween()
	tw2.tween_property(p, "modulate:a", 1.0, 0.3)
	await tw2.finished

func _yer_degistir(a: int, b: int):
	hareket_ediyor = true
	var pa = oyuncular[a]["piyon"]
	var pb = oyuncular[b]["piyon"]
	var tw = create_tween().set_parallel(true)
	tw.tween_property(pa, "modulate:a", 0.0, 0.25)
	tw.tween_property(pb, "modulate:a", 0.0, 0.25)
	await tw.finished
	var k = oyuncular[a]["konum"]
	oyuncular[a]["konum"] = oyuncular[b]["konum"]
	oyuncular[b]["konum"] = k
	_piyonu_yerlestir(a)
	_piyonu_yerlestir(b)
	piyonlarin_konumlarini_duzenle()
	var tw2 = create_tween().set_parallel(true)
	tw2.tween_property(pa, "modulate:a", 1.0, 0.3)
	tw2.tween_property(pb, "modulate:a", 1.0, 0.3)
	await tw2.finished

# Kare kare geri gider (Başlangıç'tan geriye sarar, maaş verilmez)
func _geri_yuru(i: int, adim: int):
	var o = oyuncular[i]
	var curve = path_2d.curve
	for _a in range(adim):
		if o["konum"] == 0:
			o["piyon"].progress = curve.get_baked_length()
			o["konum"] = toplam_kare_sayisi - 1
		else:
			o["konum"] -= 1
		var hedef = curve.get_closest_offset(curve.get_point_position(clampi(o["konum"], 0, curve.get_point_count() - 1)))
		if o["konum"] == 0:
			hedef = 0.0
		var tw = create_tween()
		tw.tween_property(o["piyon"], "progress", hedef, 0.25).set_trans(Tween.TRANS_SINE)
		await tw.finished
		await get_tree().create_timer(0.05).timeout

# Otoyol: yolun sonuna kadar hızla sürüp Başlangıç'a varır
func _baslangica_sur(i: int):
	var p = oyuncular[i]["piyon"]
	var tw = create_tween()
	tw.tween_property(p, "progress", path_2d.curve.get_baked_length(), 0.9).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	p.progress = 0.0
	oyuncular[i]["konum"] = 0
	piyonlarin_konumlarini_duzenle()

# Kartla hapis (Yanlış adres, Hapse yolla). Elinde Torpil varsa kart kullanılır, hapse girmez.
func _kartla_hapse(i: int):
	var o = oyuncular[i]
	if o["kartlar"].has("torpil"):
		o["kartlar"].erase("torpil")
		arayuzu_guncelle()
		_kart_bilgisi("TORPİL! " + o["isim"] + " son anda hapisten yırttı.", o["renk"])
		return
	hareket_ediyor = true
	await _isinla(i, harita_sirasi.find("Hapishane"))
	o["hapiste_mi"] = true
	o["hapis_turu"] = 1
	o["ist"]["hapis"] += 1
	_kart_bilgisi(o["isim"] + " hapse girdi!", Color(1, 0.4, 0.35))

# --- BOT KARARLARI (sunucuda) ---
func _bot_kart_secimi():
	var kart = _bekleyen_kart
	await get_tree().create_timer(3.0).timeout
	if not is_inside_tree() or not sans_karti_paneli.visible or not _bekleyen_secimli or _bekleyen_kart != kart:
		return
	_komut("kart_secim", [kart, _bot_kart_karari(kart)])

func _bot_kart_karari(kart: String) -> String:
	var ben = aktif_oyuncu_indeksi
	var para = int(oyuncular[ben]["para"])
	var gecerli = []
	for s in _kart_secenekleri(kart):
		if s["aktif"]:
			gecerli.append(str(s["deger"]))
	if gecerli.is_empty():
		return "-"
	match kart:
		"ucak_bileti":
			# Parasının yettiği en pahalı boş şehir (100 TL yedek), yoksa en ucuzu
			var en_iyi = ""
			for s in gecerli:
				if para - sehirler[s]["fiyat"] >= 100 and (en_iyi == "" or sehirler[s]["fiyat"] > sehirler[en_iyi]["fiyat"]):
					en_iyi = s
			if en_iyi == "":
				en_iyi = gecerli[0]
				for s in gecerli:
					if sehirler[s]["fiyat"] < sehirler[en_iyi]["fiyat"]:
						en_iyi = s
			return en_iyi
		"komsu_pazarligi":
			# Önce grubunu tamamlayan şehir, yoksa 200 TL yedek bırakarak en pahalısı
			var en_iyi = "-"
			for s in gecerli:
				if s == "-":
					continue
				var tamamlar = true
				for g in _grup_sehirleri(s):
					if g != s and (not mülkiyet_durumu.has(g) or int(mülkiyet_durumu[g]["sahip"]) != ben):
						tamamlar = false
				if tamamlar:
					return s
				if para - sehirler[s]["fiyat"] >= 200 and (en_iyi == "-" or sehirler[s]["fiyat"] > sehirler[en_iyi]["fiyat"]):
					en_iyi = s
			return en_iyi
		"hayirsever":
			return _secenekteki_oyuncu(gecerli, false)     # en fakire bağışlar
		"yer_degistirme":
			return gecerli[randi() % gecerli.size()]
	return _secenekteki_oyuncu(gecerli, true)              # diğer kartlarda en zengini hedef alır

func _secenekteki_oyuncu(degerler: Array, en_zengin: bool) -> String:
	var secilen = str(degerler[0])
	for d in degerler:
		var p = oyuncular[int(d)]["para"]
		var q = oyuncular[int(secilen)]["para"]
		if (en_zengin and p > q) or (not en_zengin and p < q):
			secilen = str(d)
	return secilen

# --- KART EKRANI ---
func _serif_yazi_tipi() -> Font:
	if _serif == null:
		var f = SystemFont.new()
		f.font_names = PackedStringArray(["Georgia", "Cambria", "Times New Roman", "Noto Serif", "serif"])
		f.font_weight = 700
		_serif = f
	return _serif

func _kart_yazi_alani(boyut: int) -> RichTextLabel:
	var r = RichTextLabel.new()
	r.bbcode_enabled = true
	r.fit_content = true
	r.scroll_active = false
	r.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	r.custom_minimum_size = Vector2(570, 0)
	r.mouse_filter = Control.MOUSE_FILTER_IGNORE
	r.add_theme_font_size_override("normal_font_size", boyut)
	r.add_theme_font_size_override("bold_font_size", boyut)
	r.add_theme_color_override("default_color", Color(0.15, 0.12, 0.1))
	return r

# Ekranın ortasında açılan büyük şans kartı (eski küçük panelin yerine)
func _kart_arayuzunu_kur():
	var kok = CenterContainer.new()
	kok.set_anchors_preset(Control.PRESET_FULL_RECT)
	kok.mouse_filter = Control.MOUSE_FILTER_IGNORE
	kok.hide()
	$Arayuz.add_child(kok)

	_kart_kutu = PanelContainer.new()
	_kart_kutu.custom_minimum_size = Vector2(640, 0)
	var stil = StyleBoxFlat.new()
	stil.bg_color = Color(0.91, 0.89, 0.83)
	stil.set_corner_radius_all(22)
	stil.border_color = Color(0.29, 0.25, 0.21)
	stil.set_border_width_all(5)
	stil.shadow_color = Color(0, 0, 0, 0.55)
	stil.shadow_size = 22
	stil.content_margin_left = 34
	stil.content_margin_right = 34
	stil.content_margin_top = 18
	stil.content_margin_bottom = 26
	_kart_kutu.add_theme_stylebox_override("panel", stil)
	kok.add_child(_kart_kutu)

	var v = VBoxContainer.new()
	v.add_theme_constant_override("separation", 12)
	_kart_kutu.add_child(v)

	var ust = Label.new()
	ust.text = "Ş A N S   K A R T I"
	ust.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	ust.add_theme_font_override("font", _serif_yazi_tipi())
	ust.add_theme_font_size_override("font_size", 17)
	ust.add_theme_color_override("font_color", Color(0.45, 0.38, 0.3))
	v.add_child(ust)

	_kart_baslik = Label.new()
	_kart_baslik.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_kart_baslik.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_kart_baslik.add_theme_font_override("font", _serif_yazi_tipi())
	_kart_baslik.add_theme_font_size_override("font_size", 38)
	v.add_child(_kart_baslik)

	var etiket_ortala = CenterContainer.new()
	v.add_child(etiket_ortala)
	var etiket_kutu = PanelContainer.new()
	_kart_etiket_stili = StyleBoxFlat.new()
	_kart_etiket_stili.set_corner_radius_all(12)
	_kart_etiket_stili.content_margin_left = 16
	_kart_etiket_stili.content_margin_right = 16
	_kart_etiket_stili.content_margin_top = 3
	_kart_etiket_stili.content_margin_bottom = 4
	etiket_kutu.add_theme_stylebox_override("panel", _kart_etiket_stili)
	etiket_ortala.add_child(etiket_kutu)
	_kart_etiket = Label.new()
	_kart_etiket.add_theme_font_size_override("font_size", 15)
	_kart_etiket.add_theme_color_override("font_color", Color.WHITE)
	etiket_kutu.add_child(_kart_etiket)

	var cizgi = ColorRect.new()
	cizgi.custom_minimum_size = Vector2(0, 2)
	cizgi.color = Color(0.45, 0.38, 0.3, 0.55)
	v.add_child(cizgi)

	_kart_metin = _kart_yazi_alani(25)
	v.add_child(_kart_metin)
	_kart_ek_bilgi = _kart_yazi_alani(21)
	v.add_child(_kart_ek_bilgi)

	var izgara_ortala = CenterContainer.new()
	v.add_child(izgara_ortala)
	_kart_secenek_izgara = GridContainer.new()
	_kart_secenek_izgara.add_theme_constant_override("h_separation", 10)
	_kart_secenek_izgara.add_theme_constant_override("v_separation", 10)
	izgara_ortala.add_child(_kart_secenek_izgara)

	_kart_durum = Label.new()
	_kart_durum.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_kart_durum.add_theme_font_size_override("font_size", 19)
	_kart_durum.add_theme_color_override("font_color", Color(0.4, 0.34, 0.28))
	v.add_child(_kart_durum)

	var buton_ortala = CenterContainer.new()
	v.add_child(buton_ortala)
	var devam = Button.new()
	devam.text = "DEVAM ET"
	devam.custom_minimum_size = Vector2(260, 62)
	devam.add_theme_font_size_override("font_size", 26)
	devam.add_theme_color_override("font_color", Color.WHITE)
	devam.add_theme_color_override("font_disabled_color", Color(0.92, 0.92, 0.92))
	devam.add_theme_stylebox_override("normal", _stil_kutusu(Color(0.12, 0.45, 0.16), 12))
	devam.add_theme_stylebox_override("hover", _stil_kutusu(Color(0.16, 0.56, 0.2), 12))
	devam.add_theme_stylebox_override("pressed", _stil_kutusu(Color(0.09, 0.36, 0.12), 12))
	devam.add_theme_stylebox_override("disabled", _stil_kutusu(Color(0.55, 0.52, 0.48), 12))
	buton_ortala.add_child(devam)

	# Oyunun geri kalanı bu değişkenlerle çalışıyor (görünürlük kontrolleri, butonlar)
	sans_karti_paneli = kok
	karti_kapat_butonu = devam
	olay_yazisi = _kart_metin

func _kart_panelini_doldur(kart: String, secenekler: Array):
	var bilgi = KART_BILGILERI[kart]
	var tur = str(bilgi["tur"])
	var etiketler = {
		"oyuncu": ["OYUNCU SEÇ", Color(0.45, 0.24, 0.6)],
		"sehir": ["ŞEHİR SEÇ", Color(0.45, 0.24, 0.6)],
		"herkes": ["HERKESİ ETKİLER", Color(0.07, 0.47, 0.5)],
		"el": ["ELDE SAKLANIR", Color(0.6, 0.44, 0.06)],
		"para": ["PARA", Color(0.17, 0.48, 0.2)],
		"hareket": ["HAREKET", Color(0.14, 0.33, 0.62)]
	}
	var e = etiketler.get(tur, etiketler["para"])
	_kart_baslik.text = str(bilgi["baslik"])
	_kart_baslik.add_theme_color_override("font_color", Color(e[1]).darkened(0.3))
	_kart_etiket.text = str(e[0])
	_kart_etiket_stili.bg_color = e[1]
	_kart_metin.text = "[center]" + str(bilgi["metin"]) + "[/center]"
	var ek_bilgi = _kart_ek_bilgisi(kart, secenekler)
	_kart_ek_bilgi.text = "[center]" + ek_bilgi + "[/center]"
	_kart_ek_bilgi.visible = ek_bilgi != ""

	for c in _kart_secenek_izgara.get_children():
		_kart_secenek_izgara.remove_child(c)
		c.queue_free()
	_kart_secenek_izgara.columns = clampi(secenekler.size(), 1, 3)
	_kart_secenek_izgara.visible = not secenekler.is_empty()
	for s in secenekler:
		_kart_secenek_izgara.add_child(_kart_secenek_butonu(s))
	karti_kapat_butonu.visible = secenekler.is_empty()
	_kart_butonlarini_yenile()

func _kart_secenek_butonu(s: Dictionary) -> Button:
	var b = Button.new()
	b.text = str(s["yazi"])
	b.custom_minimum_size = Vector2(178, 64)
	b.add_theme_font_size_override("font_size", 20)
	b.add_theme_color_override("font_color", Color(0.13, 0.1, 0.08))
	b.add_theme_color_override("font_hover_color", Color(0.05, 0.03, 0.02))
	b.add_theme_color_override("font_pressed_color", Color(0.05, 0.03, 0.02))
	b.add_theme_color_override("font_focus_color", Color(0.13, 0.1, 0.08))
	b.add_theme_color_override("font_disabled_color", Color(0.45, 0.42, 0.38))
	var renk: Color = s["renk"]
	b.add_theme_stylebox_override("normal", _stil_kutusu(Color(1, 1, 1, 0.55), 10, renk, 3))
	b.add_theme_stylebox_override("hover", _stil_kutusu(Color(1, 1, 1, 0.85), 10, renk, 3))
	b.add_theme_stylebox_override("pressed", _stil_kutusu(Color(1, 1, 1, 0.35), 10, renk, 3))
	b.add_theme_stylebox_override("disabled", _stil_kutusu(Color(1, 1, 1, 0.25), 10, Color(renk, 0.35), 2))
	b.set_meta("aktif", bool(s["aktif"]))
	var deger: String = str(s["deger"])
	b.pressed.connect(func(): _on_kart_secenek_basildi(deger))
	return b

# Butonlar ve "... seçiyor" yazısı, kararı kimin verdiğine göre
func _kart_butonlarini_yenile():
	if _kart_secenek_izgara == null:
		return
	var bende = _kontrol_bende()
	for b in _kart_secenek_izgara.get_children():
		if b is Button:
			b.disabled = not (bende and bool(b.get_meta("aktif", false)))
	karti_kapat_butonu.disabled = not bende
	var isim = oyuncular[aktif_oyuncu_indeksi]["isim"]
	if _bekleyen_secimli:
		_kart_durum.text = "Seçimini yap" if bende else isim + " seçiyor..."
	elif not bende:
		_kart_durum.text = isim + " kartı okuyor..."
	else:
		_kart_durum.text = ""
	_kart_durum.visible = _kart_durum.text != ""

# Kartın altındaki, o anki duruma göre hesaplanan bilgi satırı
func _kart_ek_bilgisi(kart: String, secenekler: Array) -> String:
	var ben = aktif_oyuncu_indeksi
	var o = oyuncular[ben]
	var tur = str(KART_BILGILERI[kart]["tur"])
	var uyari = "[color=#b3261e][b]DİKKAT: Bakiyen eksiye düşecek![/b][/color]"
	match kart:
		"ucak_bileti":
			if secenekler.is_empty():
				return "Boş şehir kalmadı: bilet iade edildi, [b]100 TL[/b] alırsın."
		"komsu_pazarligi":
			if secenekler.is_empty():
				return "Satın alınabilecek şehir yok."
			for s in secenekler:
				if str(s["deger"]) != "-" and s["aktif"]:
					return ""
			return "Paran hiçbir şehre yetmiyor."
		"hayirsever":
			var notlar = []
			if o["kartlar"].size() >= EL_SINIRI:
				notlar.append("Elin dolu olduğu için kalkan verilemez.")
			if o["para"] < 100:
				notlar.append(uyari)
			if not secenekler.is_empty():
				return "\n".join(PackedStringArray(notlar))
		"cay_ocagi":
			var z = _en_zengin()
			return "En zengin: " + _renkli_isim(z) + "  (" + str(oyuncular[z]["para"]) + " TL)"
		"bayram_harcligi":
			var f = _en_fakir()
			return "En fakir: " + _renkli_isim(f) + "  (" + str(oyuncular[f]["para"]) + " TL)"
		"yazi_tura":
			return "Rakibin: " + _renkli_isim(_sonraki_aktif(ben))
		"dugun":
			return "Parası yetmeyen elindeki kadarını verir."
		"dedikodu":
			return _servet_siralamasi()
		"trafik_cezasi":
			if o["para"] < 100:
				return uyari
		"emlak_vergisi":
			var kat = _toplam_kat(ben)
			if kat == 0:
				return "Hiç katın yok: vergi çıkmadı."
			var metin = "Senin katların: " + str(kat) + "  →  [b]" + str(kat * 25) + " TL[/b]"
			if o["para"] < kat * 25:
				metin += "\n" + uyari
			return metin
		"kentsel_donusum":
			var h = _kentsel_donusum_hedefi(ben)
			if h == "":
				return "Kat çıkabileceğin şehir yok: [b]100 TL[/b] destek alırsın."
			return "Bedava kat: [b]" + _gorunen_ad(h) + "[/b]"
		"otoyol":
			return "Maaş: [b]+" + str(tur_maasi) + " TL[/b]"
		"yanlis_adres":
			if o["kartlar"].has("torpil"):
				return "[color=#1e6b2a][b]Torpilin var: hapse girmeyeceksin![/b][/color]"
		"piyango":
			if o["para"] < 30:
				return "Kaybedersen bakiyen eksiye düşebilir."
	if tur == "oyuncu" and secenekler.is_empty():
		return "Seçilebilecek oyuncu yok: kartın etkisi olmadı."
	if tur == "el":
		if o["kartlar"].size() >= EL_SINIRI:
			return "[color=#b3261e]Elin dolu (en fazla " + str(EL_SINIRI) + " kart): bu kart desteye geri döner.[/color]"
		return "Kart, bakiye panelinde adının altında görünür."
	return ""

# Kart desteden kalkıp ortaya uçar, ardından kart yüzü belirir
func _kart_animasyonu():
	_kart_kutu.modulate.a = 0.0
	var ucan = _kart_arkasi_olustur()
	ucan.position = DESTE_KONUMU
	$Arayuz.add_child(ucan)
	var hedef = Vector2(960, 540) - DESTE_KART_BOYU / 2.0
	var tw = create_tween().set_parallel(true)
	tw.tween_property(ucan, "position", hedef, 0.45).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(ucan, "scale", Vector2(2.6, 2.6), 0.45).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(ucan, "rotation_degrees", -6.0, 0.45)
	tw.chain().tween_property(ucan, "modulate:a", 0.0, 0.18)
	tw.chain().tween_callback(ucan.queue_free)
	await get_tree().create_timer(0.38).timeout
	if not is_inside_tree() or not sans_karti_paneli.visible:
		return
	_kart_kutu.pivot_offset = _kart_kutu.size / 2.0
	_kart_kutu.scale = Vector2(0.85, 0.85)
	var tw2 = create_tween().set_parallel(true)
	tw2.tween_property(_kart_kutu, "modulate:a", 1.0, 0.22)
	tw2.tween_property(_kart_kutu, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

# --- TAHTADAKİ DESTE (zarların üstünde) ---
func _kart_arkasi_olustur() -> Control:
	var kart = Panel.new()
	kart.size = DESTE_KART_BOYU
	kart.pivot_offset = DESTE_KART_BOYU / 2.0
	kart.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var stil = StyleBoxFlat.new()
	stil.bg_color = Color(0.89, 0.87, 0.81)
	stil.set_corner_radius_all(12)
	stil.border_color = Color(0.29, 0.25, 0.21)
	stil.set_border_width_all(3)
	stil.shadow_color = Color(0, 0, 0, 0.35)
	stil.shadow_size = 6
	stil.shadow_offset = Vector2(3, 4)
	kart.add_theme_stylebox_override("panel", stil)

	var ic = Panel.new()
	ic.position = Vector2(6, 6)
	ic.size = DESTE_KART_BOYU - Vector2(12, 12)
	ic.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var ic_stil = StyleBoxFlat.new()
	ic_stil.bg_color = Color(0, 0, 0, 0)
	ic_stil.set_corner_radius_all(8)
	ic_stil.border_color = Color(0.6, 0.56, 0.49)
	ic_stil.set_border_width_all(1)
	ic.add_theme_stylebox_override("panel", ic_stil)
	kart.add_child(ic)

	var baslik = Label.new()
	baslik.text = "ŞANS"
	baslik.position = Vector2(0, 9)
	baslik.size = Vector2(DESTE_KART_BOYU.x, 26)
	baslik.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	baslik.mouse_filter = Control.MOUSE_FILTER_IGNORE
	baslik.add_theme_font_override("font", _serif_yazi_tipi())
	baslik.add_theme_font_size_override("font_size", 20)
	baslik.add_theme_color_override("font_color", Color(0.18, 0.15, 0.12))
	kart.add_child(baslik)

	var kutu = Panel.new()
	kutu.position = Vector2(26, 40)
	kutu.size = Vector2(60, 90)
	kutu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var kutu_stil = StyleBoxFlat.new()
	kutu_stil.bg_color = Color(0.94, 0.92, 0.88)
	kutu_stil.set_corner_radius_all(7)
	kutu_stil.border_color = Color(0.16, 0.14, 0.12)
	kutu_stil.set_border_width_all(3)
	kutu.add_theme_stylebox_override("panel", kutu_stil)
	kart.add_child(kutu)

	var soru = Label.new()
	soru.text = "?"
	soru.size = Vector2(60, 90)
	soru.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	soru.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	soru.mouse_filter = Control.MOUSE_FILTER_IGNORE
	soru.add_theme_font_override("font", _serif_yazi_tipi())
	soru.add_theme_font_size_override("font_size", 60)
	soru.add_theme_color_override("font_color", Color(0.27, 0.15, 0.4))
	kutu.add_child(soru)
	return kart

func _desteyi_kur():
	var deste = Node2D.new()
	deste.name = "SansDestesi"
	add_child(deste)
	move_child(deste, 1)   # Tahta görselinin hemen üstü; arabalar ve arayüz bunun üstünde kalır

	_deste_bos = Panel.new()
	_deste_bos.position = DESTE_KONUMU
	_deste_bos.size = DESTE_KART_BOYU
	_deste_bos.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var bos_stil = StyleBoxFlat.new()
	bos_stil.bg_color = Color(0, 0, 0, 0.18)
	bos_stil.set_corner_radius_all(12)
	bos_stil.border_color = Color(1, 1, 1, 0.45)
	bos_stil.set_border_width_all(2)
	_deste_bos.add_theme_stylebox_override("panel", bos_stil)
	deste.add_child(_deste_bos)

	# Alttaki kartlar hafif kaydırılıp döndürülür, deste kalınlığı belli olsun
	var acilar = [0.0, -3.0, 2.5, -2.0, 3.5]
	_deste_kartlari.resize(5)
	for k in range(4, -1, -1):
		var kart = _kart_arkasi_olustur()
		kart.position = DESTE_KONUMU + Vector2(-2.5 * k, 3.0 * k)
		kart.rotation_degrees = acilar[k]
		deste.add_child(kart)
		_deste_kartlari[k] = kart

	# Sağ üstte kalan kart sayısı
	var rozet = Panel.new()
	rozet.size = Vector2(44, 44)
	rozet.position = DESTE_KONUMU + Vector2(DESTE_KART_BOYU.x - 26, -18)
	rozet.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var rozet_stil = StyleBoxFlat.new()
	rozet_stil.bg_color = Color(0.85, 0.64, 0.17)
	rozet_stil.set_corner_radius_all(22)
	rozet_stil.border_color = Color(0.24, 0.16, 0.04)
	rozet_stil.set_border_width_all(3)
	rozet_stil.shadow_color = Color(0, 0, 0, 0.35)
	rozet_stil.shadow_size = 4
	rozet.add_theme_stylebox_override("panel", rozet_stil)
	deste.add_child(rozet)
	_deste_sayac = Label.new()
	_deste_sayac.size = Vector2(44, 44)
	_deste_sayac.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_deste_sayac.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_deste_sayac.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_deste_sayac.add_theme_font_size_override("font_size", 20)
	_deste_sayac.add_theme_color_override("font_color", Color(0.12, 0.08, 0.02))
	rozet.add_child(_deste_sayac)

	# Altta "ŞANS DESTESİ" yazısı
	var yazi_kutu = Panel.new()
	yazi_kutu.size = Vector2(184, 32)
	yazi_kutu.position = Vector2(DESTE_KONUMU.x + DESTE_KART_BOYU.x / 2.0 - 92, DESTE_KONUMU.y + DESTE_KART_BOYU.y + 20)
	yazi_kutu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var yazi_stil = StyleBoxFlat.new()
	yazi_stil.bg_color = Color(0.04, 0.05, 0.08, 0.86)
	yazi_stil.set_corner_radius_all(16)
	yazi_stil.border_color = Color(0.85, 0.64, 0.17)
	yazi_stil.set_border_width_all(2)
	yazi_kutu.add_theme_stylebox_override("panel", yazi_stil)
	deste.add_child(yazi_kutu)
	var yazi = Label.new()
	yazi.text = "ŞANS DESTESİ"
	yazi.size = Vector2(184, 32)
	yazi.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	yazi.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	yazi.mouse_filter = Control.MOUSE_FILTER_IGNORE
	yazi.add_theme_font_size_override("font_size", 17)
	yazi.add_theme_color_override("font_color", Color.WHITE)
	yazi_kutu.add_child(yazi)
	_desteyi_ciz()

# Deste kalınlığı ve sayaç, kalan kart sayısına göre
func _desteyi_ciz():
	if _deste_sayac == null:
		return
	var katman = clampi(_deste_kalan, 0, 5)
	for k in range(5):
		_deste_kartlari[k].visible = k < katman
	_deste_bos.visible = _deste_kalan <= 0
	_deste_sayac.text = str(_deste_kalan)

func _on_tamam_basildi():
	if not bildirim_paneli.visible or not _kontrol_bende(): return
	_oyuncu_komutu("tamam")

func _tamam():
	bildirim_paneli.hide()

	if bekleyen_kira["aktif"]:
		var odeyen = oyuncular[bekleyen_kira["odeyen"]]
		var alan = oyuncular[bekleyen_kira["alan"]]

		odeyen["para"] -= bekleyen_kira["miktar"]
		alan["para"] += bekleyen_kira["miktar"]
		odeyen["ist"]["kira_odedi"] += bekleyen_kira["miktar"]
		alan["ist"]["kira_aldi"] += bekleyen_kira["miktar"]
		_ucan_para(bekleyen_kira["odeyen"], bekleyen_kira["alan"], bekleyen_kira["miktar"])
		_bot_tepkisi(bekleyen_kira["alan"], 0, 0.8)
		if bekleyen_kira["miktar"] >= 200:
			_bot_tepkisi(bekleyen_kira["odeyen"], [2, 6][randi() % 2], 0.8)
		_para_sesini_tek_cal()
		if bekleyen_kira["alan"] == _yerel() and not alan["yapay_zeka"]:
			_titret(40)
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
		o_oyuncu["kartlar"].clear()
		_borca_dusenler.erase(aktif_oyuncu_indeksi)
		if aktif_oyuncu_indeksi == _yerel() and not o_oyuncu["yapay_zeka"]:
			_titret(500)
		_ekrani_sars()
		_rastgele_bot_tepkisi(aktif_oyuncu_indeksi, 7, 1.5)

		var kalan = []
		for p in oyuncular:
			if p["aktif_mi"]:
				kalan.append(p)

		if kalan.size() == 1:
			var kazanan_renk_hex = kalan[0]["renk"].to_html(false)
			oyun_bitti_animasyonunu_baslat(kalan[0]["isim"], kazanan_renk_hex)
		else:
			bildirim_yazisi.text = "[center]\n\n\n[font_size=20][b][color=#aa0000]" + o_oyuncu["isim"] + " İFLAS ETTİ![/color][/b][/font_size]\n\n(Oyun 5 saniye içinde devam edecek...)[/center]"
			tamam_butonu.hide()
			bildirim_paneli.show()

			# Süreyi sunucu tutar ki herkes aynı anda devam etsin
			if _yetkili():
				_gecikmeli(5.0, "sonraki_tur")
	else:
		_borca_dusenler[aktif_oyuncu_indeksi] = true
		if o_oyuncu["yapay_zeka"]:
			if _yetkili():
				ai_mulk_sat(satilabilir_mulkler)
		else:
			satis_panelini_doldur(satilabilir_mulkler)
			sat_butonu.disabled = not _kontrol_bende()
			ihaleye_cikar_butonu.disabled = not _kontrol_bende()
			satis_paneli.show()

func _iflas_sonrasi_devam():
	bildirim_paneli.hide()
	tamam_butonu.show()
	sirayi_sonraki_oyuncuya_gecir()

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

			liste.append({"sehir_adi": sehir, "satis_bedeli": floori(harcanan / 2.0)})
	return liste

func _satis_bedeli(sehir_adi: String) -> int:
	for m in satilabilir_mulkleri_getir(aktif_oyuncu_indeksi):
		if m["sehir_adi"] == sehir_adi:
			return m["satis_bedeli"]
	return 0

func satis_panelini_doldur(satilabilir_liste):
	mulk_listesi.clear()
	for m in satilabilir_liste:
		mulk_listesi.add_item(m["sehir_adi"] + " (Banka: " + str(m["satis_bedeli"]) + " TL)")
		mulk_listesi.set_item_metadata(mulk_listesi.get_item_count() - 1, m["sehir_adi"])

func _on_sat_butonu_basildi():
	if not satis_paneli.visible or not _kontrol_bende(): return
	var secili_index = mulk_listesi.selected
	if secili_index == -1: return
	_oyuncu_komutu("sat", [str(mulk_listesi.get_item_metadata(secili_index))])

func _sat(sehir_adi: String):
	if not mülkiyet_durumu.has(sehir_adi): return
	mulku_bankaya_sat(sehir_adi, _satis_bedeli(sehir_adi))

func ai_mulk_sat(satilabilir_liste):
	await get_tree().create_timer(1.0).timeout
	if not is_inside_tree(): return
	_komut("ihaleye_cikar", [satilabilir_liste[0]["sehir_adi"]])

func mulku_bankaya_sat(sehir_adi, satis_bedeli):
	oyuncular[aktif_oyuncu_indeksi]["para"] += satis_bedeli
	_para_sesini_tek_cal()
	var konum = harita_sirasi.find(sehir_adi)

	for i in range(5):
		var ev_node = path_2d.get_node_or_null("Ev_" + str(konum) + "_" + str(i))
		if ev_node:
			path_2d.remove_child(ev_node)
			ev_node.queue_free()

	mülkiyet_durumu.erase(sehir_adi)
	haritadaki_kirayi_guncelle(sehir_adi, 0)
	arayuzu_guncelle()

	if oyuncular[aktif_oyuncu_indeksi]["para"] < 0:
		borc_kontrolu()
	else:
		satis_paneli.hide()
		sirayi_sonraki_oyuncuya_gecir()

func _on_ihaleye_cikar_basildi():
	if not satis_paneli.visible or not _kontrol_bende(): return
	var secili_index = mulk_listesi.selected
	if secili_index == -1: return
	_oyuncu_komutu("ihaleye_cikar", [str(mulk_listesi.get_item_metadata(secili_index))])

func _ihaleye_cikar(sehir: String):
	if not mülkiyet_durumu.has(sehir): return
	_ihale_kurulumu_yap(sehir, _satis_bedeli(sehir))

func _ihale_butonlarini_ayarla():
	var ben = _yerel()
	var katilabilir = ben >= 0 and ben != ihale_verileri["satici"] and oyuncular[ben]["aktif_mi"] and not oyuncular[ben]["yapay_zeka"] and not ihale_verileri["cekilenler"].has(ben)
	teklif_butonu.disabled = not katilabilir
	pas_butonu.disabled = not katilabilir
	teklif_butonu.text = "Teklif Ver\n" + str(_siradaki_teklif()) + " TL"

# Teklif artışı şehrin fiyatına göre: Kars'ta 10 TL, İstanbul'da 50 TL
func _ihale_artisi(sehir: String) -> int:
	return maxi(10, int(round(sehirler[sehir]["fiyat"] * 0.1 / 10.0)) * 10)

# İlk teklif başlangıç fiyatıdır, sonrakiler birer artış üstüne çıkar
func _siradaki_teklif() -> int:
	if ihale_verileri["kazanan_indeks"] == -1:
		return ihale_verileri["guncel_teklif"]
	return ihale_verileri["guncel_teklif"] + ihale_verileri["artis"]

# satici = -1: pas geçilen şehir (banka ihalesi); satici >= 0: borcunu kapatmak için satılan şehir
func _ihale_kurulumu_yap(sehir_adi, baslangic_fiyati, satici: int = -2):
	if satici == -2:
		satici = aktif_oyuncu_indeksi
	satis_paneli.hide()
	tapu_karti.hide()
	ihale_verileri["sehir"] = sehir_adi
	ihale_verileri["guncel_teklif"] = baslangic_fiyati
	ihale_verileri["kazanan_indeks"] = -1
	ihale_verileri["satici"] = satici
	ihale_verileri["artis"] = _ihale_artisi(sehir_adi)
	ihale_verileri["cekilenler"].clear()

	if satici == -1:
		ihale_baslik.text = "BANKA İHALESİ!"
		ihale_mulk_bilgisi.text = "[center]Kimse almadı:\n[font_size=28][b][color=gold]" + sehir_adi.to_upper() + "[/color][/b][/font_size] (Liste fiyatı: " + str(sehirler[sehir_adi]["fiyat"]) + " TL)[/center]"
	else:
		ihale_baslik.text = "AÇIK ARTIRMA BAŞLADI!"
		ihale_mulk_bilgisi.text = "[center]Satılan Mülk:\n[font_size=28][b][color=gold]" + sehir_adi.to_upper() + "[/color][/b][/font_size] (Başlangıç: [color=green]" + str(baslangic_fiyati) + " TL[/color])[/center]"
	ihale_durum_yazisi.text = "[center][font_size=23][b][color=cyan]İlk teklif: " + str(baslangic_fiyati) + " TL[/color][/b][/font_size]\nTeklifler bekleniyor...[/center]"

	ihale_suresi = 8
	sure_yazisi.text = "Kalan Süre: 8"

	teklif_butonu.show()
	pas_butonu.show()
	_ihale_butonlarini_ayarla()
	if not teklif_butonu.disabled:
		_titret(60)

	ihale_paneli.visible = true
	ihale_paneli.scale = Vector2(0, 0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(ihale_paneli, "scale", Vector2(1, 1), 0.5)

	ihale_aktif = true
	# Geri sayımı sadece sunucu yürütür
	if _yetkili():
		ihale_timer.one_shot = false
		ihale_timer.start(1.0)

func _on_ihale_timer_timeout():
	if not ihale_aktif or not _yetkili(): return
	var yeni_sure = ihale_suresi - 1
	_komut("ihale_sure", [yeni_sure])

	var teklif_verildi = false
	if yeni_sure > 0:
		var adaylar = []
		var siradaki = _siradaki_teklif()
		# Banka ihalesinde fiyat hâlâ liste fiyatının altındaysa kelepirdir: botlar daha istekli olur
		var kelepir = ihale_verileri["satici"] == -1 and siradaki < sehirler[ihale_verileri["sehir"]]["fiyat"]
		for i in range(4):
			if not oyuncular[i]["yapay_zeka"] or not oyuncular[i]["aktif_mi"]:
				continue
			if i == ihale_verileri["satici"] or i == ihale_verileri["kazanan_indeks"] or ihale_verileri["cekilenler"].has(i):
				continue
			if siradaki > _bot_ihale_siniri(i):
				ihale_verileri["cekilenler"].append(i)   # bu fiyata değmez, çekilir
			elif oyuncular[i]["para"] - siradaki >= (mini(100, int(_kisilik(i)["ihale_yedek"])) if kelepir else int(_kisilik(i)["ihale_yedek"])):
				adaylar.append(i)

		if adaylar.size() > 0:
			var sans = 40
			if yeni_sure <= 3: sans = 65
			if yeni_sure == 1: sans = 90
			if kelepir: sans += 15
			if randi() % 100 < sans:
				_komut("teklif", [adaylar[randi() % adaylar.size()]])
				teklif_verildi = true

	# Süre bittiyse ya da teklif verebilecek kimse kalmadıysa beklemeden bitir
	if yeni_sure <= 0 or (not teklif_verildi and _ihalede_aday_kalmadi()):
		_komut("ihale_bitti")

# Hâlâ teklif verebilecek biri var mı? (botlar 100 TL yedek bırakır)
func _ihalede_aday_kalmadi() -> bool:
	var siradaki = _siradaki_teklif()
	for i in range(4):
		if not oyuncular[i]["aktif_mi"]:
			continue
		if i == ihale_verileri["satici"] or i == ihale_verileri["kazanan_indeks"] or ihale_verileri["cekilenler"].has(i):
			continue
		var gerekli = siradaki + (100 if oyuncular[i]["yapay_zeka"] else 0)
		if oyuncular[i]["para"] >= gerekli:
			return false
	return true

# Bot bu şehre en fazla ne öder? Grubunu tamamlıyorsa çok, rakibinkini bozuyorsa biraz daha fazla
func _bot_ihale_siniri(i: int) -> int:
	var s = ihale_verileri["sehir"]
	var f = sehirler[s]["fiyat"]
	var deger = f
	if mülkiyet_durumu.has(s):
		for x in range(mülkiyet_durumu[s]["seviye"]):
			deger += int(f * [0.5, 0.75, 1.0, 1.5][x])
	var carpan = 1.0 if ihale_verileri["satici"] == -1 else 1.3
	var grup = _grup_sehirleri(s)
	var bende = 0
	var rakipte = {}
	for g in grup:
		if g == s or not mülkiyet_durumu.has(g):
			continue
		var sahip = mülkiyet_durumu[g]["sahip"]
		if sahip == i:
			bende += 1
		else:
			rakipte[sahip] = rakipte.get(sahip, 0) + 1
	if bende == grup.size() - 1:
		carpan += 0.6
	else:
		for sahip in rakipte:
			if rakipte[sahip] == grup.size() - 1:
				carpan += 0.3
	return int(deger * carpan * float(_kisilik(i)["ihale"]))

func _ihale_sure(kalan: int):
	ihale_suresi = kalan
	if ihale_aktif:
		sure_yazisi.text = "Kalan Süre: " + str(ihale_suresi)

func _on_teklif_butonu_basildi():
	if not ihale_paneli.visible or not ihale_aktif: return
	var ben = _yerel()
	if ben < 0 or not oyuncular[ben]["aktif_mi"]: return
	if ben == ihale_verileri["kazanan_indeks"]:
		sure_yazisi.text = "EN YÜKSEK\nTEKLİF SENDE"
		return
	if oyuncular[ben]["para"] >= _siradaki_teklif():
		_oyuncu_komutu("teklif", [ben])
	else:
		sure_yazisi.text = "BAKİYE\nYETERSİZ!"

func _on_pas_butonu_basildi():
	if not ihale_paneli.visible: return
	var ben = _yerel()
	if ben < 0 or not oyuncular[ben]["aktif_mi"]: return
	_oyuncu_komutu("ihale_pas", [ben])

func _ihale_pas(indeks: int):
	if not ihale_verileri["cekilenler"].has(indeks):
		ihale_verileri["cekilenler"].append(indeks)
	if indeks == _yerel():
		teklif_butonu.disabled = true
		pas_butonu.disabled = true
		sure_yazisi.text = "İHALEDEN\nÇEKİLDİN"

func _teklifi_artir(veren_indeks):
	var onceki = ihale_verileri["kazanan_indeks"]
	ihale_verileri["guncel_teklif"] = _siradaki_teklif()
	ihale_verileri["kazanan_indeks"] = veren_indeks
	ihale_suresi = 8
	sure_yazisi.text = "Kalan Süre: 8"
	teklif_butonu.text = "Teklif Ver\n" + str(_siradaki_teklif()) + " TL"

	var hex_renk = oyuncular[veren_indeks]["renk"].to_html(false)
	ihale_durum_yazisi.text = "[center][color=#" + hex_renk + "][font_size=23][b]" + oyuncular[veren_indeks]["isim"] + "[/b][/font_size][/color] teklifi [color=green][font_size=23][b]" + str(ihale_verileri["guncel_teklif"]) + " TL[/b][/font_size][/color]'ye yükseltti!\nBaşka artıran var mı?[/center]"
	# Teklifi geçilen oyuncunun telefonu kısa titrer
	if onceki == _yerel() and onceki != veren_indeks and not oyuncular[onceki]["yapay_zeka"]:
		_titret(80)

func _ihale_sonuclandir():
	ihale_aktif = false
	ihale_timer.stop()
	teklif_butonu.hide()
	pas_butonu.hide()

	var s = ihale_verileri["sehir"]
	var k = ihale_verileri["kazanan_indeks"]
	var bedel = ihale_verileri["guncel_teklif"]
	var satici_no = ihale_verileri["satici"]
	var konum = harita_sirasi.find(s)

	if k != -1:
		var alici = oyuncular[k]
		var indirim_notu = ""
		if satici_no == -1 and alici["kartlar"].has("ihale_karti"):
			var indirimli = maxi(10, int(round(bedel * 0.8 / 10.0)) * 10)
			indirim_notu = "\n[color=#ffd34d]İhale Kartı: %20 indirim (" + str(bedel) + " → " + str(indirimli) + " TL)[/color]"
			bedel = indirimli
			alici["kartlar"].erase("ihale_karti")
		alici["para"] -= bedel
		_para_sesini_tek_cal()
		if satici_no >= 0:
			oyuncular[satici_no]["para"] += bedel
			mülkiyet_durumu[s]["sahip"] = k
			for i in range(5):
				var ev_node = path_2d.get_node_or_null("Ev_" + str(konum) + "_" + str(i))
				if ev_node: ev_node.modulate = alici["renk"]
		else:
			mülkiyet_durumu[s] = {"sahip": k, "seviye": 0}
			insaa_et_gorsel_ev(konum, alici["renk"], 0)

		var hex_renk = alici["renk"].to_html(false)
		ihale_durum_yazisi.text = "[center][font_size=21][b][color=gold]İHALE BİTTİ![/color][/b][/font_size]\n\nSATILAN KİŞİ: [color=#" + hex_renk + "]" + alici["isim"] + "[/color]\nÖDENEN TUTAR: [color=green]" + str(bedel) + " TL[/color]" + indirim_notu + "[/center]"
		if k == _yerel() and not alici["yapay_zeka"]:
			_titret(120)
		_tekel_kontrol(k, s)
	elif satici_no >= 0:
		oyuncular[satici_no]["para"] += bedel
		for i in range(5):
			var ev_node = path_2d.get_node_or_null("Ev_" + str(konum) + "_" + str(i))
			if ev_node:
				path_2d.remove_child(ev_node)
				ev_node.queue_free()
		mülkiyet_durumu.erase(s)
		ihale_durum_yazisi.text = "[center][b][color=red]İHALE BİTTİ![/color][/b]\n\nKimse teklif vermedi.\nMülk bankaya iade edildi.[/center]"
	else:
		ihale_durum_yazisi.text = "[center][b][color=red]İHALE BİTTİ![/color][/b]\n\nKimse teklif vermedi.\nŞehir bankada kaldı.[/center]"

	_tum_kiralari_guncelle()
	arayuzu_guncelle()
	# Bekleme sunucuda tutulur ki herkes aynı anda devam etsin
	if _yetkili():
		_gecikmeli(3.0 if k != -1 else 1.5, "ihale_kapat")

func _ihale_kapat():
	ihale_paneli.hide()
	var satici_no = ihale_verileri["satici"]
	if satici_no == -1:
		# Banka ihalesi bitti: pas geçen oyuncunun turu sona erer
		sirayi_sonraki_oyuncuya_gecir()
		return
	if oyuncular[satici_no]["para"] < 0:
		borc_kontrolu()
	elif satici_no == aktif_oyuncu_indeksi:
		sirayi_sonraki_oyuncuya_gecir()

# Eski çağrılar için: artık tek bir şehir değil, tüm etiketler güncellenir (tekel komşu şehirleri de etkiler)
func haritadaki_kirayi_guncelle(_sehir_adi: String, _yeni_seviye: int = 0):
	_tum_kiralari_guncelle()

# ==========================================
# RENK GRUPLARI VE TEKEL
# ==========================================
func _gruplari_hazirla():
	gruplar.clear()
	for sehir in harita_sirasi:
		if sehirler.has(sehir):
			var anahtar = sehirler[sehir]["renk"].to_html(false)
			if not gruplar.has(anahtar):
				gruplar[anahtar] = []
			gruplar[anahtar].append(sehir)

func _grup_sehirleri(sehir: String) -> Array:
	return gruplar.get(sehirler[sehir]["renk"].to_html(false), [sehir])

func _gorunen_ad(sehir: String) -> String:
	return GORUNEN_ADLAR.get(sehir, sehir)

# Oyuncu bu şehrin grubundaki tüm şehirlere sahip mi?
func _tekel_mi(sahip: int, sehir: String) -> bool:
	if sahip < 0:
		return false
	for g in _grup_sehirleri(sehir):
		if not mülkiyet_durumu.has(g) or mülkiyet_durumu[g]["sahip"] != sahip:
			return false
	return true

# Yeni bir tekel oluştuysa herkese duyur
func _tekel_kontrol(oyuncu: int, sehir: String):
	if not _tekel_mi(oyuncu, sehir):
		return
	var adlar = []
	for g in _grup_sehirleri(sehir):
		adlar.append(_gorunen_ad(g))
	_bilgi_goster("TEKEL! " + oyuncular[oyuncu]["isim"] + ": " + " · ".join(PackedStringArray(adlar)) + "  (kira ×2)", 3.5, oyuncular[oyuncu]["renk"], true)
	if oyuncu == _yerel() and not oyuncular[oyuncu]["yapay_zeka"]:
		_titret(150)

# Kira: seviye, tekel ve enflasyon dahil. seviye verilmezse şehrin mevcut seviyesi kullanılır
func _kira_hesapla(sehir: String, seviye: int = -1) -> int:
	var f = sehirler[sehir]["fiyat"]
	var sv = 0
	var tekel = false
	if mülkiyet_durumu.has(sehir):
		sv = mülkiyet_durumu[sehir]["seviye"]
		tekel = _tekel_mi(mülkiyet_durumu[sehir]["sahip"], sehir)
	if seviye >= 0:
		sv = seviye
	var k = sehirler[sehir]["baslangic_kirasi"] if sv == 0 else int(f * [0.5, 1.0, 1.5, 2.0][sv - 1])
	if tekel:
		k = k * 2 if sv == 0 else int(k * 1.5)
	return int(round(k * _kira_carpani()))

func _tum_kiralari_guncelle():
	if kira_etiketleri == null:
		return
	for sehir in sehirler.keys():
		var etiket = kira_etiketleri.get_node_or_null(sehir)
		if etiket == null:
			continue
		etiket.text = "Fiyat: " + str(sehirler[sehir]["fiyat"]) + " TL\nKira: " + str(_kira_hesapla(sehir)) + " TL"
		# Tekeldeki şehirlerin kirası altın renkte görünür
		if mülkiyet_durumu.has(sehir) and _tekel_mi(mülkiyet_durumu[sehir]["sahip"], sehir):
			etiket.add_theme_color_override("font_color", Color(1, 0.84, 0.2))
		else:
			etiket.remove_theme_color_override("font_color")

# Tahtadaki renk bantları grupları göstermediği için her şehrin etiketinin üstüne grup rengi şerit
func _grup_seritlerini_ciz():
	if kira_etiketleri == null:
		return
	for sehir in sehirler.keys():
		var etiket = kira_etiketleri.get_node_or_null(sehir)
		if etiket == null or etiket.has_node("GrupSeridi"):
			continue
		var serit = ColorRect.new()
		serit.name = "GrupSeridi"
		serit.color = sehirler[sehir]["renk"]
		serit.mouse_filter = Control.MOUSE_FILTER_IGNORE
		serit.position = Vector2(0, -7)
		serit.size = Vector2(etiket.size.x, 6)
		etiket.add_child(serit)

# ==========================================
# İNŞAAT (TEKELDEKİ ŞEHİRLERE SIRA SENDEYKEN KAT ÇIKMA)
# ==========================================
func _insa_bedeli(sehir: String) -> int:
	return int(sehirler[sehir]["fiyat"] * [0.5, 0.75, 1.0, 1.5][mülkiyet_durumu[sehir]["seviye"]])

# Dengeli inşaat: gruptaki en düşük katlı şehirlere önce kat çıkılır
func _insa_edilebilir_mi(oyuncu: int, sehir: String) -> bool:
	if not mülkiyet_durumu.has(sehir) or mülkiyet_durumu[sehir]["sahip"] != oyuncu:
		return false
	var sv = mülkiyet_durumu[sehir]["seviye"]
	if sv >= 4 or not _tekel_mi(oyuncu, sehir):
		return false
	for g in _grup_sehirleri(sehir):
		if mülkiyet_durumu[g]["seviye"] < sv:
			return false
	return true

func _insa_secenekleri(oyuncu: int) -> Array:
	var liste = []
	for sehir in harita_sirasi:
		if sehirler.has(sehir) and _insa_edilebilir_mi(oyuncu, sehir):
			liste.append(sehir)
	return liste

# "insa" komutu: tüm cihazlarda aynı şekilde çalışır
func _insa(sehir: String):
	var o = oyuncular[aktif_oyuncu_indeksi]
	if not _insa_edilebilir_mi(aktif_oyuncu_indeksi, sehir):
		return
	var bedel = _insa_bedeli(sehir)
	if o["para"] < bedel:
		return
	o["para"] -= bedel
	_para_sesini_tek_cal()
	mülkiyet_durumu[sehir]["seviye"] += 1
	var kat = mülkiyet_durumu[sehir]["seviye"]
	insaa_et_gorsel_ev(harita_sirasi.find(sehir), o["renk"], kat)
	o["ist"]["insa"] += 1
	if kat == 4:
		_plaza_kutlamasi(harita_sirasi.find(sehir))
	_tum_kiralari_guncelle()
	arayuzu_guncelle()
	var yapi = "plaza" if kat == 4 else str(kat) + ". kat"
	_bilgi_goster(o["isim"] + ": " + _gorunen_ad(sehir) + " → " + yapi + "  (kira " + str(_kira_hesapla(sehir)) + " TL)", 2.5, o["renk"])
	_insa_arayuzunu_yenile()

func _stil_kutusu(renk: Color, kose: int, kenar_rengi := Color(0, 0, 0, 0), kenar := 0) -> StyleBoxFlat:
	var s = StyleBoxFlat.new()
	s.bg_color = renk
	s.set_corner_radius_all(kose)
	if kenar > 0:
		s.border_color = kenar_rengi
		s.set_border_width_all(kenar)
	s.content_margin_left = 16
	s.content_margin_right = 16
	s.content_margin_top = 8
	s.content_margin_bottom = 8
	return s

func _insa_arayuzunu_kur():
	# Zar seçim panelinin hemen altında "İNŞAAT YAP" butonu
	_insa_butonu_kutusu = CenterContainer.new()
	_insa_butonu_kutusu.anchor_left = 0.0
	_insa_butonu_kutusu.anchor_right = 1.0
	_insa_butonu_kutusu.offset_top = 658
	_insa_butonu_kutusu.offset_bottom = 734
	_insa_butonu_kutusu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Arayuz.add_child(_insa_butonu_kutusu)
	_insa_butonu = Button.new()
	_insa_butonu.text = "İNŞAAT YAP"
	_insa_butonu.custom_minimum_size = Vector2(369, 70)
	_insa_butonu.add_theme_font_size_override("font_size", 28)
	_insa_butonu.add_theme_color_override("font_color", Color.WHITE)
	_insa_butonu.add_theme_stylebox_override("normal", _stil_kutusu(Color(0.85, 0.5, 0.08), 10))
	_insa_butonu.add_theme_stylebox_override("hover", _stil_kutusu(Color(0.95, 0.6, 0.15), 10))
	_insa_butonu.add_theme_stylebox_override("pressed", _stil_kutusu(Color(0.7, 0.4, 0.05), 10))
	_insa_butonu.pressed.connect(_on_insa_butonu_basildi)
	_insa_butonu_kutusu.add_child(_insa_butonu)
	_insa_butonu_kutusu.hide()

	# İnşaat paneli (ortada)
	_insa_paneli = CenterContainer.new()
	_insa_paneli.set_anchors_preset(Control.PRESET_FULL_RECT)
	_insa_paneli.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Arayuz.add_child(_insa_paneli)
	var kart = PanelContainer.new()
	kart.custom_minimum_size = Vector2(660, 0)
	var stil = _stil_kutusu(Color(0.07, 0.09, 0.13, 0.97), 18, Color(0.95, 0.6, 0.15), 3)
	stil.content_margin_left = 28
	stil.content_margin_right = 28
	stil.content_margin_top = 20
	stil.content_margin_bottom = 20
	kart.add_theme_stylebox_override("panel", stil)
	_insa_paneli.add_child(kart)
	var v = VBoxContainer.new()
	v.add_theme_constant_override("separation", 12)
	kart.add_child(v)
	var baslik = Label.new()
	baslik.text = "İNŞAAT"
	baslik.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	baslik.add_theme_font_size_override("font_size", 36)
	baslik.add_theme_color_override("font_color", Color(1, 0.75, 0.3))
	v.add_child(baslik)
	var aciklama = Label.new()
	aciklama.text = "Tekelindeki şehirlere kat çıkabilirsin. Katlar dengeli dikilir: gruptaki en az katlı şehirden başlanır."
	aciklama.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	aciklama.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	aciklama.add_theme_font_size_override("font_size", 20)
	aciklama.add_theme_color_override("font_color", Color(0.75, 0.78, 0.85))
	v.add_child(aciklama)
	_insa_listesi = VBoxContainer.new()
	_insa_listesi.add_theme_constant_override("separation", 8)
	v.add_child(_insa_listesi)
	var kapat = Button.new()
	kapat.text = "TAMAM"
	kapat.custom_minimum_size = Vector2(0, 64)
	kapat.add_theme_font_size_override("font_size", 26)
	kapat.add_theme_stylebox_override("normal", _stil_kutusu(Color(0.17, 0.55, 0.13), 10))
	kapat.add_theme_stylebox_override("hover", _stil_kutusu(Color(0.22, 0.65, 0.18), 10))
	kapat.add_theme_stylebox_override("pressed", _stil_kutusu(Color(0.12, 0.42, 0.1), 10))
	kapat.pressed.connect(_on_insa_kapat_basildi)
	v.add_child(kapat)
	_insa_paneli.hide()

# Butonun ve panelin görünürlüğünü / listesini güncel duruma göre ayarlar
func _insa_arayuzunu_yenile():
	if _insa_butonu_kutusu == null:
		return
	var sira_bende = _kontrol_bende() and _tur_basi and not hareket_ediyor and not oyuncular[aktif_oyuncu_indeksi]["hapiste_mi"]
	var secenekler = _insa_secenekleri(aktif_oyuncu_indeksi) if sira_bende else []
	if _insa_paneli.visible:
		if not sira_bende:
			_insa_paneli.hide()
		else:
			_insa_listesini_doldur(secenekler)
	_insa_butonu_kutusu.visible = sira_bende and zar_secim_paneli.visible and not secenekler.is_empty() and not _insa_paneli.visible

func _insa_listesini_doldur(secenekler: Array):
	for c in _insa_listesi.get_children():
		c.queue_free()
	if secenekler.is_empty():
		var bos = Label.new()
		bos.text = "Şu an kat çıkılabilecek şehir yok."
		bos.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		bos.add_theme_font_size_override("font_size", 22)
		_insa_listesi.add_child(bos)
		return
	var para = oyuncular[aktif_oyuncu_indeksi]["para"]
	for sehir in secenekler:
		var kat = mülkiyet_durumu[sehir]["seviye"] + 1
		var bedel = _insa_bedeli(sehir)
		var yapi = "Plaza" if kat == 4 else str(kat) + ". kat"
		var b = Button.new()
		b.text = _gorunen_ad(sehir) + "  →  " + yapi + "   ·   " + str(bedel) + " TL   (yeni kira " + str(_kira_hesapla(sehir, kat)) + " TL)"
		b.custom_minimum_size = Vector2(0, 58)
		b.add_theme_font_size_override("font_size", 22)
		b.add_theme_stylebox_override("normal", _stil_kutusu(Color(1, 1, 1, 0.08), 10, sehirler[sehir]["renk"], 2))
		b.add_theme_stylebox_override("hover", _stil_kutusu(Color(1, 1, 1, 0.16), 10, sehirler[sehir]["renk"], 2))
		b.add_theme_stylebox_override("pressed", _stil_kutusu(Color(1, 1, 1, 0.04), 10, sehirler[sehir]["renk"], 2))
		b.add_theme_stylebox_override("disabled", _stil_kutusu(Color(1, 1, 1, 0.03), 10, Color(1, 1, 1, 0.1), 2))
		b.disabled = para < bedel
		var hedef: String = sehir
		b.pressed.connect(func(): _oyuncu_komutu("insa", [hedef]))
		_insa_listesi.add_child(b)

func _on_insa_butonu_basildi():
	if not _kontrol_bende() or not _tur_basi:
		return
	zar_secim_paneli.hide()
	_insa_butonu_kutusu.hide()
	_insa_paneli.show()
	_insa_arayuzunu_yenile()

func _on_insa_kapat_basildi():
	_insa_paneli.hide()
	if _kontrol_bende() and _tur_basi and not hareket_ediyor:
		_zar_panelini_goster()

# ==========================================
# ENFLASYON VE TUR GÖSTERGESİ
# ==========================================
func _kira_carpani() -> float:
	return pow(1.0 + enf_oran, enf_kademe)

func _carpan_yazisi() -> String:
	return ("%.2f" % _kira_carpani()).replace(".", ",")

# Her oyuncu bir kez oynayınca çağrılır (tüm cihazlarda aynı anda)
func _tur_tamamlandi():
	tur_sayaci += 1
	if enf_aralik > 0 and tur_sayaci % enf_aralik == 0:
		enf_kademe += 1
		_tum_kiralari_guncelle()
		_bilgi_goster("ENFLASYON! Tüm kiralar %" + str(int(round(enf_oran * 100))) + " arttı  (kira ×" + _carpan_yazisi() + ")", 4.0, Color(1, 0.4, 0.35), true)
		_titret(150)
	_gostergeyi_guncelle()

func _gostergeyi_kur():
	var kutu = PanelContainer.new()
	kutu.position = Vector2(257, 472 + SOL_PANEL_KAYMA)
	kutu.custom_minimum_size = Vector2(298, 0)
	kutu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	kutu.add_theme_stylebox_override("panel", _stil_kutusu(Color(0.05, 0.07, 0.1, 0.82), 10))
	$Arayuz.add_child(kutu)
	_gosterge = Label.new()
	_gosterge.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_gosterge.add_theme_font_size_override("font_size", 19)
	_gosterge.add_theme_color_override("font_color", Color(0.92, 0.92, 0.95))
	kutu.add_child(_gosterge)

func _gostergeyi_guncelle():
	if _gosterge == null:
		return
	var metin = "TUR " + str(tur_sayaci + 1)
	if enf_aralik > 0:
		var kalan = enf_aralik - (tur_sayaci % enf_aralik)
		metin += "   ·   KİRA ×" + _carpan_yazisi() + "\nEnflasyona " + str(kalan) + " tur"
		_gosterge.add_theme_color_override("font_color", Color(1, 0.55, 0.5) if kalan == 1 else Color(0.92, 0.92, 0.95))
	_gosterge.text = metin

# ==========================================
# TİTREŞİM (sadece telefonda)
# ==========================================
func _titret(ms: int):
	if OS.has_feature("mobile"):
		Input.vibrate_handheld(ms)

func _on_kefalet_basildi():
	if not hapishane_paneli.visible or not _kontrol_bende(): return
	_oyuncu_komutu("kefalet")

func _kefalet():
	var o_oyuncu = oyuncular[aktif_oyuncu_indeksi]
	if o_oyuncu["para"] >= 300:
		o_oyuncu["para"] -= 300
		_para_sesini_tek_cal()
		o_oyuncu["hapiste_mi"] = false
		o_oyuncu["hapis_turu"] = 0
		arayuzu_guncelle()
		hapishane_paneli.hide()

		if o_oyuncu["yapay_zeka"]:
			if _yetkili():
				ai_hamle_yap()
		elif _kontrol_bende():
			_zar_panelini_goster()
	else:
		hapis_yazisi.text = "YETERSİZ BAKİYE!\n\n300 TL kefalet ödeyecek paran yok!"
		kefalet_butonu.hide()

func _on_yat_basildi():
	if not hapishane_paneli.visible or not _kontrol_bende(): return
	_oyuncu_komutu("yat")

func _yat():
	oyuncular[aktif_oyuncu_indeksi]["hapis_turu"] = 2
	hapishane_paneli.hide()
	bildirim_yazisi.text = "[center]\n\n\n[font_size=20][b][color=#ff3333]CEZANI ÇEKİYORSUN![/color][/b][/font_size]\n\nBu turu hapiste yatarak geçiriyorsun.[/center]"
	tamam_butonu.disabled = not _kontrol_bende()
	bildirim_paneli.show()

	if oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"] and _yetkili():
		_gecikmeli(2.0, "tamam")

func tapu_kartini_goster(sehir_anahtari: String):
	var f = sehirler[sehir_anahtari]["fiyat"]
	sehir_adi_etiketi.text = _gorunen_ad(sehir_anahtari).replace("i", "İ").to_upper()
	renk_bandi.color = sehirler[sehir_anahtari]["renk"]

	# Gruptan kaç şehir bu oyuncuda? (tapu kartındaki boş satıra yazılır)
	var grup = _grup_sehirleri(sehir_anahtari)
	var bende = 0
	for g in grup:
		if mülkiyet_durumu.has(g) and mülkiyet_durumu[g]["sahip"] == aktif_oyuncu_indeksi:
			bende += 1
	var grup_satiri = "Tekel olursa kira ×2"
	if bende > 0:
		grup_satiri = "Grup: %d/%d sende" % [bende, grup.size()]
	var c = _kira_carpani()
	detay_yazisi.text = "Satın Alma Bedeli: %d TL\n%s\nBaşlangıç Kirası: %d TL\n1. Seviye Kira: %d TL\n2. Seviye Kira: %d TL\n3. Seviye Kira: %d TL\n4. Seviye Kira: %d TL" % [f, grup_satiri, int(round(sehirler[sehir_anahtari]["baslangic_kirasi"] * c)), int(round(int(f * 0.50) * c)), int(round(int(f * 1.00) * c)), int(round(int(f * 1.50) * c)), int(round(int(f * 2.00) * c))]

	_tapu_tablosunu_doldur(sehir_anahtari, grup_satiri, c)
	karar_timer.start(15)

	satin_al_butonu.disabled = not _kontrol_bende()
	pas_gec_butonu.disabled = not _kontrol_bende()
	tapu_karti.show()

	if oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"] and _yetkili():
		_bot_tapu_karari(sehir_anahtari)

func _on_satin_al_basildi():
	if not tapu_karti.visible or not _kontrol_bende(): return
	var o = oyuncular[aktif_oyuncu_indeksi]
	_oyuncu_komutu("satin_al", [harita_sirasi[o["konum"]]])

func _satin_al(dy: String):
	if not sehirler.has(dy): return
	var o = oyuncular[aktif_oyuncu_indeksi]
	var f = sehirler[dy]["fiyat"]

	if o["para"] >= f:
		o["para"] -= f
		_para_sesini_tek_cal()
		mülkiyet_durumu[dy] = {"sahip": aktif_oyuncu_indeksi, "seviye": 0}
		arayuzu_guncelle()
		insaa_et_gorsel_ev(harita_sirasi.find(dy), o["renk"], 0)
		_tum_kiralari_guncelle()
		_tekel_kontrol(aktif_oyuncu_indeksi, dy)
		tapu_karti.hide()
		karar_timer.stop()
		sirayi_sonraki_oyuncuya_gecir()

func _on_evet_basildi():
	if not yukseltme_paneli.visible or not _kontrol_bende(): return
	_oyuncu_komutu("evet")

func _yukselt():
	var o = oyuncular[aktif_oyuncu_indeksi]
	var dy = harita_sirasi[o["konum"]]
	if not mülkiyet_durumu.has(dy):
		yukseltme_paneli.hide()
		sirayi_sonraki_oyuncuya_gecir()
		return
	var m_s = mülkiyet_durumu[dy]["seviye"]
	var bedel = int(sehirler[dy]["fiyat"] * [0.5, 0.75, 1.0, 1.5][m_s])

	if o["para"] >= bedel:
		o["para"] -= bedel
		_para_sesini_tek_cal()
		mülkiyet_durumu[dy]["seviye"] += 1
		haritadaki_kirayi_guncelle(dy, mülkiyet_durumu[dy]["seviye"])
		o["ist"]["insa"] += 1
		if mülkiyet_durumu[dy]["seviye"] == 4:
			_plaza_kutlamasi(o["konum"])
		arayuzu_guncelle()
		insaa_et_gorsel_ev(o["konum"], o["renk"], mülkiyet_durumu[dy]["seviye"])
		yukseltme_paneli.hide()
		sirayi_sonraki_oyuncuya_gecir()
	else:
		yukseltme_paneli.hide()
		sirayi_sonraki_oyuncuya_gecir()

func _on_hayir_basildi():
	if not yukseltme_paneli.visible or not _kontrol_bende(): return
	_oyuncu_komutu("hayir")

func _yukseltme_iptal():
	yukseltme_paneli.hide()
	sirayi_sonraki_oyuncuya_gecir()

func _on_pas_gec_basildi():
	if not tapu_karti.visible or not _kontrol_bende(): return
	_oyuncu_komutu("pas_gec")

func _pas_gec():
	tapu_karti.hide()
	karar_timer.stop()
	var sehir = harita_sirasi[oyuncular[aktif_oyuncu_indeksi]["konum"]]
	if sehirler.has(sehir) and not mülkiyet_durumu.has(sehir):
		_ihale_kurulumu_yap(sehir, _banka_ihale_baslangici(sehir), -1)
	else:
		sirayi_sonraki_oyuncuya_gecir()

# Banka ihalesinin taban fiyatı: liste fiyatının %70'i (10'a yuvarlanır).
# Pas diyen oyuncu da ihaleye girebilir ama arsayı yarı fiyata kapatamaz.
const BANKA_IHALE_TABAN_ORANI := 0.7

func _banka_ihale_baslangici(sehir: String) -> int:
	return maxi(10, floori(sehirler[sehir]["fiyat"] * BANKA_IHALE_TABAN_ORANI / 10.0) * 10)

func _on_sure_bitti():
	# 15 saniyelik karar süresini sunucu bitirir
	if not tapu_karti.visible or not _yetkili(): return
	_komut("pas_gec")

func insaa_et_gorsel_ev(indeks: int, renk: Color, ev_sirasi: int):
	if ev_sirasi == 4:
		for i in range(4):
			var eski_ev = path_2d.get_node_or_null("Ev_" + str(indeks) + "_" + str(i))
			if eski_ev:
				path_2d.remove_child(eski_ev)
				eski_ev.queue_free()

	var ev = Sprite2D.new()

	if ev_sirasi == 4:
		ev.texture = plaza_ikonu
		ev.scale = Vector2(0.06, 0.06)
	else:
		ev.texture = ev_ikonu
		ev.scale = Vector2(0.04, 0.04)

	ev.modulate = renk
	ev.name = "Ev_" + str(indeks) + "_" + str(ev_sirasi)

	var kordinat = path_2d.curve.get_point_position(clampi(indeks, 0, path_2d.curve.get_point_count() - 1))

	if ev_sirasi == 4:
		ev.position = kordinat + Vector2(0, -7)
	else:
		ev.position = kordinat + Vector2(-30 + (ev_sirasi * 20), -20)

	path_2d.add_child(ev)

func piyonlarin_konumlarini_duzenle():
	for kare in range(toplam_kare_sayisi):
		var bu_karedeki_oyuncular = []

		for i in range(Global.oyuncu_sayisi):
			if oyuncular[i]["aktif_mi"] and oyuncular[i]["konum"] == kare:
				bu_karedeki_oyuncular.append(i)

		var kisi_sayisi = bu_karedeki_oyuncular.size()

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

				if kisi_sayisi == 2:
					ofset = [Vector2(-20, 0), Vector2(20, 0)][i]
				elif kisi_sayisi == 3:
					ofset = [Vector2(-20, -15), Vector2(20, -15), Vector2(0, 15)][i]
				elif kisi_sayisi == 4:
					ofset = [Vector2(-20, -20), Vector2(20, -20), Vector2(-20, 20), Vector2(20, 20)][i]

				var tween = create_tween()
				tween.tween_property(araba_sprite, "position", ofset, 0.3).set_trans(Tween.TRANS_SINE)

func zar_animasyonu_oynat():
	if zar_sesi_player:
		zar_sesi_player.play()
		
	zar_gorseli.rotation_degrees = 0
	if ekstra_zar_gorseli: ekstra_zar_gorseli.rotation_degrees = 0
		
	var yukari_tween = create_tween().set_parallel(true)
	yukari_tween.tween_property(zar_gorseli, "scale", Vector2(0.28, 0.28), 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	yukari_tween.tween_property(zar_gorseli, "rotation_degrees", 360.0, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	if ekstra_zar_gorseli and ekstra_zar_gorseli.visible:
		yukari_tween.tween_property(ekstra_zar_gorseli, "scale", Vector2(0.28, 0.28), 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		yukari_tween.tween_property(ekstra_zar_gorseli, "rotation_degrees", -360.0, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(0.3).timeout
	
	var asagi_tween = create_tween().set_parallel(true)
	asagi_tween.tween_property(zar_gorseli, "scale", Vector2(0.25, 0.25), 0.2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	if ekstra_zar_gorseli and ekstra_zar_gorseli.visible:
		asagi_tween.tween_property(ekstra_zar_gorseli, "scale", Vector2(0.25, 0.25), 0.2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		
	await get_tree().create_timer(0.3).timeout
	
func oyun_bitti_animasyonunu_baslat(kazanan_isim: String, renk_hex: String):
	var panel = $Arayuz/OyunBittiPaneli
	var yazi = $Arayuz/OyunBittiPaneli/KazananYazisi
	
	panel.visible = true
	panel.scale = Vector2(0, 0)
	yazi.text = "\n[center][font_size=30][b][color=gold]OYUN BİTTİ[/color][/b][/font_size]\n\n[font_size=34]Kazanan: [color=#" + renk_hex + "]" + kazanan_isim + "[/color][/font_size]\n\n" + _odul_metni() + "[/center]"
	_konfeti(get_viewport_rect().size / 2.0, 160)
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK) 
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.7) 
	
func yukseltme_panelini_goster(sehir_adi: String, seviye: int, bedel: int, yeni_kira: int):
	var panel = $Arayuz/YukseltmePaneli
	var yazi = $Arayuz/YukseltmePaneli/SoruYazisi 
	
	panel.visible = true
	panel.scale = Vector2(0, 0) 
	
	yazi.text = "\n[center][font_size=23][b][color=cyan]MÜLK YÜKSELTME[/color][/b][/font_size]\n\n[color=gold]" + sehir_adi + " (Seviye " + str(seviye) + ")[/color]\nBu mülkü yükseltmek ister misin?\n\nİnşaat Bedeli: [color=red]" + str(bedel) + " TL[/color]\nYeni Kira Getirisi: [color=green]" + str(yeni_kira) + " TL[/color][/center]"
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.5)
	
func bakiye_degisim_animasyonu_oynat(oyuncu_indeksi: int, miktar: int):
	var ucan_yazi = Label.new()
	
	ucan_yazi.add_theme_font_size_override("font_size", 23)
	ucan_yazi.add_theme_constant_override("outline_size", 5)
	ucan_yazi.add_theme_color_override("font_outline_color", Color.BLACK)
	
	var oyuncu_rengi = oyuncular[oyuncu_indeksi]["renk"]
	ucan_yazi.add_theme_color_override("font_color", oyuncu_rengi)
	
	if miktar > 0:
		ucan_yazi.text = "+" + str(miktar) + " TL"
	else:
		ucan_yazi.text = str(miktar) + " TL" 
		
	$Arayuz.add_child(ucan_yazi)
	
	var baslangic_y = (oyuncu_indeksi * 55) -1
	ucan_yazi.global_position = bakiye_etiketi.global_position + Vector2(305, baslangic_y)
	
	ucan_yazi.modulate.a = 1.0
	
	var tween = create_tween()
	tween.tween_property(ucan_yazi, "modulate:a", 0.0, 1.0).set_ease(Tween.EASE_OUT)
	tween.tween_callback(ucan_yazi.queue_free)
	

# ==========================================
# YENİ EKLENEN DURAKLATMA (PAUSE) MENÜSÜ SİSTEMİ
# ==========================================
func _input(event):
	if event.is_action_pressed("ui_cancel"): 
		oyunu_duraklat_veya_devam_et()

# Ayarlar ekranı ve Ayarlar butonu her zaman Arayuz katmanının en üstünde çizilsin
func _ayarlari_en_uste_al():
	if not is_inside_tree():
		return
	var arayuz = $Arayuz
	arayuz.move_child(duraklatma_ekrani, -1)
	arayuz.move_child(ayarlar_butonu, -1)

func oyunu_duraklat_veya_devam_et():
	_ayarlari_en_uste_al()
	# Çevrimiçi oyunda oyun durdurulamaz (diğer telefonlarla senkron bozulur), sadece menü açılır
	if online:
		duraklatma_ekrani.visible = not duraklatma_ekrani.visible
		return
	var yeni_durum = not get_tree().paused
	get_tree().paused = yeni_durum
	duraklatma_ekrani.visible = yeni_durum

func _on_devam_basildi():
	oyunu_duraklat_veya_devam_et()

# Not: Eski OyunBitti fonksiyonunu burayla birleştirdik. 
# Artık oyunu yeniden başlattığında zaman/hız sıfırlanıp öyle başlayacak.
func _on_yeniden_baslat_basildi():
	if online:
		_on_ana_menu_basildi()
		return
	get_tree().paused = false
	Engine.time_scale = 1.0 
	get_tree().reload_current_scene() 

func _on_ana_menu_basildi():
	if online:
		Ag.ayril()
	get_tree().paused = false 
	Engine.time_scale = 1.0 
	get_tree().change_scene_to_file("res://ana_menu.tscn")

func _on_tam_ekran_degisti(aktif_mi: bool):
	if aktif_mi:
		# Tam ekrana geç
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		# Pencereli moda geç
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
		# Windows'un kafası karışmasın diye pencere boyutunu manuel veriyoruz (Standart 1152x648)
		DisplayServer.window_set_size(Vector2(1920, 1080))
		
		# Pencereyi ekranın tam ortasına yerleştir
		var ekran_boyutu = DisplayServer.screen_get_size()
		var pencere_boyutu = DisplayServer.window_get_size()
		DisplayServer.window_set_position(Vector2i((Vector2(ekran_boyutu) - Vector2(pencere_boyutu)) / 2.0))

func _on_hiz_degisti(deger: float):
	Engine.time_scale = deger 

func _on_muzik_degisti(deger: float):
	var muzik_bus = AudioServer.get_bus_index("Muzik")
	AudioServer.set_bus_mute(muzik_bus, deger <= -30)
	AudioServer.set_bus_volume_db(muzik_bus, deger)

func _on_efekt_degisti(deger: float):
	var efekt_bus = AudioServer.get_bus_index("Efekt")
	AudioServer.set_bus_mute(efekt_bus, deger <= -30)
	AudioServer.set_bus_volume_db(efekt_bus, deger)

func _process(delta):
	# Üstteki bilgi yazısının süresi
	if _bilgi_kutusu and _bilgi_kutusu.visible:
		_bilgi_sayaci -= delta
		# Sırada mesaj varsa mevcut olanı fazla bekletme
		if not _bilgi_kuyrugu.is_empty() and not _bilgi_oncelikli:
			_bilgi_sayaci = minf(_bilgi_sayaci, 1.2)
		if _bilgi_sayaci <= 0:
			_bilgi_kutusu.hide()
			_bilgi_oncelikli = false
			if not _bilgi_kuyrugu.is_empty():
				var m = _bilgi_kuyrugu.pop_front()
				_bilgi_goster(m[0], m[1], m[2], m[3])

	# Telefonu sallayarak zar atma (sadece mobilde, zar seçimi ekrandayken)
	if _salla_bekleme > 0.0:
		_salla_bekleme -= delta
	elif OS.has_feature("mobile") and zar_secim_paneli.visible and _kontrol_bende() and not duraklatma_ekrani.visible:
		if Input.get_accelerometer().length() > 22.0:
			_salla_bekleme = 1.5
			_titret(60)
			if _ekstra_zar_bekliyor:
				_ekstra_zar_at()
			else:
				_on_normal_zar_basildi()
	
	# 1. ŞEHİR ALMA (TAPU) KARTI SÜRESİ (15 Saniye)
	# Eğer tapu kartı ekrandaysa ve timer çalışıyorsa, kalan süreyi sayaca yaz:
	if tapu_karti.visible and not karar_timer.is_stopped():
		sayac_etiketi.text = str(int(ceil(karar_timer.time_left)))

	# 2. İHALE (AÇIK ARTIRMA) SÜRESİ GÜVENCESİ
	# İhale paneli açıksa ve saniye göstergede güncellenmiyorsa,
	# timer'ın aralıksız (one_shot = false) çalıştığından emin olmak için kodu _ready içine eklemene gerek kalmadan
	# doğrudan Timer'ın ayarını kod üzerinden garantiye alabiliriz:
	if _yetkili() and ihale_paneli.visible and ihale_timer.is_stopped() and ihale_suresi > 0 and ihale_aktif:
		ihale_timer.one_shot = false
		ihale_timer.start(1.0)


# ==========================================
# v2.3 — HIZLI TEPKİLER
# ------------------------------------------
# "tepki" komutu sıraya girmez, herkesin ekranında o oyuncunun arabasının
# üstünde bir balon olarak çıkar. Sunucu oyuncu başına sıklığı sınırlar.
# ==========================================
func _tepki_gecerli(a: Array, g: int) -> bool:
	if a.size() != 2:
		return false
	var i = int(a[0])
	var t = int(a[1])
	if i < 0 or i > 3 or t < 0 or t >= TEPKILER.size():
		return false
	if g >= 0 and i != g:
		return false
	var simdi = Time.get_ticks_msec()
	if simdi - int(_son_tepki.get(i, -100000)) < TEPKI_ARALIGI_MS:
		return false
	_son_tepki[i] = simdi
	return true

func _tepki_arayuzunu_kur():
	_tepki_butonu = Button.new()
	_tepki_butonu.text = "TEPKİ VER"
	_tepki_butonu.position = Vector2(257, 652)
	_tepki_butonu.custom_minimum_size = Vector2(298, 54)
	_tepki_butonu.focus_mode = Control.FOCUS_NONE
	_tepki_butonu.add_theme_font_size_override("font_size", 22)
	_tepki_butonu.add_theme_stylebox_override("normal", _stil_kutusu(Color(0.1, 0.14, 0.22, 0.92), 10, Color(1, 1, 1, 0.25), 2))
	_tepki_butonu.add_theme_stylebox_override("hover", _stil_kutusu(Color(0.16, 0.22, 0.34, 0.95), 10, Color(1, 1, 1, 0.4), 2))
	_tepki_butonu.add_theme_stylebox_override("pressed", _stil_kutusu(Color(0.22, 0.3, 0.45, 0.95), 10, Color(1, 1, 1, 0.5), 2))
	_tepki_butonu.pressed.connect(func(): _tepki_paneli.visible = not _tepki_paneli.visible)
	$Arayuz.add_child(_tepki_butonu)

	_tepki_paneli = PanelContainer.new()
	_tepki_paneli.position = _tepki_butonu.position + Vector2(0, 62)
	_tepki_paneli.custom_minimum_size = Vector2(298, 0)
	var stil = _stil_kutusu(Color(0.05, 0.07, 0.1, 0.94), 10, Color(1, 1, 1, 0.2), 2)
	stil.content_margin_left = 8
	stil.content_margin_right = 8
	_tepki_paneli.add_theme_stylebox_override("panel", stil)
	_tepki_paneli.hide()
	$Arayuz.add_child(_tepki_paneli)
	var izgara = GridContainer.new()
	izgara.columns = 2
	izgara.add_theme_constant_override("h_separation", 8)
	izgara.add_theme_constant_override("v_separation", 8)
	_tepki_paneli.add_child(izgara)
	for t in range(TEPKILER.size()):
		var b = Button.new()
		b.text = TEPKILER[t]
		b.custom_minimum_size = Vector2(133, 50)
		b.focus_mode = Control.FOCUS_NONE
		b.add_theme_font_size_override("font_size", 19)
		b.add_theme_stylebox_override("normal", _stil_kutusu(Color(0.95, 0.95, 0.97), 10))
		b.add_theme_stylebox_override("hover", _stil_kutusu(Color(1, 0.9, 0.55), 10))
		b.add_theme_stylebox_override("pressed", _stil_kutusu(Color(1, 0.8, 0.3), 10))
		b.add_theme_color_override("font_color", Color(0.1, 0.1, 0.12))
		b.add_theme_color_override("font_hover_color", Color(0.1, 0.1, 0.12))
		b.add_theme_color_override("font_pressed_color", Color(0.1, 0.1, 0.12))
		b.pressed.connect(_tepki_secildi.bind(t))
		izgara.add_child(b)

func _tepki_secildi(t: int):
	_tepki_paneli.hide()
	var simdi = Time.get_ticks_msec()
	if simdi - _son_yerel_tepki < TEPKI_ARALIGI_MS + 100:
		return
	_son_yerel_tepki = simdi
	_oyuncu_komutu("tepki", [_yerel(), t])

# Oyuncunun ekrandaki yeri: arabası, araba yoksa (iflas) bakiye satırı
func _oyuncu_ekran_konumu(i: int) -> Vector2:
	var p = oyuncular[i]["piyon"]
	if p.visible:
		for alt in p.get_children():
			if alt is Sprite2D:
				return alt.global_position
		return p.global_position
	return bakiye_etiketi.global_position + Vector2(150, i * 55 + 20)

func _tepki_goster(i: int, t: int):
	if i < 0 or i > 3 or t < 0 or t >= TEPKILER.size():
		return
	if _tepki_balonlari.has(i) and is_instance_valid(_tepki_balonlari[i]):
		_tepki_balonlari[i].queue_free()
	var o = oyuncular[i]
	var kutu = PanelContainer.new()
	kutu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var stil = _stil_kutusu(Color(1, 1, 1, 0.97), 14, o["renk"], 3)
	stil.content_margin_left = 14
	stil.content_margin_right = 14
	stil.content_margin_top = 6
	stil.content_margin_bottom = 6
	kutu.add_theme_stylebox_override("panel", stil)
	var l = Label.new()
	l.text = TEPKILER[t] if o["piyon"].visible else o["isim"] + ": " + TEPKILER[t]
	l.add_theme_font_size_override("font_size", 24)
	l.add_theme_color_override("font_color", Color(0.1, 0.1, 0.12))
	kutu.add_child(l)
	kutu.modulate.a = 0.0
	$Arayuz.add_child(kutu)
	_tepki_balonlari[i] = kutu
	await get_tree().process_frame
	if not is_instance_valid(kutu):
		return
	var hedef = _oyuncu_ekran_konumu(i)
	var konum = hedef + Vector2(-kutu.size.x / 2.0, -kutu.size.y - 34)
	konum.x = clampf(konum.x, 8, 1912 - kutu.size.x)
	konum.y = clampf(konum.y, 8, 1072 - kutu.size.y)
	kutu.position = konum
	kutu.pivot_offset = Vector2(kutu.size.x / 2.0, kutu.size.y)
	kutu.scale = Vector2(0.3, 0.3)
	var tw = create_tween()
	tw.set_parallel(true)
	tw.tween_property(kutu, "scale", Vector2.ONE, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property(kutu, "modulate:a", 1.0, 0.15)
	tw.chain().tween_interval(2.2)
	tw.chain().tween_property(kutu, "modulate:a", 0.0, 0.4)
	tw.chain().tween_callback(kutu.queue_free)
	if i != _yerel():
		_titret(25)

# Lobide eklenen gerçek botlar (bağlantısı kopan oyuncu değil)
func _gercek_bot_mu(i: int) -> bool:
	if not oyuncular[i]["yapay_zeka"] or not oyuncular[i]["aktif_mi"]:
		return false
	if online:
		return i < Ag.yuvalar.size() and Ag.yuvalar[i]["bot"]
	return true

# Sunucu: bot, kişiliğine göre bir olaya tepki verebilir
func _bot_tepkisi(i: int, t: int, carpan := 1.0):
	if not _yetkili() or i < 0 or i > 3 or not _gercek_bot_mu(i):
		return
	if randi() % 100 >= int(float(_kisilik(i)["tepki"]) * carpan):
		return
	await get_tree().create_timer(randf_range(0.6, 1.4)).timeout
	if not is_inside_tree():
		return
	_komut("tepki", [i, t])

# Sunucu: olaya karışmayan botlardan biri tepki verebilir
func _rastgele_bot_tepkisi(haric: int, t: int, carpan := 1.0):
	if not _yetkili():
		return
	var adaylar = []
	for i in range(4):
		if i != haric and _gercek_bot_mu(i):
			adaylar.append(i)
	if adaylar.is_empty():
		return
	_bot_tepkisi(adaylar[randi() % adaylar.size()], t, carpan)

# ==========================================
# v2.3 — BOT KİŞİLİKLERİ
# ==========================================
func _kisilik(i: int) -> Dictionary:
	return BOT_KISILIKLERI.get(str(oyuncular[i]["isim"]), VARSAYILAN_KISILIK)

# Bu şehirle grubun tamamı bu oyuncunun olur mu?
func _grubu_tamamlar_mi(i: int, sehir: String) -> bool:
	var grup = _grup_sehirleri(sehir)
	if grup.size() < 2:
		return false
	for g in grup:
		if g == sehir:
			continue
		if not mülkiyet_durumu.has(g) or mülkiyet_durumu[g]["sahip"] != i:
			return false
	return true

# ==========================================
# v2.3 — GÖRSEL EFEKTLER
# ==========================================
# Kira ödenince paralar ödeyenin arabasından alanınkine uçar
func _ucan_para(kimden: int, kime: int, miktar: int):
	if kimden < 0 or kime < 0:
		return
	var a = _oyuncu_ekran_konumu(kimden)
	var b = _oyuncu_ekran_konumu(kime)
	var adet = clampi(int(miktar / 100.0) + 3, 4, 10)
	for k in range(adet):
		var para = Panel.new()
		para.mouse_filter = Control.MOUSE_FILTER_IGNORE
		para.size = Vector2(28, 28)
		para.add_theme_stylebox_override("panel", _stil_kutusu(Color(1, 0.82, 0.2), 14, Color(0.72, 0.5, 0.05), 3))
		var yazi = Label.new()
		yazi.text = "TL"
		yazi.size = Vector2(28, 28)
		yazi.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		yazi.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		yazi.add_theme_font_size_override("font_size", 11)
		yazi.add_theme_color_override("font_color", Color(0.45, 0.3, 0.0))
		para.add_child(yazi)
		var baslangic = a + Vector2(randf_range(-12, 12), randf_range(-12, 12))
		var orta = (a + b) / 2.0 + Vector2(randf_range(-60, 60), -110 - randf_range(0, 80))
		para.position = baslangic - Vector2(14, 14)
		para.modulate.a = 0.0
		$Arayuz.add_child(para)
		var tw = create_tween()
		tw.tween_interval(k * 0.08)
		tw.tween_property(para, "modulate:a", 1.0, 0.08)
		var ucus = func(t: float):
			var u = 1.0 - t
			para.position = u * u * baslangic + 2.0 * u * t * orta + t * t * b - Vector2(14, 14)
		tw.tween_method(ucus, 0.0, 1.0, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(para, "modulate:a", 0.0, 0.12)
		tw.tween_callback(para.queue_free)

func _konfeti(konum: Vector2, adet := 90):
	var p = CPUParticles2D.new()
	p.one_shot = true
	p.amount = adet
	p.lifetime = 1.8
	p.explosiveness = 0.95
	p.direction = Vector2(0, -1)
	p.spread = 75.0
	p.initial_velocity_min = 280.0
	p.initial_velocity_max = 560.0
	p.gravity = Vector2(0, 750)
	p.damping_min = 20.0
	p.damping_max = 70.0
	p.scale_amount_min = 6.0
	p.scale_amount_max = 11.0
	p.angle_min = 0.0
	p.angle_max = 360.0
	p.angular_velocity_min = -420.0
	p.angular_velocity_max = 420.0
	var renkler = Gradient.new()
	renkler.interpolation_mode = Gradient.GRADIENT_INTERPOLATE_CONSTANT
	renkler.offsets = PackedFloat32Array([0.0, 0.17, 0.34, 0.5, 0.67, 0.84])
	renkler.colors = PackedColorArray([Color(1, 0.25, 0.3), Color(1, 0.82, 0.2), Color(0.3, 0.85, 1), Color(0.35, 0.95, 0.45), Color(0.9, 0.4, 1), Color(1, 1, 1)])
	p.color_initial_ramp = renkler
	$Arayuz.add_child(p)
	p.position = konum
	p.emitting = true
	await get_tree().create_timer(p.lifetime + 0.6).timeout
	if is_instance_valid(p):
		p.queue_free()

func _plaza_kutlamasi(kare: int):
	var nokta = path_2d.curve.get_point_position(clampi(kare, 0, path_2d.curve.get_point_count() - 1))
	_konfeti(path_2d.to_global(nokta))
	if aktif_oyuncu_indeksi == _yerel() and not oyuncular[aktif_oyuncu_indeksi]["yapay_zeka"]:
		_titret(120)
	_rastgele_bot_tepkisi(aktif_oyuncu_indeksi, 1, 1.2)

# İflasta tahta sarsılır ve ekran kızarır
func _ekrani_sars(guc := 20.0, sure := 0.55):
	if _sarsinti_tween and _sarsinti_tween.is_valid():
		_sarsinti_tween.kill()
	_sarsinti_tween = create_tween()
	var adim = 12
	for k in range(adim):
		var g = guc * (1.0 - float(k) / adim)
		_sarsinti_tween.tween_property(self, "position", _dunya_orijin + Vector2(randf_range(-g, g), randf_range(-g, g)), sure / adim)
	_sarsinti_tween.tween_property(self, "position", _dunya_orijin, 0.05)
	var kizil = ColorRect.new()
	kizil.color = Color(0.9, 0.05, 0.05, 0.28)
	kizil.mouse_filter = Control.MOUSE_FILTER_IGNORE
	kizil.position = Vector2.ZERO
	kizil.size = Vector2(1920, 1080)
	$Arayuz.add_child(kizil)
	var tw = create_tween()
	tw.tween_property(kizil, "color:a", 0.0, 0.8)
	tw.tween_callback(kizil.queue_free)

# ==========================================
# v2.3 — OYUN SONU ÖDÜLLERİ
# ==========================================
func _odul_metni() -> String:
	var oduller = [
		["Ev Ağası", "kira_aldi", " TL kira topladı"],
		["Kira Mağduru", "kira_odedi", " TL kira ödedi"],
		["Müteahhit", "insa", " kat dikti"],
		["Hapis Kuşu", "hapis", " kez hapse girdi"],
		["Son Anda Kurtulan", "kurtulus", " kez borçtan döndü"],
	]
	var satirlar = []
	for od in oduller:
		var en_iyi = -1
		var deger = 0
		for i in range(Global.oyuncu_sayisi):
			var v = int(oyuncular[i]["ist"].get(od[1], 0))
			if v > deger:
				deger = v
				en_iyi = i
		if en_iyi == -1:
			continue
		var renk = oyuncular[en_iyi]["renk"].to_html(false)
		satirlar.append("[color=gold]" + od[0] + "[/color]  [color=#" + renk + "]" + oyuncular[en_iyi]["isim"] + "[/color] [color=#bbbbbb](" + str(deger) + od[2] + ")[/color]")
	if satirlar.is_empty():
		return ""
	return "[font_size=24][b]ÖDÜLLER[/b][/font_size]\n[font_size=21]" + "\n".join(PackedStringArray(satirlar)) + "[/font_size]"


# ==========================================
# v2.3 — TAPU KARTI KİRA TABLOSU
# ------------------------------------------
# Panellerin görünümü (renkler, butonlar, yerleşim) node_2d.tscn sahne dosyasında;
# Godot editöründe doğrudan düzenlenebilir. Burada sadece tapu kartındaki tablo doldurulur.
# ==========================================
@onready var _tapu_tablo: RichTextLabel = $Arayuz/TapuKarti/KiraTablosu

func _tapu_tablosunu_doldur(sehir: String, grup_satiri: String, c: float):
	if _tapu_tablo == null:
		return
	var f = sehirler[sehir]["fiyat"]
	var satirlar = [
		["Boş arsa kirası", int(round(sehirler[sehir]["baslangic_kirasi"] * c))],
		["1 kat", int(round(int(f * 0.50) * c))],
		["2 kat", int(round(int(f * 1.00) * c))],
		["3 kat", int(round(int(f * 1.50) * c))],
		["Plaza", int(round(int(f * 2.00) * c))],
	]
	var t = "[center][font_size=17][color=#7a6a58]SATIN ALMA BEDELİ[/color][/font_size]\n[font_size=38][b]" + str(f) + " TL[/b][/font_size]\n[font_size=17][color=#7a6a58]" + grup_satiri + "[/color][/font_size][/center]\n"
	# Tablo içeriği kadar geniş ve kartın tam ortasında
	t += "[center][table=2]"
	for s in satirlar:
		t += "[cell][left]" + s[0] + "[/left][/cell][cell][right][b]" + str(s[1]) + " TL[/b][/right][/cell]"
	t += "[/table][/center]"
	_tapu_tablo.text = t
