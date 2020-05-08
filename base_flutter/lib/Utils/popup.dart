import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Popup {
  Success(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Berhasil'),
            contentPadding: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            children: <Widget>[
              Divider(),
              Text(
                'Data Product Berhasil Ditambahkan !',
                style: TextStyle(fontSize: 18),
              ),
              RaisedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
