import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/routes/app_pages.dart'; // Impor AuthController

class AdminView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    // Memeriksa apakah user sudah login
    if (!authController.isLoggedIn.value) {
      // Jika belum login, arahkan ke halaman login
      Get.offAllNamed(Routes.LOGIN);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Logout jika sudah login
              final authController = Get.find<AuthController>();
              authController.logout();
            },
          ),
        ],
        ),
      body: Center(
        child: Text(
          'Welcome to Admin Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
