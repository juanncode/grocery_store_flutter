import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_store/grocery_store/grocery_provider.dart';
import 'package:grocery_store/grocery_store/grocery_store_detail.dart';

import 'grocery_store_home.dart';

class GroceryStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context).bloc;
    return Container(
      color: backgroundColor,
      child: MasonryGridView.count(
        itemCount: bloc.catalog.length,
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final product = bloc.catalog[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: GroceryStoreDetail(
                        product: product,
                        onProductAdded: (){
                          bloc.addProduct(product);
                        }
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Hero(
                      tag: 'list_${product.name}',
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        height: Random().nextInt(100) + 70.5,
                      ),
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      product.weight,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    // return ListView.builder(
    //   itemCount: bloc.catalog.length,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       height: 100,
    //       color: Colors.primaries[index % Colors.primaries.length],
    //     );
    //   },
    // );
  }
}
