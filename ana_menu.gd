extends Control

@onready var v_box_container = $VBoxContainer
@onready var basla_butonu = $VBoxContainer/basla_butonu
@onready var cikis_butonu = $VBoxContainer/cikis_butonu

# Seçim kutusu sistemi
@onready var secim_kutusu = $SecimKutusu
@onready var iki_kisi_butonu = $SecimKutusu/IkiKisiButonu
@onready var uc_kisi_butonu = $SecimKutusu/UcKisiButonu
@onready var dort_kisi_butonu = $SecimKutusu/DortKisiButonu
@onready var geri_butonu = $SecimKutusu/GeriButonu

func _ready():
	# Başlangıçta 2-3-4 kişi butonlarını gizle
	secim_kutusu.hide()
	
	# Butonları bağla
	basla_butonu.pressed.connect(_on_basla_basildi)
	cikis_butonu.pressed.connect(_on_cikis_basildi)
	
	iki_kisi_butonu.pressed.connect(_on_iki_kisi_basildi)
	uc_kisi_butonu.pressed.connect(_on_uc_kisi_basildi)
	dort_kisi_butonu.pressed.connect(_on_dort_kisi_basildi)
	geri_butonu.pressed.connect(_on_geri_basildi)

	# --- ÇEVRİMİÇİ (AYNI Wİ-Fİ) BUTONU ---
	var online_butonu = Button.new()
	online_butonu.name = "online_butonu"
	online_butonu.text = "ÇEVRİMİÇİ OYNA"
	online_butonu.custom_minimum_size = basla_butonu.custom_minimum_size
	online_butonu.size_flags_horizontal = basla_butonu.size_flags_horizontal
	online_butonu.theme = basla_butonu.theme
	for ozellik in ["font_size"]:
		if basla_butonu.has_theme_font_size_override(ozellik):
			online_butonu.add_theme_font_size_override(ozellik, basla_butonu.get_theme_font_size(ozellik))
	for stil in ["normal", "hover", "pressed", "focus"]:
		if basla_butonu.has_theme_stylebox_override(stil):
			online_butonu.add_theme_stylebox_override(stil, basla_butonu.get_theme_stylebox(stil))
	if basla_butonu.has_theme_color_override("font_color"):
		online_butonu.add_theme_color_override("font_color", basla_butonu.get_theme_color("font_color"))
	v_box_container.add_child(online_butonu)
	v_box_container.move_child(online_butonu, basla_butonu.get_index() + 1)
	online_butonu.pressed.connect(func(): get_tree().change_scene_to_file("res://lobi.tscn"))

	# Çevrimiçi oyundan bir hata ile dönüldüyse mesajı göster
	if Ag.son_mesaj != "":
		var mesaj = Label.new()
		mesaj.text = Ag.son_mesaj
		mesaj.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		mesaj.add_theme_font_size_override("font_size", 30)
		mesaj.add_theme_color_override("font_color", Color(1, 0.8, 0.4))
		v_box_container.add_child(mesaj)
		Ag.son_mesaj = ""

func _on_basla_basildi():
	# Tek cihazda botlara karşı oyun: çevrimiçi oyundaki oda ekranının aynısı açılır
	Ag.acilis_modu = "cevrimdisi"
	get_tree().change_scene_to_file("res://lobi.tscn")

func _on_cikis_basildi():
	get_tree().quit()

# --- YENİ SEÇİM VE GALERİYE GEÇİŞ FONKSİYONLARI ---
func _on_iki_kisi_basildi():
	Global.oyuncu_sayisi = 2
	# YENİ: Artık direkt oyuna değil, araba seçmeye (galeriye) gidiyor!
	get_tree().change_scene_to_file("res://ana_menu_control.tscn")

func _on_uc_kisi_basildi():
	Global.oyuncu_sayisi = 3
	get_tree().change_scene_to_file("res://ana_menu_control.tscn")

func _on_dort_kisi_basildi():
	Global.oyuncu_sayisi = 4
	get_tree().change_scene_to_file("res://ana_menu_control.tscn")

func _on_geri_basildi():
	# Seçim kutusunu gizle, ana menü butonlarını geri getir
	$SecimKutusu.hide()
	$VBoxContainer.show()
