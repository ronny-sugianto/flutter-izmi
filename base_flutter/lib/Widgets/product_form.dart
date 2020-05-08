import 'package:flutter/material.dart';
import 'package:flutterapp/Models/product_model.dart';
import 'package:flutterapp/Repositories/database.dart';
import 'package:flutterapp/Utils/popup.dart';
import 'package:flutterapp/Utils/textfield.dart';

class ProductForm extends StatefulWidget {
  final Function mainCallBack;

  ProductForm({this.mainCallBack});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  var _data = Product();
  var _isLoading = false;

  submitForm() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      try {
        await LocalRepository().addProduct(_data);

        widget.mainCallBack();
        Popup().Success(context);
      } catch (error) {
        print(error);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _validateEmpty(String value) {
    if (value.length == 0) {
      return 'Please input the information';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  EditText(
                    title: 'Name',
                    validator: _validateEmpty,
                    onSaved: (String value) {
                      _data.name = value;
                    },
                  ),
                  EditText(
                    title: 'Price',
                    validator: _validateEmpty,
                    onSaved: (String value) {
                      _data.price = int.parse(value);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Qty',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: _validateEmpty,
                        onSaved: (String value) {
                          _data.qty = int.parse(value);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('Add Product'),
                      onPressed: submitForm,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
