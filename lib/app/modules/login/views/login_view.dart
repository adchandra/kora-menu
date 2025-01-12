import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/app/routes/app_pages.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon isi username dan password!")),
      );
      return;
    }

    try {
      // Query Firestore untuk mencari data berdasarkan username dan password
      final query = await firestore
          .collection('admin')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (query.docs.isNotEmpty) {
        // Jika data ditemukan, arahkan ke halaman Admin
        Get.offAllNamed(Routes.ADMIN);
      } else {
        // Jika tidak ditemukan data yang sesuai
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username atau password salah!")),
        );
      }
    } catch (e) {
      // Menangani kesalahan umum yang terjadi selama query
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.red.shade50, // Background warna cerah dengan nuansa merah
      appBar: AppBar(
        title: const Text("Admin Login"),
        backgroundColor: Colors.red.shade700, // Warna appBar merah
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Rata atas
          crossAxisAlignment: CrossAxisAlignment.center, // Rata tengah
          children: [
            // Judul halaman login yang diganti
            Text(
              "Silahkan Login Admin", // Mengganti teks
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
              textAlign: TextAlign.center, // Rata tengah
            ),
            const SizedBox(height: 40),

            // Username TextField dengan desain yang lebih menarik
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.red.shade700),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade600),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Password TextField dengan desain yang lebih menarik
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.red.shade700),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade600),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Login dengan desain dan warna keren, rata tengah
            ElevatedButton(
              onPressed: () => login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700, // Warna tombol merah
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
