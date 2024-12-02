import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailSurat extends StatelessWidget {
  final int nomor;  // Nomor surat yang digunakan untuk mengambil data

  const DetailSurat({required this.nomor});

  Future<Map<String, dynamic>> fetchSurahDetails() async {
    final response = await http.get(Uri.parse('https://example.com/api/v2/tafsir/$nomor'));

    if (response.statusCode == 200) {
      // Jika server mengembalikan respons OK, parse data JSON
      return json.decode(response.body);
    } else {
      // Jika server tidak merespons dengan benar, lempar pengecualian
      throw Exception('Failed to load surah details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Surat $nomor'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchSurahDetails(), // Memanggil fungsi untuk mengambil data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Menunggu data, tampilkan indikator loading
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Jika terjadi error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Jika data berhasil diambil
            final surahDetails = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surahDetails['namaLatin'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${surahDetails['arti']} • ${surahDetails['tempatTurun']} • ${surahDetails['jumlahAyat']} Ayat',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    surahDetails['deskripsi'],
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
