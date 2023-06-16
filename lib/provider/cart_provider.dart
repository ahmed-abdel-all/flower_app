import 'package:flutter/material.dart';

import '../model/item.dart';

class CartProvider extends ChangeNotifier {
  final List<Item> _selectedProducts = [];
  double _price = 0.0;
  String name = "";
  void addProduct(Item item) {
    _selectedProducts.add(item);
    _price += item.price.round();
    notifyListeners();
  }

  void removeProduct(Item item) {
    _selectedProducts.remove(item);
    _price -= item.price.round();
    notifyListeners();
  }

  int get countProducts {
    return _selectedProducts.length;
  }

  Item getItem(int index) {
    return _selectedProducts[index];
  }

  double get totalPrice {
    return _price;
  }

  String getnameOFProduct(int index) {
    return _selectedProducts[index].name;
  }

  String getnameOFShop(int index) {
    return _selectedProducts[index].location;
  }

  String getImage(int index) {
    return _selectedProducts[index].imagePath;
  }

  double currentPrice(int index) {
    return _selectedProducts[index].price;
  }
}
