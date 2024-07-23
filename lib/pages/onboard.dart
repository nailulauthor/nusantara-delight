import 'package:flutter/material.dart';
import 'package:nusantara_delight/pages/signup.dart';
import 'package:nusantara_delight/widget/content_model.dart';
import 'package:nusantara_delight/widget/widget_support.dart';

// Ini adalah widget utama untuk layar onboarding.
class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

// State untuk widget Onboard.
class _OnboardState extends State<Onboard> {
  int currentIndex = 0; // Menyimpan indeks halaman saat ini.
  late PageController _controller; // Controller untuk PageView.

  @override
  void initState() {
    // Menginisialisasi PageController dengan halaman awal diatur ke 0.
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // Membuang PageController ketika widget dihapus.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tata letak utama untuk layar.
      body: Column(
        children: [
          // Expanded widget untuk menampung PageView.
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                // Mengubah currentIndex ketika halaman berubah.
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                // Membuat setiap halaman dari PageView.
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Menampilkan gambar dari konten onboarding.
                        Image.asset(
                          contents[i].image,
                          height: 450,
                          width: MediaQuery.of(context).size.width / 1.5,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        // Menampilkan judul dari konten onboarding.
                        Text(
                          contents[i].title,
                          style: AppWidget.boldTextFieldStyle(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // Menampilkan deskripsi dari konten onboarding.
                        Text(
                          contents[i].description,
                          textAlign: TextAlign.center,
                          style: AppWidget.LightTextFeildStyle(),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          // Baris untuk menampung indikator titik.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
          // GestureDetector untuk tombol yang mengarahkan ke halaman berikutnya atau halaman signup.
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                // Mengarahkan ke halaman signup jika berada di halaman onboarding terakhir.
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              } else {
                // Berpindah ke halaman berikutnya di PageView.
                _controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }
            },
            child: Container(
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFff5c30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  // Mengubah teks tombol berdasarkan halaman saat ini.
                  currentIndex == contents.length - 1?
                  'Mulai':'Selanjutnya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat titik untuk indikator titik.
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: currentIndex == index ? Color(0xFFff5c30) : Colors.black38,
      ),
    );
  }
}
