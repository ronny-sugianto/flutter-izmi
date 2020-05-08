import 'package:flutterapp/Models/product_model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class LocalRepository {
  Database db;

  Future<void> open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String myPathDb = path.join(databasesPath, 'app.db');

    db = await openDatabase(
      myPathDb,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS product(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, price INT, qty INT)");
      },
      version: 1,
    );
  }

  deleteDB() async {
    final dbPath = await getDatabasesPath();
    final myDBpath = path.join(dbPath, 'app.db');
    await deleteDatabase(myDBpath);
  }

  MigrateDB() async {
    try {
      await open();
      await db.insert(
          'product', {'name': 'Gulaku 150gr', 'price': 8000, 'qty': 10});
      await db
          .insert('product', {'name': 'Garam 150gr', 'price': 4000, 'qty': 10});
      await db.insert(
          'product', {'name': 'Masako Ayam 80gr', 'price': 1000, 'qty': 10});
      await db.insert('product',
          {'name': 'Indomie Goreng 150gr', 'price': 2500, 'qty': 10});
      await db.insert(
          'product', {'name': 'Detol Batang 80gr', 'price': 3500, 'qty': 10});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getProduct() async {
    try {
      await open();
      var result = await db.rawQuery("select * from product");
      return List.generate(result.length, (i) {
        return Product(
          id: result[i]['id'],
          name: result[i]['name'],
          price: result[i]['price'],
          qty: result[i]['qty'],
        );
      });
    } catch (e) {
      print(e);
      return e;
    }
  }

  addProduct(Product product) async {
    try {
      await open();
      await db.insert('product', product.toMap());
      return product;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
