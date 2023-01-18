// Get a location using getDatabasesPath

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:rare_crew/models/item_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static late Database db;
  static Future<void> init() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'rare.db');
    // open the database
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table

      await db.execute(
          'CREATE TABLE Items (id INTEGER PRIMARY KEY, title TEXT, body TEXT)');
    });
  }

// Insert some records in a transaction
  static Future<int> addItem(Item item) async {
    int id = await db.transaction((txn) async {
      final id = await txn.rawInsert(
          'INSERT INTO Items(title, body) VALUES("${item.title}", "${item.body}")');
      return id;
    });
    log(id.toString());
    return id;
  }

  static Future<void> updateItem(Item item) async {
    int count = await db.rawUpdate(
        'UPDATE Items SET title = ?, body = ? WHERE id = ?',
        ['${item.title}', '${item.body}', '${item.id}']);
    debugPrint('updated: $count');
  }

  static Future<List<Item>> getItems() async {
    List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM Items');
    List<Item> items = [];
    for (var item in list) {
      items.add(Item.fromJson(item));
    }
    return items;
  }

  static Future<void> deleteItem(int id) async {
    await db.rawDelete('DELETE FROM Items WHERE id = ?', ['$id']);
  }
}
