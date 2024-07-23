// Import paket-paket yang diperlukan
import 'package:flutter/material.dart'; // Paket utama Flutter untuk membangun UI
import 'package:nusantara_delight/pages/details.dart'; // Import halaman Detail
import 'package:nusantara_delight/pages/order.dart'; // Import halaman Order
import 'package:nusantara_delight/widget/widget_support.dart'; // Import widget support untuk gaya
import 'package:iconly/iconly.dart'; // Paket untuk ikon
import 'package:nusantara_delight/model/food_model.dart'; // Import model Food

// Widget Stateful untuk halaman Home
class Home extends StatefulWidget {
  const Home({super.key}); // Konstruktor dengan parameter key opsional

  @override
  State<Home> createState() => _HomeState(); // Membuat state untuk widget ini
}

// State class untuk widget Home
class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController(); // Kontroler untuk input pencarian
  String selectedCategory = ''; // Variabel untuk menyimpan kategori yang dipilih

  // Daftar makanan yang ditampilkan di halaman utama
  final List<Food> foods = [
    Food(
      id: '1',
      name: "Nasi Goreng",
      description: "Khas Magelang",
      imageUrl: "images/magelangan.jpeg",
      price: 15000,
      ingredients: ["Nasi", "Telur", "Kecap", "Bawang Merah", "Bawang Putih"],
    ),
    Food(
      id: '2',
      name: "Rendang",
      description: "Khas MinangKabau",
      imageUrl: "images/rendang2.jpg",
      price: 15000,
      ingredients: [
        "Daging Sapi",
        "Kelapa",
        "Cabe",
        "Bawang Merah",
        "Bawang Putih"
      ],
    ),
    Food(
      id: '3',
      name: "Bakso",
      description: "Khas Malang",
      imageUrl: "images/bakso.png",
      price: 10000,
      ingredients: [
        "Daging Sapi",
        "Tepung Tapioka",
        "Bawang Putih",
        "Garam",
        "Merica"
      ],
    ),
    Food(
      id: '4',
      name: "Sate",
      description: "Khas Madura",
      imageUrl: "images/sate.png",
      price: 12000,
      ingredients: [
        "Daging Ayam",
        "Kecap",
        "Bawang Merah",
        "Bawang Putih",
        "Cabe"
      ],
    ),
    // Tambahkan item makanan lainnya di sini
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged); // Menambahkan listener untuk kontroler pencarian
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged); // Menghapus listener saat dispose
    searchController.dispose(); // Membebaskan kontroler
    super.dispose();
  }

  // Fungsi untuk memfilter daftar makanan berdasarkan pencarian
  void _onSearchChanged() {
    setState(() {});
  }

  // Fungsi untuk mendapatkan daftar makanan yang sudah difilter
  List<Food> _getFilteredFoods() {
    List<Food> filteredFoods = foods;
    if (selectedCategory.isNotEmpty) {
      filteredFoods =
          foods.where((food) => food.name == selectedCategory).toList(); // Memfilter makanan berdasarkan kategori yang dipilih
    }
    if (searchController.text.isNotEmpty) {
      filteredFoods = filteredFoods
          .where((food) => food.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase())) // Memfilter makanan berdasarkan input pencarian
          .toList();
    }
    return filteredFoods;
  }

  // Fungsi untuk memilih kategori makanan
  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0), // Margin untuk kontainer utama
        child: Column(
          children: [
            // Baris pertama dengan teks "Nusantara Delight" dan ikon keranjang belanja
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nusantara Delight",
                  style: AppWidget.boldTextFieldStyle(), // Gaya teks dari widget support
                ),
                // Ikon keranjang belanja
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Order()), // Navigasi ke halaman Order
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(3.0), // Padding untuk kontainer ikon
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0), // Menambahkan ruang kosong vertikal
            // Search bar untuk pencarian makanan
            TextField(
              controller: searchController, // Kontroler untuk input pencarian
              decoration: InputDecoration(
                hintText: 'Search', // Teks petunjuk di search bar
                prefixIcon: Icon(IconlyLight.search), // Ikon pencarian
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0), // Radius border membulat
                ),
                filled: true,
                fillColor: Colors.white, // Warna latar belakang search bar
              ),
            ),
            SizedBox(height: 20.0), // Menambahkan ruang kosong vertikal
            showItem(), // Menampilkan kategori makanan
            SizedBox(height: 20.0), // Menambahkan ruang kosong vertikal
            // Daftar makanan yang difilter
            Expanded(
              child: ListView.builder(
                itemCount: _getFilteredFoods().length, // Jumlah item yang ditampilkan
                itemBuilder: (context, index) {
                  final food = _getFilteredFoods()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(food: food)), // Navigasi ke halaman Detail
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0), // Margin untuk setiap item
                      child: Material(
                        elevation: 5.0, // Efek bayangan untuk kontainer
                        borderRadius: BorderRadius.circular(20), // Sudut membulat
                        child: Container(
                          padding: EdgeInsets.all(5), // Padding dalam kontainer
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                food.imageUrl, // Gambar makanan
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 20.0), // Menambahkan ruang kosong horizontal
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(food.name,
                                        style: AppWidget
                                            .semiBooldTextFeildStyle()), // Nama makanan
                                    SizedBox(height: 5.0), // Menambahkan ruang kosong vertikal
                                    Text(food.description,
                                        style: AppWidget.LightTextFeildStyle()), // Deskripsi makanan
                                    SizedBox(height: 5.0), // Menambahkan ruang kosong vertikal
                                    Text('Rp. ${food.price}',
                                        style: AppWidget
                                            .semiBooldTextFeildStyle()), // Harga makanan
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan kategori makanan
  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyelaraskan kategori di antara
      children: [
        GestureDetector(
          onTap: () {
            _selectCategory('Nasi Goreng'); // Memilih kategori 'Nasi Goreng'
          },
          child: Material(
            elevation: 5.0, // Efek bayangan untuk kontainer kategori
            borderRadius: BorderRadius.circular(10), // Sudut membulat
            child: Container(
              decoration: BoxDecoration(
                color: selectedCategory == 'Nasi Goreng'
                    ? Colors.black
                    : Colors.white, // Warna berdasarkan kategori yang dipilih
                borderRadius: BorderRadius.circular(10), // Sudut membulat
              ),
              padding: EdgeInsets.all(8), // Padding dalam kontainer
              child: Image.asset(
                'images/nasi-goreng.png', // Gambar kategori 'Nasi Goreng'
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: selectedCategory == 'Nasi Goreng'
                    ? Colors.white
                    : Colors.black, // Warna ikon berdasarkan kategori yang dipilih
              ),
            ),
          ),
        ),
        // Kategori lainnya ('Rendang', 'Bakso', 'Sate') diulang dengan cara yang sama
        GestureDetector(
          onTap: () {
            _selectCategory('Rendang'); // Memilih kategori 'Rendang'
          },
          child: Material(
            elevation: 5.0, // Efek bayangan untuk kontainer kategori
            borderRadius: BorderRadius.circular(10), // Sudut membulat
            child: Container(
              decoration: BoxDecoration(
                color:
                    selectedCategory == 'Rendang' ? Colors.black : Colors.white, // Warna berdasarkan kategori yang dipilih
                borderRadius: BorderRadius.circular(10), // Sudut membulat
              ),
              padding: EdgeInsets.all(8), // Padding dalam kontainer
              child: Image.asset(
                'images/rendang.png', // Gambar kategori 'Rendang'
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color:
                    selectedCategory == 'Rendang' ? Colors.white : Colors.black, // Warna ikon berdasarkan kategori yang dipilih
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _selectCategory('Bakso'); // Memilih kategori 'Bakso'
          },
          child: Material(
            elevation: 5.0, // Efek bayangan untuk kontainer kategori
            borderRadius: BorderRadius.circular(10), // Sudut membulat
            child: Container(
              decoration: BoxDecoration(
                color:
                    selectedCategory == 'Bakso' ? Colors.black : Colors.white, // Warna berdasarkan kategori yang dipilih
                borderRadius: BorderRadius.circular(10), // Sudut membulat
              ),
              padding: EdgeInsets.all(8), // Padding dalam kontainer
              child: Image.asset(
                'images/bakso.png', // Gambar kategori 'Bakso'
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color:
                    selectedCategory == 'Bakso' ? Colors.white : Colors.black, // Warna ikon berdasarkan kategori yang dipilih
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _selectCategory('Sate'); // Memilih kategori 'Sate'
          },
          child: Material(
            elevation: 5.0, // Efek bayangan untuk kontainer kategori
            borderRadius: BorderRadius.circular(10), // Sudut membulat
            child: Container(
              decoration: BoxDecoration(
                color: selectedCategory == 'Sate' ? Colors.black : Colors.white, // Warna berdasarkan kategori yang dipilih
                borderRadius: BorderRadius.circular(10), // Sudut membulat
              ),
              padding: EdgeInsets.all(8), // Padding dalam kontainer
              child: Image.asset(
                'images/sate.png', // Gambar kategori 'Sate'
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: selectedCategory == 'Sate' ? Colors.white : Colors.black, // Warna ikon berdasarkan kategori yang dipilih
              ),
            ),
          ),
        ),
      ],
    );
  }
}
