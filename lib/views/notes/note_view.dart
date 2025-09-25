import 'package:aplikasi_5simia1_mobile3/views/login_view.dart';
import 'package:aplikasi_5simia1_mobile3/views/notes/create_note_view.dart';
import 'package:flutter/material.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Notes App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
                // Hapus semua route sebelumnya
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNoteView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          children: [
            // textfield pencarian
            TextFormField(
              decoration: InputDecoration(
                hintText: "Cari Note Disini,",
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.grey.shade200,
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
