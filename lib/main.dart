import 'package:firebase_core/firebase_core.dart'; // Mengimpor paket Firebase Core untuk inisialisasi Firebase
import 'package:flutter/material.dart'; // Mengimpor paket Material Design untuk widget dan tema
import 'package:nusantara_delight/firebase_options.dart'; // Mengimpor konfigurasi Firebase khusus platform
import 'package:nusantara_delight/pages/cart_provider.dart'; // Mengimpor provider untuk keranjang belanja
import 'package:nusantara_delight/pages/onboard.dart'; // Mengimpor halaman onboard aplikasi
import 'package:provider/provider.dart'; // Mengimpor paket Provider untuk state management

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan binding Flutter terinisialisasi sebelum menjalankan kode asinkron
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform // Menginisialisasi Firebase dengan opsi konfigurasi saat ini
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(), // Membuat instance CartProvider untuk state management
      child: MyApp(), // Menjalankan widget MyApp sebagai root widget aplikasi
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Widget root aplikasi
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug di aplikasi
      title: 'Flutter Demo', // Judul aplikasi yang akan ditampilkan di task manager
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Mengatur skema warna tema aplikasi
        useMaterial3: true, // Mengaktifkan Material Design 3
      ),
      home: Onboard(), // Menetapkan halaman awal aplikasi ke widget Onboard
    );
  }
}
