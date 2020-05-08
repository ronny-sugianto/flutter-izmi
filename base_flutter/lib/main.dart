import 'package:flutter/material.dart';
import 'package:flutterapp/Views/home_view.dart';
import 'package:flutterapp/Views/login_view.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginView.ROUTE_URL,
      routes: {
        LoginView.ROUTE_URL: (_) => LoginView(),
        HomeView.ROUTE_URL: (_) => HomeView()
      },
    );
  }
}
