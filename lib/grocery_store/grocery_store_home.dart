import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_store/grocery_provider.dart';
import 'package:grocery_store/grocery_store/grocery_store_bloc.dart';

import 'grocery_store_list.dart';

const backgroundColor = Color(0xfff6f5f2);
const _cartBarHeight = 100.0;
const _panelTransition = Duration(milliseconds: 200);

class GroceryStoreHome extends StatefulWidget {
  @override
  State<GroceryStoreHome> createState() => _GroceryStoreHomeState();
}

class _GroceryStoreHomeState extends State<GroceryStoreHome> {
  final bloc = GroceryStoreBloc();

  void _onVerticalGesture(DragUpdateDetails details) {
    final primaryDelta = details.primaryDelta ?? 0.0;
    if (primaryDelta < -7) {
      bloc.changeToCart();
    } else if (primaryDelta > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return -_cartBarHeight + kToolbarHeight;
    } else if (state == GroceryState.cart) {
      return -(size.height - kToolbarHeight) + (kToolbarHeight);
    }
    return 0;
  }

  double _getTopForBlackPanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return size.height - kToolbarHeight - 20;
    } else if (state == GroceryState.cart) {
      return kToolbarHeight + 20;
    }
    return 0;
  }

  double _getTopForAppBar(GroceryState state) {
    if (state == GroceryState.normal) {
      return 0;
    } else if (state == GroceryState.cart) {
      return -kToolbarHeight;
    }
    return kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GroceryProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: _panelTransition,
                    curve: Curves.decelerate,
                    top: _getTopForWhitePanel(bloc.groceryState, size),
                    left: 0,
                    right: 0,
                    height: size.height - kToolbarHeight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: _cartBarHeight),
                            Expanded(child: GroceryStoreList()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: _panelTransition,
                    top: _getTopForBlackPanel(bloc.groceryState, size),
                    left: 0,
                    right: 0,
                    height: size.height,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) =>
                          _onVerticalGesture(details),
                      child: Container(
                        color: Colors.black,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        bloc.car.length,
                                        (index) => Stack(
                                          children: [
                                            Hero(
                                              tag: 'list_${bloc.car[index].product.name}details',
                                              child: CircleAvatar(
                                                backgroundColor: backgroundColor,
                                                backgroundImage: AssetImage(
                                                    bloc.car[index].product.image),
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 10,
                                                backgroundColor: Colors.red,
                                                child: Text( bloc.car[index].quantity.toString()),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                            Spacer(),
                            Placeholder(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.decelerate,
                    duration: _panelTransition,
                    top: _getTopForAppBar(bloc.groceryState),
                    left: 0,
                    right: 0,
                    child: _AppBarGrocery(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AppBarGrocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: backgroundColor,
      child: Row(
        children: [
          const BackButton(
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          const Expanded(
              child: Text(
            'Fruitis and vegetables',
            style: TextStyle(color: Colors.black),
          )),
          IconButton(
            onPressed: () => print("back"),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
