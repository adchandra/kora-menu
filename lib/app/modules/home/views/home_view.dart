import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Impor AuthController
import 'package:myapp/app/routes/app_pages.dart'; // Impor AppPages

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KORA MENU', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Slogan
            const Text(
              'Temukan Rasa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Text(
              'Dekatkan Selera',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20), // Jarak antara slogan dan logo

            // Logo dari URL
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[200],
              backgroundImage: const NetworkImage(
                'https://drive.google.com/uc?export=view&id=12Lg2JXcz6fcWEjHMFn0POYrjTo8g9sLp',
              ),
            ),
            const SizedBox(height: 30), // Jarak antara logo dan navigasi

            // Navigasi menu
            Column(
              children: [
                _buildMenuButton('Menu list', Routes.LIST),
                _buildMenuButton('Contact', Routes.CONTACT),
                _buildMenuButton('Admin', Routes.LOGIN),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun tombol navigasi dengan ukuran seragam
  Widget _buildMenuButton(String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: 200, // Lebar tombol seragam
        height: 50, // Tinggi tombol seragam
        child: ElevatedButton(
          onPressed: () => Get.toNamed(route),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Warna tombol
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Sudut tombol melengkung
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Warna teks tombol
            ),
          ),
        ),
      ),
    );
  }
}
