import 'package:aplikasi_5simia1_mobile3/controllers/note_controller.dart';
import 'package:flutter/material.dart';

class CreateNoteView extends StatelessWidget {
  const CreateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = NoteController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text('Create Note'),
        actions: [
          IconButton(
            onPressed: () => noteController.prosesCreateData(context),
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: noteController.formKey,
          child: Column(
            children: [
              // 1. Inputan TITLE
              TextFormField(
                validator: (value) => noteController.cekValidasi(value),
                controller: noteController.titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Title",
                  prefixIcon: Icon(Icons.title),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 13),
                ),
              ),
              // 2. Inputan CONTENT
              SizedBox(height: 10),
              TextFormField(
                validator: (value) => noteController.cekValidasi(value),
                controller: noteController.contentController,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Content",
                  prefixIcon: Icon(Icons.notes),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
