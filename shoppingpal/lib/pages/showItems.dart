import 'package:flutter/material.dart';
import 'package:shoppingpal/services/get_receipt_info.dart';

class ShowItems extends StatefulWidget {
  final int id;
  const ShowItems({
    Key? key,
    required this.id,
  }) : super(key: key);

  Future<Map<String, dynamic>> getReceiptItems() async {
    var response = await getReceiptInfo(id.toString());
    return response;
  }

  @override
  State<ShowItems> createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {
  List receiptItems = [];

  @override
  void initState() {
    super.initState();
    widget.getReceiptItems().then((res) {
      setState(() {
        receiptItems = res["items"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: receiptItems.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              key: ValueKey(receiptItems[index]["id"]),
              margin: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 255, 164, 53),
              child: ListTile(
                title: Text('Product: ${receiptItems[index]["name"]}'),
                subtitle: Column(children: [
                  Text('Quantity: ${receiptItems[index]["count"].toString()}'),
                  Text('Price: ${receiptItems[index]["price"].toString()}'),
                ]),
              ),
            );
          },
        ),
      ),
    ));
  }
}
