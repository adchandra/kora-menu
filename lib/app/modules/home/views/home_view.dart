import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart'; // Impor AuthController
import 'package:myapp/app/routes/app_pages.dart'; // Impor AppPages

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KORA MENU'),
        
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Arahkan ke halaman Home jika perlu
              Get.toNamed(Routes.HOME);
            },
          ),
          ListTile(
            title: Text('Menu List'),
            onTap: () {
              // Arahkan ke halaman List jika perlu
              Get.toNamed(Routes.LIST);
            },
          ),
          ListTile(
            title: Text('Contact'),
            onTap: () {
              // Arahkan ke halaman Contact jika perlu
              Get.toNamed(Routes.CONTACT);
            },
          ),
          ListTile(
            title: Text('Admin'),
            onTap: () {
              // Arahkan ke halaman Admin, login diperlukan
              Get.toNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
