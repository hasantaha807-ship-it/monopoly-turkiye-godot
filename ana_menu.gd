extends Control

@onready var v_box_container = $VBoxContainer
@onready var basla_butonu = $VBoxContainer/basla_butonu
@onready var cikis_butonu = $VBoxContainer/cikis_butonu

# Seçim kutusu sistemi
@onready var secim_kutusu = $SecimKutusu
@onready var iki_kisi_butonu = $SecimKutusu/IkiKisiButonu
@onready var uc_kisi_butonu = $SecimKutusu/UcKisiButonu
@onready var dort_kisi_butonu = $SecimKutusu/DortKisiButonu

func _ready():
	# Başlangıçta 2-3-4 kişi butonlarını gizle
	secim_kutusu.hide()
	
	# Butonları bağla
	basla_butonu.pressed.connect(_on_basla_basildi)
	cikis_butonu.pressed.connect(_on_cikis_basildi)
	
	iki_kisi_butonu.pressed.connect(_on_iki_kisi_basildi)
	uc_kisi_butonu.pressed.connect(_on_uc_kisi_basildi)
	dort_kisi_butonu.pressed.connect(_on_dort_kisi_basildi)

func _on_basla_basildi():
	# BAŞLA'ya basılınca ana butonları gizle ve SecimKutusu'nu göster
	v_box_container.hide()
	secim_kutusu.show()

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
