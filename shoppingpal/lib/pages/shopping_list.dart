import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/getUserID.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  void initState() {
    getUserID.getUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Shopping List")),
    );
  }
}
