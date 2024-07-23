import 'package:flutter/material.dart'; // Paket utama Flutter untuk membangun UI

// Widget stateless untuk halaman Promotion
class Promotion extends StatelessWidget {
  // Daftar promosi yang akan ditampilkan
  final List<String> promotions = [
    'Diskon 50% untuk menu spesial bulan ini!',
    'Beli 2 gratis 1 untuk semua minuman!',
    'Promo akhir pekan: Potongan harga 20% untuk semua makanan!',
  ];

  @override
  Widget build(BuildContext context) {
    // Fungsi build untuk membangun antarmuka pengguna
    return Scaffold(
      appBar: AppBar(
        title: Text('Promosi Nusantara Delight'), // Judul pada AppBar
      ),
      body: Container(
        color: Colors.black, // Warna latar belakang hitam
        child: ListView.builder(
          // ListView.builder untuk menampilkan daftar promosi secara dinamis
          itemCount: promotions.length, // Jumlah item dalam daftar promosi
          itemBuilder: (context, index) {
            // Fungsi untuk membangun setiap item dalam daftar
            return Card(
              color: Colors.grey[900], // Warna latar belakang kartu abu-abu gelap
              child: Column(
                children: [
                  Image.asset(
                    'images/promo-image.png', // Gambar promosi
                    fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran kotak
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0), // Padding di sekitar teks promosi
                    child: Text(
                      promotions[index], // Teks promosi berdasarkan indeks
                      style: TextStyle(color: Colors.white), // Warna teks putih
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
