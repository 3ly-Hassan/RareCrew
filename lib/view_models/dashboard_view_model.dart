import 'package:flutter/cupertino.dart';
import 'package:rare_crew/core/helper_functions.dart';
import 'package:rare_crew/models/item_model.dart';
import 'package:rare_crew/services/add_items_local_service.dart';

class DashBoardViewModel extends ChangeNotifier {
  List<Item> _items = [];
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<Item> get items => _items;

  void changeCurrentIndex(int i) {
    _currentIndex = i;
    notifyListeners();
  }

  void addItem(Item item, VoidCallback success, VoidCallback error) async {
    try {
      int id = await AddItemsLocalService.addItem(item);
      item.id = id;
      //await getItems();
      _items.add(item);
      notifyListeners();
      success();
    } catch (e) {
      error();
      showCentralToast(text: 'Error has Occurred!', state: ToastStates.error);
    }
  }

  void updateItem(Item item, VoidCallback success, VoidCallback error) async {
    try {
      await AddItemsLocalService.updateItem(item);
      //   await getItems();
      final index = _items.indexWhere((element) => element.id == item.id);
      _items[index] = item;
      notifyListeners();
      success();
    } catch (e) {
      error();
      showCentralToast(text: 'Error has Occurred!', state: ToastStates.error);
    }
  }

  void deleteItem(int id) async {
    try {
      await AddItemsLocalService.deleteItem(id);
      // await getItems();
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      showCentralToast(text: 'Error has Occurred!', state: ToastStates.error);
    }
  }

  Future<void> getItems() async {
    try {
      _items = await AddItemsLocalService.getItems();
      notifyListeners();
    } catch (e) {
      showCentralToast(text: 'Error has Occurred!', state: ToastStates.error);
    }
  }
}
