import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nusantara_delight/model/cart_item.dart';

// ApiService adalah kelas yang menyediakan layanan API
class ApiService {
  // baseUrl adalah URL dasar untuk API
  final String baseUrl = 'https://664355ef6c6a65658706a138.mockapi.io/';

  // placeOrder adalah fungsi yang digunakan untuk membuat pesanan
  Future<void> placeOrder(List<CartItem> items) async {
    // Menggabungkan baseUrl dengan endpoint '/order' untuk mendapatkan URL lengkap
    final url = Uri.parse('$baseUrl/order');

    // Mengirimkan permintaan POST ke URL tersebut dengan header dan body yang sesuai
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      // Mengubah daftar objek CartItem menjadi JSON sebelum dikirimkan
      body: jsonEncode({'items': items.map((item) => item.toJson()).toList()}),
    );

    // Mengecek apakah status kode dari response bukan 201 (Created)
    if (response.statusCode != 201) {
      // Jika bukan 201, lemparkan exception dengan pesan error dari response
      throw Exception('Gagal membuat pesanan: ${response.reasonPhrase}');
    }
  }
}
