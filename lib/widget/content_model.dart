// Mendefinisikan kelas UnboardingContent yang menyimpan informasi tentang konten unboarding
class UnboardingContent {
  String image;       // URL atau nama file gambar yang terkait dengan konten
  String title;       // Judul untuk konten unboarding
  String description; // Deskripsi untuk konten unboarding

  // Konstruktor untuk inisialisasi nilai-nilai dari gambar, judul, dan deskripsi
  UnboardingContent({
    required this.description, // Parameter deskripsi wajib
    required this.title,       // Parameter judul wajib
    required this.image        // Parameter gambar wajib
  });
}

// Daftar konten unboarding yang akan ditampilkan
List<UnboardingContent> contents = [
  // Konten pertama dengan deskripsi, judul, dan gambar
  UnboardingContent(
      description: "Pilih Makanan yang kalian suka", // Deskripsi konten
      title: 'Pilih Menu Terbaik Kami', // Judul konten
      image: 'images/logo2.jpg' // Gambar yang ditampilkan untuk konten
  ),
  // Konten kedua dengan deskripsi, judul, dan gambar
  UnboardingContent(
      description: "Pilih Makanan yang kalian suka", // Deskripsi konten
      title: 'Pilih Menu Terbaik Kami', // Judul konten
      image: 'images/logo3.png' // Gambar yang ditampilkan untuk konten
  ),
];
