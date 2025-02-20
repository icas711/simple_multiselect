import 'package:flutter/material.dart';

class SelectorProvider<T extends Object> extends ChangeNotifier {
  final List<T> _selectedItems = [];
  final Function func;

  SelectorProvider(this.func);

  List<T> get selectedItems => _selectedItems;


  void add(T item) {
    _selectedItems.add(item);
    notifyListeners();
    func(_selectedItems);
  }

  void remove(T item) {
    _selectedItems.remove(item);
    notifyListeners();
    func(_selectedItems);
  }

  void clear() {
    _selectedItems.clear();
    notifyListeners();
    func(_selectedItems);
  }

  void addAll(List<T> items) {
    _selectedItems.clear();
    _selectedItems.addAll(items);
    notifyListeners();
    func(_selectedItems);
  }

}
