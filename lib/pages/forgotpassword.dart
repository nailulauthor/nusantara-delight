// Import paket-paket yang diperlukan
import 'package:firebase_auth/firebase_auth.dart'; // Paket untuk otentikasi Firebase
import 'package:flutter/material.dart'; // Paket utama Flutter untuk membangun UI
import 'package:nusantara_delight/pages/signup.dart'; // Import halaman Signup

// Widget Stateful untuk halaman pemulihan password
class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key}); // Konstruktor dengan parameter key opsional

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState(); // Membuat state untuk widget ini
}

// State class untuk widget Forgotpassword
class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailController = TextEditingController(); // Kontroler untuk mengelola teks input email

  String email = ''; // Variabel untuk menyimpan email

  final _formKey = GlobalKey<FormState>(); // Kunci global untuk form

  // Fungsi untuk mengatur ulang password
  resetPassword() async {
    try {
      // Mengirim email pengaturan ulang password menggunakan Firebase Auth
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Menampilkan pesan sukses menggunakan SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Pengaturan ulang Kata Sandi telah dikirim melalui Email!", // Pesan sukses
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.green, // Warna latar belakang hijau
      ));
    } on FirebaseAuthException catch (e) {
      // Menangani kesalahan saat mengirim email pengaturan ulang
      if (e.code == "user-not-found") {
        // Menampilkan pesan kesalahan jika email tidak ditemukan
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Email Tidak Ditemukan", // Pesan kesalahan
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.red, // Warna latar belakang merah
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Warna latar belakang halaman
      body: Container(
        padding: EdgeInsets.all(20.0), // Padding untuk kontainer utama
        child: Column(
          children: [
            SizedBox(
              height: 70.0, // Menambahkan ruang kosong vertikal
            ),
            // Teks judul halaman
            Container(
              alignment: Alignment.topCenter, // Menyelaraskan teks ke tengah atas
              child: Text(
                "Pemulihan Password",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold), // Gaya teks tebal
              ),
            ),
            SizedBox(
              height: 10.0, // Menambahkan ruang kosong vertikal
            ),
            // Teks instruksi
            Text(
              "Masukkan E-mail Kamu",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold), // Gaya teks tebal
            ),
            SizedBox(height: 20.0), // Menambahkan ruang kosong vertikal
            Expanded(
              child: Form(
                key: _formKey, // Kunci untuk form
                child: Padding(
                  padding: EdgeInsets.all(10.0), // Padding untuk form
                  child: ListView(
                    children: [
                      // TextFormField untuk input email
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0), // Padding dalam kontainer
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70, width: 2.0), // Border putih
                          borderRadius: BorderRadius.circular(30), // Sudut membulat
                        ),
                        child: TextFormField(
                          controller: emailController, // Kontroler untuk input email
                          validator: (value) {
                            // Validasi input email
                            if (value == null || value.isEmpty) {
                              return 'Masukkan E-mail'; // Pesan error jika email kosong
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white), // Warna teks putih
                          decoration: InputDecoration(
                            hintText: "Email", // Teks petunjuk
                            hintStyle: TextStyle(fontSize: 18.0, color: Colors.white), // Gaya teks petunjuk
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: 30.0,
                            ),
                            border: InputBorder.none, // Menghilangkan border default
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0, // Menambahkan ruang kosong vertikal
                      ),
                      // Tombol untuk mengirim email reset password
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // Validasi form
                            setState(() {
                              email = emailController.text; // Mengatur email dari kontroler
                            });
                            resetPassword(); // Memanggil fungsi resetPassword
                          }
                        },
                        child: Container(
                          width: 140, // Lebar kontainer
                          padding: EdgeInsets.all(10), // Padding dalam kontainer
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)), // Warna latar belakang putih dengan sudut membulat
                          child: Center(
                            child: Text(
                              "Send Email", // Teks tombol
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold), // Gaya teks tebal
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0, // Menambahkan ruang kosong vertikal
                      ),
                      // Teks dan tombol navigasi ke halaman Signup
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Menyelaraskan widget di tengah
                        children: [
                          Text(
                            "Tidak punya akun?",
                            style: TextStyle(fontSize: 18.0, color: Colors.white), // Gaya teks
                          ),
                          SizedBox(width: 5.0), // Menambahkan ruang kosong horizontal
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup())); // Navigasi ke halaman Signup
                            },
                            child: Text(
                              "Daftar",
                              style: TextStyle(
                                  color: Color.fromARGB(225, 184, 166, 6),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500), // Gaya teks untuk navigasi
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
