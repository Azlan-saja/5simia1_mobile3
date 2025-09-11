import 'package:flutter/material.dart';

class LoginController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  final formKey = GlobalKey<FormState>();

  tampilkanPassword() {
    isVisible = !isVisible;
  }

  String? cekValidasi(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong!';
    }
    return null;
  }

  prosesLogin() {
    if (formKey.currentState!.validate()) {}
  }
}
