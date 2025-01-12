import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:get/get.dart'; // Import GetX untuk manajemen rute
import 'app/controllers/auth_controller.dart'; // Impor AuthController
import 'app/routes/app_pages.dart'; // Impor AppPages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController()); // Daftarkan AuthController
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KORA MENU',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME, // Set initial route
      getPages: AppPages.routes, // Gunakan rute yang sudah didefinisikan
    );
  }
}
