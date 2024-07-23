// Import paket-paket yang diperlukan
import 'package:flutter/material.dart'; // Paket utama Flutter untuk membangun UI
import 'package:provider/provider.dart'; // Paket provider untuk state management
import 'cart_provider.dart'; // Import provider untuk keranjang belanja
import 'package:nusantara_delight/widget/widget_support.dart'; // Import widget support untuk gaya

// Widget Stateful untuk halaman Order
class Order extends StatefulWidget {
  const Order({super.key}); // Konstruktor dengan parameter key opsional

  @override
  State<Order> createState() => _OrderState(); // Membuat state untuk widget ini
}

// State class untuk widget Order
class _OrderState extends State<Order> {
  String _selectedOrderPlace = 'dine-in'; // Nilai default untuk tempat pesanan

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context); // Mendapatkan instance CartProvider dari context

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang', style: AppWidget.boldTextFieldStyle()), // Judul halaman dengan gaya dari widget support
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Colors.black), // Warna ikon kembali
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Padding untuk container utama
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length, // Jumlah item dalam keranjang
                itemBuilder: (context, index) {
                  final item = cart.items[index]; // Mendapatkan item dari keranjang
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Material(
                      elevation: 5.0, // Efek bayangan pada material
                      borderRadius: BorderRadius.circular(10), // Sudut membulat
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)), // Sudut membulat
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Gambar makanan dalam item
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8), // Sudut membulat pada gambar
                              child: Image.asset(
                                item.food.imageUrl,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.food.name,
                                    style: AppWidget.semiBooldTextFeildStyle(), // Gaya teks nama makanan dari widget support
                                  ),
                                  Text(
                                    '${item.food.price}',
                                    style: AppWidget.LightTextFeildStyle(), // Gaya teks harga makanan dari widget support
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                // Tombol untuk mengurangi jumlah item
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      cart.updateItemQuantity(item.food, item.quantity - 1); // Mengurangi jumlah item
                                    }
                                  },
                                ),
                                Text('${item.quantity}', style: AppWidget.semiBooldTextFeildStyle()), // Menampilkan jumlah item
                                // Tombol untuk menambah jumlah item
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    cart.updateItemQuantity(item.food, item.quantity + 1); // Menambah jumlah item
                                  },
                                ),
                              ],
                            ),
                            // Tombol untuk menghapus item dari keranjang
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                cart.removeItem(item.food); // Menghapus item dari keranjang
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(), // Garis pembatas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Harga', style: AppWidget.semiBooldTextFeildStyle()), // Label total harga
                  Text('Rp. ${cart.totalPrice}', style: AppWidget.semiBooldTextFeildStyle()), // Total harga dari keranjang
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Dropdown untuk memilih tempat pesanan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                value: _selectedOrderPlace,
                items: <String>['dine-in', 'take-away', 'delivery'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: AppWidget.semiBooldTextFeildStyle()), // Gaya teks dari widget support
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedOrderPlace = newValue!; // Mengubah tempat pesanan yang dipilih
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            // Tombol untuk memesan
            GestureDetector(
              onTap: () async {
                final currentDate = DateTime.now(); // Mendapatkan tanggal dan waktu saat ini
                try {
                  for (var item in cart.items) {
                    item.orderPlace = _selectedOrderPlace; // Menetapkan tempat pesanan pada setiap item
                    item.date = currentDate; // Menetapkan tanggal pesanan pada setiap item
                  }
                  await cart.placeOrder(); // Memanggil fungsi untuk membuat pesanan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pesanan berhasil dibuat!')), // Menampilkan snackbar sukses
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal membuat pesanan.')), // Menampilkan snackbar gagal
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10), // Sudut membulat pada tombol
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Text(
                    'Pesan Sekarang',
                    style: const TextStyle(
                      color: Colors.white, // Warna teks putih
                      fontSize: 18.0, // Ukuran font
                      fontWeight: FontWeight.bold, // Ketebalan font
                    ),
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
