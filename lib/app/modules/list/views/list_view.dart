import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Katalog')),
      body: ListView.builder(
        itemCount: 10,  // Gantilah dengan jumlah data yang sesuai
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),  // Gantilah dengan data yang sesuai
            subtitle: Text('Deskripsi Item $index'),
            onTap: () {
              // Arahkan ke halaman detail jika perlu
            },
          );
        },
      ),
    );
  }
}
