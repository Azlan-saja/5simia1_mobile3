import 'package:aplikasi_5simia1_mobile3/controllers/note_controller.dart';
import 'package:aplikasi_5simia1_mobile3/models/note_model.dart';
import 'package:flutter/material.dart';

class UpdateNoteView extends StatelessWidget {
  final NoteModel note;

  const UpdateNoteView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final noteController = NoteController();
    noteController.titleController.text = note.noteTitle;
    noteController.contentController.text = note.noteContent;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text('Edit Note'),
        actions: [
          IconButton(
            onPressed: () => noteController.prosesUpdateData(
              context,
              noteId: note.noteId!,
            ),
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
