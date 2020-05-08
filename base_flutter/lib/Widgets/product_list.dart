import 'package:flutter/material.dart';
import 'package:flutterapp/Models/product_model.dart';
import 'package:flutterapp/Repositories/database.dart';

class ProductList extends StatefulWidget {
  Function showLoading;

  ProductList({Key key, this.showLoading}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products;

  getProduct() async {
    return await LocalRepository().getProduct();
  }

  Future<void> refresh() {
    return getProduct();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.showLoading(true);
    getProduct().then((result) {
      widget.showLoading(false);
      if (mounted) {
        setState(() {
          products = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: RefreshIndicator(
        onRefresh: refresh,
        child: products.toString() == '[]' || products == null
            ? Center(
                child: Text(
                  'No Product',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(products[index].name),
                      trailing: Text(products[index].price.toString()),
                    ),
                  );
                },
                itemCount: products == null ? 0 : products.length,
              ),
      ),
    );
  }
}
