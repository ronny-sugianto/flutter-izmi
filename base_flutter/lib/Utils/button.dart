import 'package:flutter/material.dart';

class Tombol extends StatelessWidget {
  final Function callback;
  final String title;

  final double shadow;
  final MaterialColor color;
  final MaterialColor textColor;
  final FontWeight textType;
  Tombol(
      {this.title,
      this.color,
      this.shadow,
      this.callback,
      this.textColor,
      this.textType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: callback,
        color: color ?? Color(0xFF168afd),
        elevation: shadow ?? 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: textType ?? FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
