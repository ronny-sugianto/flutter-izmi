import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  final String title;
  final Function validator;
  final Function onSaved;

  EditText({this.title, this.validator, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
