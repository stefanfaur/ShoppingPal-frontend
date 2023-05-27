import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/getUserID.dart';
import 'package:shoppingpal/pages/showItems.dart';
import 'package:path/path.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  static String receiptsResponse = '''{
  "receipts": [
    {
      "id": 5,
      "total": 39.83,
      "user_id": "BimtoTlu2IMu8zI0gv9CScJtNa82",
      "name": "Nume Casier",
      "shop_name": "Nume Casier",
      "date": "2023-05-27T17:48:09.244567"
    },
    {
      "id": 1,
      "total": 123.45,
      "user_id": "BimtoTlu2IMu8zI0gv9CScJtNa82",
      "name": "test_merchant",
      "shop_name": "test_merchant",
      "date": "2023-05-27T05:32:03.345332"
    },
    {
      "id": 6,
      "total": 39.83,
      "user_id": "BimtoTlu2IMu8zI0gv9CScJtNa82",
      "name": "Nume Casier",
      "shop_name": "Nume Casier",
      "date": "2023-05-27T17:56:30.937540"
    },
    {
      "id": 7,
      "total": 39.83,
      "user_id": "BimtoTlu2IMu8zI0gv9CScJtNa82",
      "name": "Nume Casier",
      "shop_name": "Nume Casier",
      "date": "2023-05-27T17:58:58.268098"
    }
  ]
}''';

  static final receiptsJSON = jsonDecode(receiptsResponse);

  List receipts = receiptsJSON["receipts"];

  void switchScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ShowItems(),
        ));
  }

  @override
  void initState() {
    getUserID.getUID();
    getUserID.getUserEmail();
    super.initState();
    print(receiptsJSON);
    print(receipts.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: receipts.length,
        itemBuilder: (context, index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              key: ValueKey(receipts[index]["id"]),
              margin: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 255, 164, 53),
              child: Column(
                children: [
                  CustomListButton(
                    index: index,
                    receipts: receipts,
                    shop_name: "shop_name",
                    date: "date",
                    total: "total",
                    onClick: () => {
                      switchScreen(context),
                    },
                  ),
                ],
              ));
        },
      ),
    );
  }
}

Widget CustomListButton({
  required index,
  required List receipts,
  required String shop_name,
  required String date,
  required String total,
  required VoidCallback onClick,
}) {
  return ElevatedButton(
    onPressed: onClick,
    child: Column(
      children: [
        Text('Shop Name: ${receipts[index][shop_name]}'),
        Text('Date: ${receipts[index][date]}'),
        Text('Total: ${receipts[index][total]}'),
      ],
    ),
  );
}
