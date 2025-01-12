import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/routes/app_pages.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Redirect to login if not logged in
    if (!authController.isLoggedIn.value) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // Fungsi untuk mengambil data menu dari Firestore
  Stream<List<Menu>> getMenuList() {
    return _firestore
        .collection('menu')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Menu(
          id: doc.id,
          namaMenu: doc['namaMenu'],
          harga: doc['harga'],
          fotoUrl: doc['fotoUrl'],
        );
      }).toList();
    });
  }

  // Fungsi untuk menambahkan atau memperbarui menu
  Future<void> addOrUpdateMenu(Menu menu, File? imageFile) async {
    String? fotoUrl = menu.fotoUrl;

    // Jika ada file gambar baru, unggah ke Firebase Storage
    if (imageFile != null) {
      final ref = _storage.ref().child('menu_images/${menu.id ?? DateTime.now().toString()}');
      final uploadTask = await ref.putFile(imageFile);
      fotoUrl = await uploadTask.ref.getDownloadURL();
    }

    // Simpan atau perbarui data di Firestore
    final data = {
      'namaMenu': menu.namaMenu,
      'harga': menu.harga,
      'fotoUrl': fotoUrl,
    };

    if (menu.id == null) {
      await _firestore.collection('menu').add(data);
    } else {
      await _firestore.collection('menu').doc(menu.id).update(data);
    }
  }

  // Fungsi untuk menghapus menu
  Future<void> deleteMenu(String id) async {
    await _firestore.collection('menu').doc(id).delete();
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Menu'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
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
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.red.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.red.shade200, width: 1.5),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  leading: menu.fotoUrl != null
                      ? Image.network(
                          menu.fotoUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.fastfood,
                          color: Colors.red,
                          size: 50,
                        ),
                  title: Text(
                    menu.namaMenu,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: Text(
                    'Rp ${menu.harga}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red.shade700,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.red),
                        onPressed: () async {
                          File? imageFile = await pickImage();
                          showDialog(
                            context: context,
                            builder: (context) {
                              final TextEditingController nameController = TextEditingController(text: menu.namaMenu);
                              final TextEditingController priceController = TextEditingController(text: menu.harga.toString());
                              return AlertDialog(
                                title: const Text('Edit Menu'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(labelText: 'Nama Menu'),
                                    ),
                                    TextField(
                                      controller: priceController,
                                      decoration: const InputDecoration(labelText: 'Harga'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final updatedMenu = Menu(
                                        id: menu.id,
                                        namaMenu: nameController.text,
                                        harga: int.parse(priceController.text),
                                        fotoUrl: menu.fotoUrl,
                                      );
                                      await addOrUpdateMenu(updatedMenu, imageFile);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await deleteMenu(menu.id!);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () async {
          File? imageFile = await pickImage();
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController nameController = TextEditingController();
              final TextEditingController priceController = TextEditingController();
              return AlertDialog(
                title: const Text('Add Menu'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nama Menu'),
                    ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Harga'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final newMenu = Menu(
                        namaMenu: nameController.text,
                        harga: int.parse(priceController.text),
                      );
                      await addOrUpdateMenu(newMenu, imageFile);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class Menu {
  final String? id;
  final String namaMenu;
  final int harga;
  final String? fotoUrl;

  Menu({
    this.id,
    required this.namaMenu,
    required this.harga,
    this.fotoUrl,
  });
}
