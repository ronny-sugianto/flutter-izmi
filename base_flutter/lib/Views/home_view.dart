import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  static const ROUTE_URL = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var bookName = TextEditingController();
  List listBook;
  bool isLoading = false;

  Future<void> getData() async {
    print(bookName.text.toString());
    var url = 'https://www.googleapis.com/books/v1/volumes?q=${bookName.text}';
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(milliseconds: 500), () {});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var items = jsonResponse['items'];
      isLoading = false;
      setState(() {
        listBook = items;
      });
      print(items.runtimeType);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fetch'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: TextField(
                        controller: bookName,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Search Book...'),
                      )),
                  Expanded(
                    flex: 2,
                    child: RaisedButton(
                      elevation: 5,
                      onPressed: getData,
                      child: Text('Search'),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                color: Colors.blueGrey,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : listBook != null || listBook.toString() == '[]'
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: Image.network(listBook[index]
                                                  ['volumeInfo']['imageLinks']
                                              ['thumbnail']
                                          .isEmpty
                                      ? 'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png'
                                      : listBook[index]['volumeInfo']
                                          ['imageLinks']['thumbnail']),
                                  title: Text(listBook[index]['volumeInfo']
                                          ['title'] ??
                                      'null'),
                                  subtitle: Text(listBook[index]['volumeInfo']
                                          ['publisher'] ??
                                      'null'),
                                ),
                              );
                            },
                            itemCount: listBook == null ? 0 : listBook.length,
                          )
                        : Center(
                            child: Text(
                              'No Data Found',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
