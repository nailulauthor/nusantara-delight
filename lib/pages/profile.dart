// Import paket-paket yang diperlukan
import 'package:firebase_auth/firebase_auth.dart'; // Paket Firebase Authentication
import 'package:flutter/material.dart'; // Paket utama Flutter untuk membangun UI
import 'package:nusantara_delight/pages/login.dart'; // Halaman login

// Widget Stateful untuk halaman Profile
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState(); // Membuat state untuk widget ini
}

// State class untuk widget Profile
class _ProfileState extends State<Profile> {
  User? user; // Menyimpan user yang sedang login
  TextEditingController emailController = TextEditingController(); // Controller untuk TextField email
  bool isEditingEmail = false; // Status untuk mengecek apakah sedang mengedit email

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser; // Mendapatkan user yang sedang login dari Firebase Authentication
    emailController.text = user?.email ?? ''; // Mengisi controller dengan email user jika ada
  }

  Future<void> logout() async {
    // Fungsi untuk logout
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Keluar'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(false); // Menutup dialog dengan false
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(true); // Menutup dialog dengan true
              },
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      await FirebaseAuth.instance.signOut(); // Proses logout dari Firebase
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false); // Menavigasi ke halaman login dan menghapus stack navigasi
    }
  }

  Future<void> deleteAccount() async {
    // Fungsi untuk menghapus akun
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Akun'),
          content: Text('Apakah Anda yakin ingin menghapus akun?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(false); // Menutup dialog dengan false
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(true); // Menutup dialog dengan true
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        await user?.delete(); // Menghapus akun user dari Firebase
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false); // Menavigasi ke halaman login dan menghapus stack navigasi
      } on FirebaseAuthException catch (e) {
        // Menangkap error dari Firebase Authentication
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Kesalahan: ${e.message}"), // Menampilkan pesan error
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> sendVerificationEmail() async {
    // Fungsi untuk mengirim email verifikasi
    try {
      await user?.sendEmailVerification(); // Mengirim email verifikasi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email verifikasi telah dikirim. Silakan cek email Anda.'), // Menampilkan pesan sukses
        backgroundColor: Colors.green,
      ));
    } on FirebaseAuthException catch (e) {
      // Menangkap error dari Firebase Authentication
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Kesalahan: ${e.message}'), // Menampilkan pesan error
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> updateEmail() async {
    // Fungsi untuk memperbarui email
    if (user != null) {
      try {
        await user?.updateEmail(emailController.text); // Memperbarui email user
        await sendVerificationEmail();  // Kirim email verifikasi setelah memperbarui email
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email telah diperbarui. Verifikasi email Anda untuk konfirmasi.'), // Menampilkan pesan sukses
          backgroundColor: Colors.green,
        ));
        setState(() {
          isEditingEmail = false; // Menutup mode edit email
        });
      } on FirebaseAuthException catch (e) {
        // Menangkap error dari Firebase Authentication
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Kesalahan: ${e.message}'), // Menampilkan pesan error
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fungsi build untuk membangun antarmuka pengguna
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 45.0, left: 20, right: 20),
                  height: MediaQuery.of(context).size.height / 4.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 105.0)), // Desain dekoratif untuk bagian atas halaman
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6.5),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "images/logo.jpeg", // Gambar logo
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            buildProfileInfo("Email", emailController, Icons.email), // Menampilkan informasi email dengan opsi edit
            SizedBox(height: 20.0),
            buildActionContainer("Hapus Akun", Icons.delete, deleteAccount), // Tombol untuk menghapus akun
            SizedBox(height: 20.0),
            buildActionContainer("Keluar", Icons.logout, logout), // Tombol untuk keluar
          ],
        ),
      ),
    );
  }

  Widget buildProfileInfo(String label, TextEditingController controller, IconData icon) {
    // Widget untuk menampilkan dan mengedit informasi profil
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 20.0),
              Expanded(
                child: isEditingEmail
                    ? TextFormField(
                        controller: controller, // TextField untuk mengedit email
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        controller.text, // Menampilkan email
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              IconButton(
                icon: Icon(isEditingEmail ? Icons.check : Icons.edit, color: Colors.black), // Tombol edit atau cek
                onPressed: () {
                  if (isEditingEmail) {
                    updateEmail(); // Memperbarui email jika dalam mode edit
                  } else {
                    setState(() {
                      isEditingEmail = true; // Masuk ke mode edit
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionContainer(String label, IconData icon, Function() onTap) {
    // Widget untuk menampilkan aksi (hapus akun, logout)
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: InkWell(
          onTap: onTap, // Aksi yang akan dijalankan ketika diklik
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.black),
                SizedBox(width: 20.0),
                Expanded(
                  child: Text(
                    label, // Label aksi (Hapus Akun, Keluar)
                    style: TextStyle(
                      color: const Color.fromARGB(255, 41, 31, 31),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
