import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  final String title;
  final bool secret;
  final Function callback;
  final TextEditingController controller;

  EditText({this.title, this.secret, this.controller, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onTap: callback,
        obscureText: secret ?? false,
      ),
    );
  }
}
