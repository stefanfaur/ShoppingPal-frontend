import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/account.dart';
import 'package:shoppingpal/pages/photo.dart';
import 'package:shoppingpal/pages/shopping_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [PhotoPage(), ShoppingListPage(), AccountPage()];

  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          //theme
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(255, 140, 0, 1),
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          //pageChange
          onTap: onTap,
          currentIndex: selectedIndex,
          //do not show label
          showSelectedLabels: false,
          showUnselectedLabels: false,
          //click on bottom of icon
          unselectedFontSize: 0,
          selectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.photo_camera), label: 'Photo'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Shopping List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Account')
          ]),
    );
  }
}
