import 'dart:convert';
import 'package:flutter/material.dart';
import 'quran.dart';
import 'qibla.dart';
import 'Juz.dart';
import 'doa.dart';
import 'tafsir.dart';
import 'detail_surat.dart';
void main() {
  runApp(AplikasiSaya());
}

class AplikasiSaya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal, // Menggunakan satu warna teal
        child: Stack( // Menggunakan Stack untuk menempatkan gambar bayangan di bawah
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gambar dari URL
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://infaqberkah.id/wp-content/uploads/2023/08/1426962971.jpg'), // Ganti dengan URL gambar
                  ),
                  SizedBox(height: 10),
                  // Teks di bawah gambar
                  Text(
                    'TPQ Nurul Huda',
                    style: TextStyle(
                      color: Colors.yellow[100],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Tombol "Masuk"
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.yellow[100], // Warna tombol
                      foregroundColor: Colors.teal, // Warna teks tombol
                    ),
                    onPressed: () {
                      // Navigasi ke layar utama
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LayarUtama()),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            // Menambahkan bayangan masjid di bagian bawah
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.network(
                'https://cdn.pixabay.com/photo/2021/03/12/01/27/mosque-6088456_1280.png', // Ganti dengan URL gambar bayangan masjid
                fit: BoxFit.cover, // Menyesuaikan gambar dengan lebar
                height: 100, // Sesuaikan tinggi bayangan masjid
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LayarUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Panah di kiri atas
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _bagianAtas(),
            _daftarJuz(context),
            _fiturBawah(context), // Menambahkan fitur di bagian bawah
          ],
        ),
      ),
    );
  }

  Widget _bagianAtas() {
  return Container(
    height: 300, // Atur tinggi container sesuai kebutuhan
    width: double.infinity, // Pastikan lebar container penuh
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            'https://cendekiamuslim.or.id/uploads/images/202401/image_870x_65b86d303fa7b.jpg'), // Gambar dari URL
        fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran container
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
  );
}


Widget _daftarJuz(BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: List.generate(
          30,
          (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanJuzPage(
                    juz: (index + 1).toString(),
                    edition: 'indo', // Ganti jika edisi berbeda
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity, // Lebar penuh
              height: 50, // Tinggi item
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white, // Warna tengah putih
                border: Border.all(color: Colors.teal, width: 2), // Garis tepi teal
                borderRadius: BorderRadius.circular(10), // Sudut melengkung
              ),
              child: Center(
                child: Text(
                  'Juz ${index + 1}',
                  style: TextStyle(
                    color: Colors.teal, // Warna teks teal
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}



  Widget _fiturBawah(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.9), // Latar belakang hijau di bagian bawah
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _itemFitur(context, Icons.book, 'Quran', QuranPage()),
          _itemFitur(context, Icons.explore, 'waktu sholat', WaktuSholatPage()),
          // _itemFitur(context, Icons.volunteer_activism, 'Penjelasan Surat', HalamanJuzPage(juz: '1', edition: 'indo')),
          _itemFitur(context, Icons.notifications, 'Hadits', HadithPage()),
        ],
      ),
    );
  }

  Widget _itemFitur(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30, color: Colors.white), // Ukuran ikon lebih kecil
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 10, color: Colors.white), // Ukuran teks lebih kecil
          ),
        ],
      ),
    );
  }
}


  Widget _fiturBawah(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.9), // Latar belakang hijau di bagian bawah
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _itemFitur(context, Icons.book, 'Quran', QuranPage()),
          _itemFitur(context, Icons.explore, 'Waktu Sholat', WaktuSholatPage()),
          _itemFitur(context, Icons.volunteer_activism, 'Juz', HalamanJuzPage(juz: '1', edition: 'indo')),
          _itemFitur(context, Icons.notifications, 'Hadits', HadithPage()),
        ],
      ),
    );
  }

  Widget _itemFitur(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30, color: Colors.white), // Ukuran ikon lebih kecil
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 10, color: Colors.white), // Ukuran teks lebih kecil
          ),
        ],
      ),
    );
  }

