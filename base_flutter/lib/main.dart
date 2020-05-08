import 'package:flutter/material.dart';
import 'package:flutterapp/Models/product_model.dart';
import 'package:flutterapp/Utils/button.dart';
import 'package:flutterapp/Repositories/database.dart';
import 'package:flutterapp/Widgets/product_form.dart';
import 'package:flutterapp/Widgets/product_list.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  void refresh() {
    setState(() {});
    print('callback');
  }

  _onLoading(show) async {
    if (show) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                    ],
                  ))
            ],
          );
        },
      );
    } else {
      Navigator.pop(context);
    }
  }

  deleteDB() async {
    await LocalRepository().deleteDB();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter DB'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Tombol(
                    title: 'Migrate',
                    callback: () async {
                      await LocalRepository().MigrateDB();
                      setState(() {});
                    },
                  ),
                  Tombol(
                    title: 'Delete DB',
                    callback: deleteDB,
                  ),
                ],
              ),
              ProductForm(
                mainCallBack: refresh,
              ),
              ProductList(
                key: UniqueKey(),
                showLoading: _onLoading,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
