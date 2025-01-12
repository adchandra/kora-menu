import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ListViewPage({super.key});

  // Fungsi untuk mengambil data menu dari Firestore
  Stream<List<Menu>> getMenuList() {
    return _firestore
        .collection('menu') // Nama koleksi di Firestore
        .snapshots() // Mendapatkan stream data secara langsung
        .map((snapshot) {
      // Mengubah data snapshot menjadi list menu
      return snapshot.docs.map((doc) {
        return Menu(
          namaMenu: doc['namaMenu'], // Ambil field 'namaMenu'
          harga: doc['harga'], // Ambil field 'harga'
          fotoUrl: doc['fotoUrl'], // Ambil field 'fotoUrl'
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<List<Menu>>(
        stream: getMenuList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No menu items available.'));
          }

          final menuList = snapshot.data!;

          return ListView.builder(
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              final menu = menuList[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.red.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.red.shade200, width: 2),
                ),
                child: Container(
                  height: 150, // Tinggi card
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Melengkungkan gambar
                        child: menu.fotoUrl != null
                            ? Image.network(
                                menu.fotoUrl!,
                                width: 120, // Lebar gambar
                                height: 120, // Tinggi gambar
                                fit: BoxFit.cover, // Membuat gambar sesuai
                              )
                            : const Icon(
                                Icons.fastfood,
                                color: Colors.red,
                                size: 100,
                              ),
                      ),
                      const SizedBox(width: 15), // Memberi jarak antara gambar dan teks
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              menu.namaMenu,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 5), // Memberi jarak antara teks
                            Text(
                              'Rp ${menu.harga}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Menu {
  final String namaMenu;
  final int harga;
  final String? fotoUrl; // Tambahkan field untuk foto URL

  Menu({
    required this.namaMenu,
    required this.harga,
    this.fotoUrl, // Field opsional jika URL tidak ada
  });
}
