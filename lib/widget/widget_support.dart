import 'package:flutter/material.dart';

class AppWidget {
  // Mendefinisikan gaya teks untuk field dengan teks tebal
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
      color: Colors.black, // Warna teks hitam
      fontSize: 18.0, // Ukuran font 18.0
      fontWeight: FontWeight.bold, // Ketebalan font bold
      fontFamily: 'Poppins' // Font yang digunakan adalah 'Poppins'
    );
  }

  // Mendefinisikan gaya teks untuk field dengan teks ringan
  static TextStyle LightTextFeildStyle() {
    return TextStyle(
      color: Colors.black54, // Warna teks hitam dengan transparansi 54%
      fontSize: 13.0, // Ukuran font 13.0
      fontWeight: FontWeight.w500, // Ketebalan font medium (500)
      fontFamily: 'Poppins' // Font yang digunakan adalah 'Poppins'
    );
  }

  // Mendefinisikan gaya teks untuk field dengan teks semi-tebal
  static TextStyle semiBooldTextFeildStyle() {
    return TextStyle(
      color: Colors.black, // Warna teks hitam
      fontSize: 15.0, // Ukuran font 15.0
      fontWeight: FontWeight.w500, // Ketebalan font medium (500)
      fontFamily: 'Poppins' // Font yang digunakan adalah 'Poppins'
    );
  }
}
