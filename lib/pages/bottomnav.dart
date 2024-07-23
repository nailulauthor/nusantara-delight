import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nusantara_delight/pages/home.dart';
import 'package:nusantara_delight/pages/order.dart';
import 'package:nusantara_delight/pages/profile.dart';
import 'package:nusantara_delight/pages/promotion.dart';

// Mendefinisikan widget Stateful Bottomnav
class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

// State class untuk Bottomnav
class _BottomnavState extends State<Bottomnav> {
  // Menyimpan indeks tab saat ini
  int currentTabIndex = 0;

  // Menyimpan daftar halaman yang akan ditampilkan
  late List<Widget> pages;
  // Menyimpan halaman yang saat ini ditampilkan
  late Widget currentPage;
  // Menyimpan instance dari halaman Home
  late Home homepage;
  // Menyimpan instance dari halaman Profile
  late Profile profile;
  // Menyimpan instance dari halaman Order
  late Order order;
  // Menyimpan instance dari halaman Promotion
  late Promotion promotion;

  // Inisialisasi state awal
  @override
  void initState() {
    homepage = Home();
    order = Order();
    profile = Profile();
    promotion = Promotion();
    pages = [homepage, promotion, order, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mendefinisikan bottom navigation bar dengan tampilan melengkung
      bottomNavigationBar: CurvedNavigationBar(
        height: 65, // Tinggi navigation bar
        backgroundColor: Colors.white, // Warna latar belakang saat berganti tab
        color: Colors.black, // Warna navigation bar
        animationDuration: Duration(milliseconds: 500), // Durasi animasi
        onTap: (int index) {
          setState(() {
            currentTabIndex = index; // Mengubah indeks tab saat ini ketika tab ditekan
          });
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.white, // Ikon dan warna untuk tab Home
          ),
          Icon(
            Icons.mic_external_on,
            color: Colors.white, // Ikon dan warna untuk tab Promotion
          ),
          Icon(
            Icons.shopping_bag,
            color: Colors.white, // Ikon dan warna untuk tab Order
          ),
          Icon(
            Icons.person,
            color: Colors.white, // Ikon dan warna untuk tab Profile
          ),
        ],
      ),
      // Menampilkan halaman sesuai dengan tab yang dipilih
      body: pages[currentTabIndex],
    );
  }
}
