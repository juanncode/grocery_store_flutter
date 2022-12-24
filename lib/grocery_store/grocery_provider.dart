import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_store/grocery_store_bloc.dart';

class GroceryProvider extends InheritedWidget {
  final GroceryStoreBloc bloc;
  final Widget child;

  GroceryProvider({required this.bloc, required this.child}) : super(child: child);

  static GroceryProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<GroceryProvider>();
    assert(result != null, 'No GroceryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  
}