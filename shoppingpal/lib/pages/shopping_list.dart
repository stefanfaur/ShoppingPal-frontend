import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/getUserID.dart';
import 'package:shoppingpal/pages/showItems.dart';
import 'package:shoppingpal/services/get_user_receipts.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  Future<Map<String, dynamic>> getUserReceiptList() async {
    var response = await getUserReceipts(getUserID.getUID());
    return response;
  }

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List receipts = [];

  void switchScreen(BuildContext context, int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowItems(id: id),
        ));
  }

  @override
  void initState() {
    getUserID.getUID();
    getUserID.getUserEmail();
    super.initState();
    widget.getUserReceiptList().then((res) {
      setState(() {
        Map<String, dynamic> receiptsJSON = res;
        receipts = receiptsJSON["receipts"];
      });
    });
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
                      switchScreen(context, receipts[index]["id"]),
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
