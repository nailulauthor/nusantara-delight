import 'package:nusantara_delight/model/food_model.dart';

// Mendefinisikan kelas CartItem yang merepresentasikan item dalam keranjang belanja
class CartItem {
  // Properti untuk menyimpan informasi makanan, menggunakan kelas Food dari food_model.dart
  final Food food;
  // Properti untuk menyimpan jumlah item
  int quantity;
  // Properti untuk menyimpan lokasi pemesanan
  String orderPlace;
  // Properti untuk menyimpan tanggal pemesanan
  DateTime date;

  // Konstruktor CartItem dengan parameter yang diwajibkan
  CartItem({
    required this.food,
    required this.quantity,
    required this.orderPlace,
    required this.date,
  });

  // Metode untuk mengonversi objek CartItem menjadi representasi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': food.id, // Mengambil id dari objek food
      'name': food.name, // Mengambil nama dari objek food
      'description': food.description, // Mengambil deskripsi dari objek food
      'imageUrl': food.imageUrl, // Mengambil URL gambar dari objek food
      'price': food.price, // Mengambil harga dari objek food
      'quantity': quantity, // Mengambil kuantitas dari CartItem
      'orderPlace': orderPlace, // Mengambil lokasi pemesanan
      'date': date.toIso8601String(), // Mengubah tanggal ke format ISO 8601
    };
  }
}
