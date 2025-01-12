import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Jika menggunakan Firebase
import 'package:myapp/app/routes/app_pages.dart'; // Sesuaikan dengan rute aplikasi

class AuthController extends GetxController {
  // Status login
  var isLoggedIn = false.obs;

  // Login dengan email dan password
  void login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoggedIn.value = true;
      Get.offAllNamed(Routes.ADMIN); // Arahkan ke halaman Admin setelah login berhasil
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: "Wrong password provided for that user.",
        );
      }
    }
  }

  // Logout
  void logout() async {
    await FirebaseAuth.instance.signOut();
    isLoggedIn.value = false;
    Get.offAllNamed(Routes.LOGIN); // Arahkan kembali ke halaman login setelah logout
  }
}
