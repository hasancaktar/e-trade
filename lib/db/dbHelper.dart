import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:e_ticaret/models/product.dart';

class DbHelper {
  String tblProduct = "Products";
  String colId = "Id";
  String colDiscription = "Discription";
  String colPrice = "Price";
  String colNmae = "Name";
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String yol = directory.path + "e_trade.db";

    var dbE_ticaret = await openDatabase(yol, version: 1, onCreate: _createDb);
    return dbE_ticaret;
  }

  void _createDb(Database db, int varsion) async {
    await db.execute(
        "Create table $tblProduct($colId integer primary key,$colNmae text, " +
            "$colDiscription text, $colPrice int)");
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert(tblProduct, product.toMap());
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update(tblProduct, product.toMap(),
        where: "$colId=?", whereArgs: [product.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("Delete from $tblProduct where $colId=$id");
    return result;
  }

  Future <List> getProduct() async{
    Database db = await this.db;
    var result = await db.rawQuery("Select * from $tblProduct");
    return result;
  }
}
