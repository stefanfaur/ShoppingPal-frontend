import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 140, 0, 1),
        title: const Center(child: Text('ShoppingPal')),
      ),
      body: MainPage(),
    ));
  }
}
