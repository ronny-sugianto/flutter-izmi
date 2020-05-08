import 'package:flutter/material.dart';
import 'package:flutterapp/Utils/button.dart';
import 'package:flutterapp/Utils/textfield.dart';
import 'package:flutterapp/Views/home_view.dart';

class LoginView extends StatefulWidget {
  static const ROUTE_URL = '/login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var userName = TextEditingController();

  var passWord = TextEditingController();

  bool errorAuth = false;

  @override
  Widget build(BuildContext context) {
    auth() async {
      if (userName.text == 'admin' && passWord.text == 'admin') {
        Future.delayed(Duration(microseconds: 500), () {
          Navigator.pushNamed(context, HomeView.ROUTE_URL);
        });
      } else {
        setState(() {
          errorAuth = true;
        });
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Login Screen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          EditText(
            title: 'Username',
            controller: userName,
            callback: () {
              setState(() {
                errorAuth = false;
              });
            },
          ),
          EditText(
            title: 'Password',
            controller: passWord,
            secret: true,
            callback: () {
              setState(() {
                errorAuth = false;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Tombol(
                title: 'Login',
                callback: auth,
              ),
            ],
          ),
          Text(
            errorAuth ? 'Email or password is not valid !' : '',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
