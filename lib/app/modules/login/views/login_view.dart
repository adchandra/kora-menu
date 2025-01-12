import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    return Scaffold(
      backgroundColor:
          Colors.red.shade50, // Background warna cerah dengan nuansa merah
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
        backgroundColor: Colors.red.shade700, // AppBar warna merah
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 50), // Spacing di atas
            Center(
              child: Text(
                'Silahkan Login Admin', // Judul
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40), // Spacing di bawah judul

            // Username TextField dengan desain lebih menarik
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.red.shade700),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade600),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.red.shade700),
              ),
            ),
            SizedBox(height: 20), // Spacing di antara TextField

            // Password TextField dengan desain lebih menarik
            TextField(
              controller: controller.cPass,
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
                prefixIcon: Icon(Icons.lock, color: Colors.red.shade700),
              ),
            ),
            SizedBox(height: 30), // Spacing di bawah password field

            // Tombol Login dengan desain lebih menarik
            ElevatedButton(
              onPressed: () =>
                  cAuth.login(controller.cEmail.text, controller.cPass.text),
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
            SizedBox(height: 10), // Spacing di bawah tombol
          ],
        ),
      ),
    );
  }
}
