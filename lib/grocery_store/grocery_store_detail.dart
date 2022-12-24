import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_store/grocery_product.dart';

class GroceryStoreDetail extends StatefulWidget {
  const GroceryStoreDetail({super.key, required this.product, required this.onProductAdded});

  final GroceryProduct product;
  final VoidCallback onProductAdded;

  @override
  State<GroceryStoreDetail> createState() => _GroceryStoreDetailState();
}

class _GroceryStoreDetailState extends State<GroceryStoreDetail> {

  String heroTag = "";
  void _addToCart(BuildContext context) {
    setState(() {
      heroTag = 'details';
    });
    widget.onProductAdded();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'list_${widget.product.name}$heroTag',
              child: Image.asset(widget.product.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Color(0xfff46459),
                    onPressed: () {
                      _addToCart(context);
                      },
                    child: Text("Add to car"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
