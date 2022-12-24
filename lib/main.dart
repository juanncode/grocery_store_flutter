import 'package:flutter/material.dart';

import 'grocery_store/grocery_store_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: GroceryStoreHome()
    );
  }
}