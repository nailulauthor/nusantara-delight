import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nusantara_delight/pages/bottomnav.dart';
import 'package:nusantara_delight/pages/login.dart';
import 'package:nusantara_delight/widget/widget_support.dart';

// Mengimpor paket yang diperlukan untuk autentikasi Firebase, widget Material, 
// serta halaman dan widget khusus aplikasi.
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = '', password = '', name = '';

  // Membuat controller untuk mengendalikan input teks
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>(); // Kunci global untuk form

  // Fungsi registrasi pengguna
  registrasion() async {
    if (password.isNotEmpty) {
      try {
        // Mencoba membuat pengguna baru dengan email dan password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Menampilkan snackbar dengan pesan registrasi berhasil
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Registrasi Berhasil',
            style: TextStyle(fontSize: 20.0),
          ),
        ));
        // Navigasi ke halaman Bottomnav setelah registrasi berhasil
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Bottomnav()));
      } on FirebaseAuthException catch (e) {
        // Menangani berbagai jenis kesalahan Firebase
        if (e.code == 'weak-password') {
          // Password yang dimasukkan terlalu lemah
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Password Kurang Aman',
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else if (e.code == 'email-already-in-use') {
          // Email sudah digunakan
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Akun Sudah Ada',
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Menghindari inset saat keyboard muncul
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Mengambil tinggi layar
          child: Stack(
            children: [
              // Bagian atas dengan gradient background
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFff5c30),
                      Color(0xFFe74b1a),
                    ],
                  ),
                ),
              ),
              // Bagian bawah dengan background putih dan sudut membulat
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              // Isi form dan elemen lainnya
              Container(
                margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    // Logo di tengah
                    Center(
                      child: Image.asset(
                        "images/logo.png",
                        width: MediaQuery.of(context).size.width / 3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Form registrasi
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _formkey, // Menyimpan kunci form
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 30.0),
                              Text(
                                "Daftar",
                                style: AppWidget.boldTextFieldStyle(), // Gaya teks dari widget_support
                              ),
                              SizedBox(height: 30.0),
                              // Input Nama
                              TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Nama!'; // Validasi nama
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Nama",
                                  hintStyle:
                                      AppWidget.semiBooldTextFeildStyle(),
                                  prefixIcon: Icon(Icons.person_outlined),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              // Input Email
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan E-Mail!'; // Validasi email
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle:
                                      AppWidget.semiBooldTextFeildStyle(),
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              // Input Password
                              TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Kata Sandi!'; // Validasi password
                                  }
                                  return null;
                                },
                                obscureText: true, // Menyembunyikan teks password
                                decoration: InputDecoration(
                                  hintText: "Kata Sandi",
                                  hintStyle:
                                      AppWidget.semiBooldTextFeildStyle(),
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                              ),
                              SizedBox(height: 40.0),
                              // Tombol Daftar
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = emailController.text;
                                      password = passwordController.text;
                                      name = nameController.text;
                                    });
                                    await registrasion(); // Memanggil fungsi registrasi
                                  }
                                },
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Color(0Xffff5722),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "DAFTAR",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Link ke halaman login
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Sudah punya akun? Masuk",
                        style: AppWidget.semiBooldTextFeildStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
