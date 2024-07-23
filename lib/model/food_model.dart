// Mendefinisikan kelas Food yang merepresentasikan data makanan
class Food {
  // Properti untuk menyimpan ID makanan
  final String id;
  // Properti untuk menyimpan nama makanan
  final String name;
  // Properti untuk menyimpan deskripsi makanan
  final String description;
  // Properti untuk menyimpan URL gambar makanan
  final String imageUrl;
  // Properti untuk menyimpan harga makanan
  final double price;
  // Properti untuk menyimpan daftar bahan makanan
  final List<String> ingredients;

  // Konstruktor Food dengan parameter yang diwajibkan
  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.ingredients,
  });
}
