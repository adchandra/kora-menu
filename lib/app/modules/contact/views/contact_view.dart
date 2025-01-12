import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Background diubah menjadi putih
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            const Color.fromARGB(255, 191, 12, 12), // AppBar dengan warna pink
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Korakitchen Contact',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          // Tombol kembali ke home
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed(Routes.HOME); // Navigasi ke HOME
          },
        ),
      ),
      body: Column(
        children: [
          // Bagian atas dengan logo dan nama brand
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 191, 12, 12),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color.fromARGB(255, 255, 0, 25),
                  child: Image.asset(
                    'assets/logo.png', // Ganti dengan path logo Korakitchen
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Korakitchen',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Temukan Rasa, Dekatkan Selera',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tulisan di bawah "Contact Us" dengan border
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Anda dapat menghubungi kami melalui platform berikut:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Daftar kontak dengan border
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _ContactTile(
                  iconName: 'whatsapp',
                  label: '+6281234567890',
                  color: Colors.green,
                  onPressed: () {
                    _handleContactAction('whatsapp', '+6281234567890');
                  },
                ),
                _ContactTile(
                  iconName: 'instagram',
                  label: 'korakitchen.id',
                  color: Colors.purple,
                  onPressed: () {
                    _handleContactAction('instagram', 'korakitchen.id');
                  },
                ),
                _ContactTile(
                  iconName: 'tiktok',
                  label: 'korakitchen',
                  color: Colors.black,
                  onPressed: () {
                    _handleContactAction('tiktok', 'korakitchen');
                  },
                ),
                _ContactTile(
                  iconName: 'utensils',
                  label: 'korakitchen.com',
                  color: Colors.blue,
                  onPressed: () {
                    _handleContactAction('website', 'korakitchen.com');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleContactAction(String iconName, String label) async {
    String url;

    switch (iconName) {
      case 'whatsapp':
        url = 'https://wa.me/$label'; // Format URL WhatsApp
        break;
      case 'instagram':
        url =
            'https://instagram.com/korakitchen.id$label'; // Format URL Instagram yang benar
        break;
      case 'tiktok':
        url = 'https://tiktok.com/@$label'; // Format URL TikTok
        break;
      case 'website':
        url = 'https://$label'; // Format URL untuk website
        break;
      default:
        url = '';
    }

    if (url.isNotEmpty) {
      Uri uri = Uri.parse(url);

      // Buka URL di browser eksternal
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Tidak dapat membuka tautan: $url',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'URL tidak valid',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class _ContactTile extends StatelessWidget {
  final String iconName;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ContactTile({
    required this.iconName,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2), // Border hitam
        borderRadius: BorderRadius.circular(12), // Radius sesuai gambar
        color: Colors.white,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(
                _getIcon(iconName), // Mendapatkan ikon yang sesuai
                color: color,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String? iconName) {
    switch (iconName) {
      case 'whatsapp':
        return FontAwesomeIcons.whatsapp;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'tiktok':
        return FontAwesomeIcons.tiktok;
      case 'utensils':
        return FontAwesomeIcons.utensils;
      default:
        return FontAwesomeIcons.questionCircle;
    }
  }
}
