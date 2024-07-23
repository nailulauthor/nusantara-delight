// Import paket-paket yang diperlukan
import 'package:flutter/material.dart';
import 'package:nusantara_delight/pages/cart_provider.dart'; // Provider untuk mengelola state keranjang belanja
import 'package:nusantara_delight/widget/widget_support.dart'; // Mendukung widget dan style custom
import 'package:nusantara_delight/model/food_model.dart'; // Model data untuk makanan
import 'package:provider/provider.dart'; // Paket untuk state management menggunakan Provider

// Widget Stateful untuk halaman detail makanan
class Details extends StatefulWidget {
  final Food food; // Parameter yang diperlukan: objek Food

  const Details({required this.food, super.key}); // Konstruktor menerima parameter food

  @override
  State<Details> createState() => _DetailsState(); // Membuat state untuk widget ini
}

// State class untuk widget Details
class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  int quantity = 1; // Menyimpan kuantitas item yang akan ditambahkan ke keranjang, diinisialisasi ke 1
  late AnimationController _controller; // Mengontrol animasi skala
  late Animation<double> _scaleAnimation; // Mendefinisikan animasi skala

  @override
  void initState() {
    super.initState();
    // Inisialisasi AnimationController dengan durasi 300 milidetik
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Mendefinisikan Tween untuk animasi skala dari 1.0 ke 1.2
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut), // Menggunakan CurvedAnimation dengan kurva easeInOut
    );
  }

  @override
  void dispose() {
    // Membersihkan controller saat widget dibuang
    _controller.dispose();
    super.dispose();
  }

  // Fungsi untuk menambahkan item ke keranjang
  void _addToCart() {
    // Menggunakan provider untuk menambahkan item ke keranjang
    Provider.of<CartProvider>(context, listen: false).addItem(widget.food, quantity);

    // Memicu animasi saat item ditambahkan ke keranjang
    _controller.forward().then((_) {
      _controller.reverse(); // Mengembalikan animasi ke posisi semula
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0), // Margin atas dan samping untuk kontainer utama
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Mengatur alignment ke kiri
            children: [
              // Tombol kembali
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Aksi kembali ke halaman sebelumnya
                },
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black), // Ikon untuk tombol kembali
              ),
              SizedBox(height: 15.0), // Menambahkan ruang kosong vertikal
              // Menampilkan gambar makanan
              Image.asset(
                widget.food.imageUrl, // URL gambar dari objek Food
                width: MediaQuery.of(context).size.width, // Lebar gambar sesuai dengan lebar layar
                height: MediaQuery.of(context).size.height / 2.5, // Tinggi gambar 2.5 kali lebih kecil dari tinggi layar
                fit: BoxFit.cover, // Menutupi seluruh area yang tersedia
              ),
              SizedBox(height: 15.0), // Menambahkan ruang kosong vertikal
              // Menampilkan nama dan deskripsi makanan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan widget di antara mereka
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan teks ke kiri
                      children: [
                        Text(
                          widget.food.name, // Nama makanan
                          style: AppWidget.semiBooldTextFeildStyle(), // Gaya teks semi tebal
                        ),
                        SizedBox(height: 5.0), // Menambahkan ruang kosong vertikal
                        Text(
                          widget.food.description, // Deskripsi makanan
                          style: AppWidget.boldTextFieldStyle(), // Gaya teks tebal
                        ),
                      ],
                    ),
                  ),
                  // Tombol untuk mengurangi atau menambah kuantitas item
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (quantity > 1) { // Mengurangi kuantitas jika lebih dari 1
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black, // Warna latar belakang hitam
                            borderRadius: BorderRadius.circular(8), // Sudut membulat
                          ),
                          child: Icon(
                            Icons.remove, // Ikon minus
                            color: Colors.white, // Warna ikon putih
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0), // Menambahkan ruang kosong horizontal
                      Text(
                        quantity.toString(), // Menampilkan kuantitas item
                        style: AppWidget.semiBooldTextFeildStyle(), // Gaya teks semi tebal
                      ),
                      SizedBox(width: 20.0), // Menambahkan ruang kosong horizontal
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity++; // Menambah kuantitas item
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black, // Warna latar belakang hitam
                            borderRadius: BorderRadius.circular(8), // Sudut membulat
                          ),
                          child: Icon(
                            Icons.add, // Ikon plus
                            color: Colors.white, // Warna ikon putih
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.0), // Menambahkan ruang kosong vertikal
              // Menampilkan komposisi makanan
              Text(
                'Komposisi:',
                style: AppWidget.semiBooldTextFeildStyle(), // Gaya teks semi tebal
              ),
              SizedBox(height: 10.0), // Menambahkan ruang kosong vertikal
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan teks ke kiri
                children: widget.food.ingredients.map((ingredient) { // Menampilkan setiap komposisi dalam daftar
                  return Text(
                    '- $ingredient', // Menampilkan komposisi dengan tanda "- "
                    style: AppWidget.LightTextFeildStyle(), // Gaya teks ringan
                  );
                }).toList(),
              ),
              SizedBox(height: 30.0), // Menambahkan ruang kosong vertikal
              // Menampilkan waktu tunggu
              Row(
                children: [
                  Text("Waktu Tunggu", style: AppWidget.LightTextFeildStyle()), // Teks waktu tunggu
                  SizedBox(width: 5.0), // Menambahkan ruang kosong horizontal
                  Icon(Icons.alarm, color: Colors.black54), // Ikon alarm
                  SizedBox(width: 5.0), // Menambahkan ruang kosong horizontal
                  Text("30 min", style: AppWidget.semiBooldTextFeildStyle()), // Waktu tunggu dengan gaya teks semi tebal
                ],
              ),
              SizedBox(height: 20.0), // Menambahkan ruang kosong vertikal
              // Menampilkan total harga dan tombol untuk menambahkan item ke keranjang
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan widget di antara mereka
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan teks ke kiri
                    children: [
                      Text("Total", style: AppWidget.semiBooldTextFeildStyle()), // Teks total
                      Text(
                        'Rp. ${(widget.food.price * quantity).toStringAsFixed(0)}', // Total harga dengan format angka tetap
                        style: AppWidget.semiBooldTextFeildStyle(), // Gaya teks semi tebal
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _addToCart, // Aksi menambahkan item ke keranjang
                    child: ScaleTransition(
                      scale: _scaleAnimation, // Animasi skala
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5, // Lebar kontainer
                        padding: EdgeInsets.all(10), // Padding dalam kontainer
                        decoration: BoxDecoration(
                          color: Colors.black, // Warna latar belakang hitam
                          borderRadius: BorderRadius.circular(10), // Sudut membulat
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan widget di antara mereka
                          children: [
                            Text(
                              "Add to cart", // Teks tombol
                              style: TextStyle(
                                color: Colors.white, // Warna teks putih
                                fontSize: 16.0, // Ukuran font
                                fontFamily: "Poppins", // Jenis font
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8), // Padding dalam kontainer
                              decoration: BoxDecoration(
                                color: Colors.grey, // Warna latar belakang abu-abu
                                borderRadius: BorderRadius.circular(8), // Sudut membulat
                              ),
                              child: Icon(
                                Icons.shopping_cart, // Ikon keranjang
                                color: Colors.white, // Warna ikon putih
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0), // Menambahkan ruang kosong vertikal
            ],
          ),
        ),
      ),
    );
  }
}
