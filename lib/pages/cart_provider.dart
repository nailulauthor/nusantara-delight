import 'package:flutter/material.dart';
import 'package:nusantara_delight/model/cart_item.dart';
import 'package:nusantara_delight/model/food_model.dart';
import 'package:nusantara_delight/api/api_service.dart';

// Mendefinisikan kelas CartProvider yang mengelola state dari keranjang belanja
class CartProvider extends ChangeNotifier {
  // Menyimpan daftar item dalam keranjang belanja
  List<CartItem> _items = [];

  // Getter untuk mendapatkan daftar item dalam keranjang belanja
  List<CartItem> get items => _items;

  // Getter untuk menghitung total harga semua item dalam keranjang belanja
  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.food.price * item.quantity);

  // Fungsi untuk menambahkan item ke keranjang belanja
  void addItem(Food food, int quantity) {
    // Mencari indeks item dalam keranjang yang memiliki ID yang sama dengan item yang ingin ditambahkan
    final index = _items.indexWhere((item) => item.food.id == food.id);
    if (index != -1) {
      // Jika item sudah ada dalam keranjang, tambahkan kuantitas item tersebut
      _items[index].quantity += quantity;
    } else {
      // Jika item belum ada dalam keranjang, tambahkan item baru ke dalam daftar
      _items.add(CartItem(food: food, quantity: quantity, orderPlace: 'default', date: DateTime.now()));
    }
    // Memberitahu pendengar bahwa ada perubahan pada state
    notifyListeners();
  }

  // Fungsi untuk memperbarui kuantitas item dalam keranjang belanja
  void updateItemQuantity(Food food, int quantity) {
    // Mencari indeks item dalam keranjang yang memiliki ID yang sama dengan item yang ingin diperbarui
    final index = _items.indexWhere((item) => item.food.id == food.id);
    if (index != -1) {
      // Jika item ditemukan, perbarui kuantitasnya
      _items[index].quantity = quantity;
      // Memberitahu pendengar bahwa ada perubahan pada state
      notifyListeners();
    }
  }

  // Fungsi untuk menghapus item dari keranjang belanja
  void removeItem(Food food) {
    // Menghapus item yang memiliki ID yang sama dari keranjang
    _items.removeWhere((item) => item.food.id == food.id);
    // Memberitahu pendengar bahwa ada perubahan pada state
    notifyListeners();
  }

  // Fungsi untuk membuat pesanan dengan mengirim data keranjang ke server
  Future<void> placeOrder() async {
    // Membuat instance dari ApiService untuk mengakses API
    final apiService = ApiService();
    try {
      // Memanggil fungsi placeOrder dari ApiService untuk mengirim data pesanan
      await apiService.placeOrder(_items);
      // Jika berhasil, bersihkan keranjang belanja
      _items.clear();
      // Memberitahu pendengar bahwa ada perubahan pada state
      notifyListeners();
    } catch (e) {
      // Jika terjadi kesalahan, lemparkan exception dengan pesan error
      throw Exception('Gagal membuat pesanan: $e');
    }
  }
}
