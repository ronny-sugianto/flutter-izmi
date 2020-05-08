import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const ROUTE_URL = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Anda Sudah Login'),
      ),
    );
  }
}
