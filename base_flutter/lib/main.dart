import 'package:flutter/material.dart';
import 'package:flutterapp/Views/home_view.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeView.ROUTE_URL,
      routes: {HomeView.ROUTE_URL: (_) => HomeView()},
    );
  }
}
