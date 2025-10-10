import 'package:aplikasi_5simia1_mobile3/controllers/note_controller.dart';
import 'package:aplikasi_5simia1_mobile3/models/note_model.dart';
import 'package:aplikasi_5simia1_mobile3/views/login_view.dart';
import 'package:aplikasi_5simia1_mobile3/views/notes/create_note_view.dart';
import 'package:aplikasi_5simia1_mobile3/views/notes/update_note_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final noteController = NoteController();

  @override
  void initState() {
    super.initState();
    noteController.tampilkanData();
  }

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
            // 1. textfield pencarian
            TextFormField(
              controller: noteController.searchController,
              onChanged: (_) async {
                await noteController.tampilkanData();
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Cari Note Disini,",
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.grey.shade200,
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 13),
              ),
            ),
            // 2. TampilkanData Notes
            Expanded(
              child: FutureBuilder<List<NoteModel>>(
                future: noteController.notes,
                builder: (BuildContext context,
                    AsyncSnapshot<List<NoteModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Note Kosong"));
                  } else {
                    final items = snapshot.data!;
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.teal.shade100,
                      ),
                      itemCount: items.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final note = items[index];
                        return ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Note?'),
                                  content: const Text(
                                      'Are you sure you want to delete this note?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await noteController.prosesDeleteData(
                                          context,
                                          noteId: note.noteId!,
                                        );
                                        setState(() {});
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                          tileColor: Colors.teal.shade100,
                          textColor: Colors.teal.shade900,
                          splashColor: Colors.teal,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          title: Text(
                            note.noteTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            '${note.noteContent}\n\n${DateFormat("yMMMd").format(DateTime.parse(note.createdAt))}',
                          ),
                          onTap: () {
                            // Navigasi ke halaman lihat/update note
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateNoteView(note: note),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
