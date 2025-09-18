import 'package:aplikasi_5simia1_mobile3/database/database_helper.dart';
import 'package:aplikasi_5simia1_mobile3/models/user_model.dart';
import 'package:aplikasi_5simia1_mobile3/views/note_view.dart';
import 'package:flutter/material.dart';

class LoginController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  tampilkanPassword() {
    isVisible = !isVisible;
  }

  String? cekValidasi(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong!';
    }
    return null;
  }

  prosesLogin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      var response = await db.login(
        UserModel(
          userName: usernameController.text,
          userPassword: passwordController.text,
        ),
      );

      if (!context.mounted) return;

      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login success'),
            backgroundColor: Colors.teal[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoteView(),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed! Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' Login failed! Please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
