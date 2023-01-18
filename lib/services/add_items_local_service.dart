import 'package:flutter/foundation.dart';
import 'package:rare_crew/core/db_helper.dart';
import 'package:rare_crew/models/item_model.dart';

class AddItemsLocalService {
  static Future<int> addItem(Item item) async {
    try {
      return await DBHelper.addItem(item);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  static Future<void> updateItem(Item item) async {
    try {
      await DBHelper.updateItem(item);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  static Future<void> deleteItem(int id) async {
    try {
      await DBHelper.deleteItem(id);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  static Future<List<Item>> getItems() async {
    try {
      final items = await DBHelper.getItems();
      return items;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}
