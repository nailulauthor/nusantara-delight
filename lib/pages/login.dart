// Import paket-paket yang diperlukan
import 'package:firebase_auth/firebase_auth.dart'; // Paket untuk autentikasi Firebase
import 'package:flutter/material.dart'; // Paket utama Flutter untuk membangun UI
import 'package:nusantara_delight/pages/bottomnav.dart'; // Import halaman Bottomnav
import 'package:nusantara_delight/pages/forgotpassword.dart'; // Import halaman Forgotpassword
import 'package:nusantara_delight/pages/signup.dart'; // Import halaman Signup
import 'package:nusantara_delight/widget/widget_support.dart'; // Import widget support untuk gaya

// Widget Stateful untuk halaman Login
class Login extends StatefulWidget {
  const Login({super.key}); // Konstruktor dengan parameter key opsional

  @override
  State<Login> createState() => _LoginState(); // Membuat state untuk widget ini
}

// State class untuk widget Login
class _LoginState extends State<Login> {
  String email = '', password = ''; // Variabel untuk menyimpan email dan password
  final _formKey = GlobalKey<FormState>(); // Kunci form untuk validasi
  TextEditingController userEmailController = TextEditingController(); // Kontroler untuk input email
  TextEditingController userPasswordController = TextEditingController(); // Kontroler untuk input password

  // Fungsi untuk login pengguna
  userLogin() async {
    try {
      // Melakukan login menggunakan Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Jika login berhasil, tampilkan snackbar dan navigasi ke halaman Bottomnav
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Login Berhasil',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ));
      // Navigasi ke halaman Bottomnav setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
    } on FirebaseAuthException catch (e) {
      // Menangani error saat login
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'User Email Tidak Ada';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password Salah';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      // Tampilkan snackbar dengan pesan error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Mengatur tinggi kontainer sesuai layar
          child: Stack(
            children: [
              // Bagian atas layar dengan gradien warna
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
              // Bagian bawah layar dengan warna putih dan sudut membulat
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
              // Konten utama halaman login
              Container(
                margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "images/logo.png",
                        width: MediaQuery.of(context).size.width / 3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Material(
                      elevation: 5.0, // Efek bayangan pada material
                      borderRadius: BorderRadius.circular(20), // Sudut membulat
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20), // Sudut membulat
                        ),
                        child: Form(
                          key: _formKey, // Kunci form untuk validasi
                          child: Column(
                            children: [
                              SizedBox(height: 30.0),
                              Text(
                                "Masuk",
                                style: AppWidget.boldTextFieldStyle(), // Gaya teks dari widget support
                              ),
                              SizedBox(height: 30.0),
                              // Input form untuk email
                              TextFormField(
                                controller: userEmailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Email!'; // Validasi input email
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle:
                                      AppWidget.semiBooldTextFeildStyle(), // Gaya teks petunjuk dari widget support
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              // Input form untuk password
                              TextFormField(
                                controller: userPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Password!'; // Validasi input password
                                  }
                                  return null;
                                },
                                obscureText: true, // Menyembunyikan teks password
                                decoration: InputDecoration(
                                  hintText: "Kata Sandi",
                                  hintStyle:
                                      AppWidget.semiBooldTextFeildStyle(), // Gaya teks petunjuk dari widget support
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              // Teks untuk mengarahkan ke halaman lupa password
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Forgotpassword())); // Navigasi ke halaman Forgotpassword
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Lupa Kata Sandi?",
                                    style: AppWidget.semiBooldTextFeildStyle(), // Gaya teks dari widget support
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              // Tombol untuk login
                              GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Jika form valid, set state dan lakukan login
                                    setState(() {
                                      email = userEmailController.text;
                                      password = userPasswordController.text;
                                    });
                                    await userLogin(); // Panggil fungsi login
                                  }
                                },
                                child: Material(
                                  elevation: 5.0, // Efek bayangan pada material
                                  borderRadius: BorderRadius.circular(20), // Sudut membulat
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Color(0Xffff5722), // Warna tombol
                                      borderRadius: BorderRadius.circular(20), // Sudut membulat
                                    ),
                                    child: Center(
                                      child: Text(
                                        "MASUK",
                                        style: TextStyle(
                                          color: Colors.white, // Warna teks
                                          fontSize: 18.0, // Ukuran font
                                          fontFamily: "Poppins", // Jenis font
                                          fontWeight: FontWeight.bold, // Ketebalan font
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Teks untuk mengarahkan ke halaman daftar
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup())); // Navigasi ke halaman Signup
                      },
                      child: Text(
                        "Tidak punya akun? Daftar",
                        style: AppWidget.semiBooldTextFeildStyle(), // Gaya teks dari widget support
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
