# 🎲 Monopoly Türkiye (Godot 4 Projesi)

Godot 4 oyun motoru kullanılarak baştan sona geliştirilmiş, Türkiye şehirlerini barındıran, gelişmiş yapay zeka ve ihale mekaniklerine sahip 2D masa oyunu.

## 🌟 Öne Çıkan Özellikler
* **Gelişmiş Yapay Zeka (AI):** Bütçesine göre mülk satın alma, ihale teklifi artırma ve hapishaneden çıkış kararları verebilen otonom botlar.
* **Akıllı İhale Sistemi:** Sahipsiz kalan veya iflas eden oyuncuların mülkleri için devreye giren rekabetçi açık artırma algoritması.
* **Dinamik Oyun Tahtası:** Evlerin seviye atlayarak plazalara dönüştüğü inşaat sistemi ve aynı kareye gelen oyuncuları yan yana dizen akıllı otopark (vale) mekaniği.
* **Modern Arayüz & Animasyonlar:** BBCode destekli bildirim panelleri, akıcı zar fırlatma/sekme animasyonları ve duruma göre kilitlenen etkileşimli UI tasarımı.

## 🛠️ Kullanılan Teknolojiler
* **Oyun Motoru:** Godot Engine 4.x
* **Programlama Dili:** GDScript
* **Versiyon Kontrol:** Git & GitHub Desktop

## 📸 Ekran Görüntüleri
<img width="1920" height="1080" alt="Ekran Görüntüsü (18)" src="https://github.com/user-attachments/assets/a0737fe9-c94a-48d5-9932-f727d299fbf9" />
<img width="1920" height="1080" alt="Ekran Görüntüsü (22)" src="https://github.com/user-attachments/assets/2686a75f-dc3f-4309-9241-128659047746" />


## 🚀 Nasıl Oynanır?
1. Sağ üstteki yeşil **Code** butonundan projeyi `.zip` olarak indirin.
2. Godot 4 motorunu açıp, inen klasördeki `project.godot` dosyasını içeri aktarın.
3. F5 tuşuna basarak oyunu hemen deneyimlemeye başlayın!

## 📡 Çevrimiçi Oyun (Aynı Wi-Fi / Hotspot)
Ana menüdeki **ÇEVRİMİÇİ OYNA (AYNI Wİ-Fİ)** butonuyla 2-4 kişi kendi telefonundan (veya bilgisayarından) aynı oyunu oynayabilir. İnternet sunucusu gerekmez.

1. Herkes aynı Wi-Fi ağına bağlanır (ya da biri telefonundan hotspot açar, diğerleri ona bağlanır).
2. Bir kişi ismini, arabasını ve rengini seçip **ODA KUR**'a basar.
3. Diğerleri "Bulunan Odalar" listesinde odaya dokunur. Oda listede çıkmazsa, oda sahibinin ekranında yazan IP adresini kutuya yazıp **BAĞLAN**'a basar.
4. Oda sahibi isterse boş yerlere **BOT EKLE** ile bot koyar ve **OYUNU BAŞLAT**'a basar.

**Teknik özet:** Odayı kuran cihaz sunucudur; zarlar, şans kartları, botlar ve süreler sadece onda üretilir. Her hamle bir komut olarak tüm cihazlara gönderilir ve her cihaz komutları aynı sırayla işler (`node_2d.gd` içindeki `_komut` / `_komutu_isle`). Her tur başında sunucu tam oyun durumunu da gönderir, böylece küçük kaymalar kendiliğinden düzelir. Ağ ve lobi kodu `ag.gd` (autoload: `Ag`) ve `lobi.gd` dosyalarındadır.

- Bağlantısı kopan oyuncunun yerine bot oynar; aynı isimle odaya tekrar katılırsa sıradaki turdan itibaren kontrolü geri alır.
- Oda sahibi oyundan çıkarsa oyun herkes için biter.
- Kullanılan portlar: 7777 (oyun, ENet/UDP) ve 7778 (oda bulma yayını, UDP). Bilgisayarda oda kurarken Windows Güvenlik Duvarı izin isterse "Özel ağlar" için izin verin.
