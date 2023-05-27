import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/shopping_list.dart';

class ShowItems extends StatefulWidget {
  const ShowItems({super.key});

  @override
  State<ShowItems> createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        child: Center(child: Text("Receipt Items")),
      ),
    ));
  }
}
