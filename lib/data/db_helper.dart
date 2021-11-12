import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_workspace/models/product.dart';

class DbHelper {
  Database? _db;
  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  //Initiliaze Database
  Future<Database?> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), 'etrade.db');
    var eTradeDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  //Create Database
  FutureOr<void> createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key,name text,description text, unitPrice int)");
  }

  //Product List
  Future<List<Product>>? getProducts() async {
    Database? db = await this.db;
    var result = await db!.query('products');
    return List.generate(
        result.length, (index) => Product.fromJson(result[index]));
  }

  //Insert Method
  Future<int?> insert(Product product) async {
    Database? db = await this.db;
    var result = await db!.insert('products', product.toJson());
  }

  //Delete Method
  Future<int?> delete(Product product) async {
    Database? db = await this.db;
    var result =
        await db!.delete('products', where: 'id=?', whereArgs: [product.id]);
  }

  //Update Method
  Future<int?> update(Product product) async {
    Database? db = await this.db;
    var result = await db!.update('products', product.toJson(),
        where: 'id=?', whereArgs: [product.id]);
  }
}
