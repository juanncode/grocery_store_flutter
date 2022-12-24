import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_store/grocery_product.dart';

enum GroceryState {
  normal,
  details,
  cart,
}

class GroceryStoreBloc with ChangeNotifier {
  
  GroceryState groceryState = GroceryState.normal;
  List<GroceryProduct> catalog = List.unmodifiable(groceryProducts);
  List<GroceryProductItem> car = [];

  void changeToNormal() {
    groceryState = GroceryState.normal;
    notifyListeners();
  }

  void changeToCart() {
    groceryState = GroceryState.cart;
    notifyListeners();
  }

  void addProduct(GroceryProduct product) {
    for (GroceryProductItem element in car) {
      if (element.product.name == product.name) {
        element.increment();
        notifyListeners();
        return;
      }
    }
    car.add(GroceryProductItem(1, product));
    notifyListeners();
  }
}

class GroceryProductItem {
  int quantity;
  final GroceryProduct product;

  GroceryProductItem(this.quantity, this.product);

  void increment() {
    quantity++;
  }
  
  void decrement() {
    quantity--;
  }

}