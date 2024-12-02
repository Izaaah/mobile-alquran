import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TafsirDetailPage extends StatefulWidget {
  final int nomorSurah;

  TafsirDetailPage(this.nomorSurah);

  @override
  _TafsirDetailPageState createState() => _TafsirDetailPageState();
}

class _TafsirDetailPageState extends State<TafsirDetailPage> {
  Map<String, dynamic>? surahDetails;

  @override
  void initState() {
    super.initState();
    fetchSurahDetails();
  }

  Future<void> fetchSurahDetails() async {
    final response = await http.get(Uri.parse('https://equran.id/api/v2/surat/${widget.nomorSurah}'));
    if (response.statusCode == 200) {
      setState(() {
        surahDetails = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load surah details');
    }
  }

  // Fungsi untuk mengonversi angka Latin ke angka Arab
  String convertToArabicNumerals(int number) {
    final arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((e) => arabicNumerals[int.parse(e)])
        .join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surahDetails?['namaLatin'] ?? 'Loading...',
        style:TextStyle(
          color:Colors.teal,
        ),
        ),
      ),
      body: surahDetails == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...surahDetails!['ayat'].map<Widget>((ayah) => ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Menambahkan nomor ayat dengan bingkai bulat di sebelah kiri teks Arab
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.5), width: 1.5), // Pinggiran halus
                                borderRadius: BorderRadius.circular(30), // Bingkai lebih besar
                                color: Colors.white, // Warna latar belakang untuk bingkai
                              ),
                              child: Text(
                                convertToArabicNumerals(ayah['nomorAyat']),
                                style: TextStyle(
                                  fontSize: 18, // Ukuran font yang sedikit lebih besar
                                  color: Colors.black, // Warna teks angka
                                  fontWeight: FontWeight.bold, // Menebalkan angka
                                ),
                              ),
                            ),
                            SizedBox(width: 10), // Jarak antara nomor ayat dan teks Arab
                            Expanded(
                              child: Text(
                                ayah['teksArab'],
                                style: TextStyle(
                                  fontSize: 24, // Ukuran font yang lebih besar untuk teks Arab
                                  fontWeight: FontWeight.bold, // Menebalkan teks Arab
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.3),
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ayah['teksLatin'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.teal[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                ayah['teksIndonesia'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}
