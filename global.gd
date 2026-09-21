extends Node

var oyuncu_sayisi = 2

# Her oyuncunun seçimlerini (İsim, Araba Modeli ve Renk) hafızada tutacağımız sözlük
var oyuncu_ayarlari = {
	0: {"isim": "Oyuncu 1", "araba_indeksi": 0, "renk": Color.RED},
	1: {"isim": "Oyuncu 2", "araba_indeksi": 1, "renk": Color.BLUE},
	2: {"isim": "Oyuncu 3", "araba_indeksi": 2, "renk": Color.YELLOW},
	3: {"isim": "Oyuncu 4", "araba_indeksi": 3, "renk": Color.GREEN}
}
