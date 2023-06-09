import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/getUserID.dart';
import 'package:shoppingpal/pages/photo.dart';
import 'package:shoppingpal/services/image.dart';
import 'package:shoppingpal/services/save_receipt.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  List _items = [];
  final _image = get_image();
  String merchant_name = '';
  String date = '';
  double total = 0.0;
  Map<String, dynamic> finalJSON = {};

  // Fetch content from the json file
  Future<void> readJson() async {
    Map<String, dynamic> data = await uploadImage(_image!);

    setState(() {
      _items = data["items"];
      for (var item in _items) {
        item["qty"] = item["qty"].toString();
        item["unitPrice"] = item["unitPrice"].toString();
      }
    });

    merchant_name = data["merchant_name"];
    date = data["date"];
    total = data["total"];
  }

  String list_to_json(List items) {
    for (var item in items) {
      double qty = double.parse(item["qty"].toString());
      double unitPrice = double.parse(item["unitPrice"].toString());

      item["qty"] = qty;
      item["unitPrice"] = unitPrice;
    }
    Map<String, dynamic> tempMap = {
      'merchant_name': merchant_name,
      'date': date,
      'total': total,
      'items': items
    };

    String jsonNew = jsonEncode(tempMap);
    return jsonNew;
  }

  Future<void> uploadReceipt(String jsonData) async {
    await saveReceipt(getUserID.getUID(), jsonData);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          key: ValueKey(_items[index]["id"]),
                          margin: const EdgeInsets.all(8),
                          color: const Color.fromARGB(255, 255, 164, 53),
                          child: ListTile(
                              leading: const Icon(Icons.radio_button_checked),
                              title: CustomTextField(
                                items: _items,
                                index: index,
                                title: 'description',
                                description: 'Product',
                              ),
                              subtitle: Column(
                                children: [
                                  CustomTextField(
                                    items: _items,
                                    index: index,
                                    title: 'qty',
                                    description: 'Quantity',
                                  ),
                                  CustomTextField(
                                    items: _items,
                                    index: index,
                                    title: 'unitPrice',
                                    description: 'Price',
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Center(
                      child: Text('Loading...'),
                    ),
                  ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  title: 'Submit',
                  onClick: () => {
                    print("TEST"),
                    print(list_to_json(_items)),
                    uploadReceipt(list_to_json(_items)),
                    Navigator.pop(context, true),
                    getUserID.getUID(),
                    getUserID.getUserEmail(),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomTextField({
  required List items,
  required index,
  required String title,
  required String description,
}) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: TextField(
      textCapitalization: TextCapitalization.characters,
      onChanged: (value) => {items[index][title] = value.toUpperCase()},
      decoration: InputDecoration(
        labelText: description,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: '${items[index][title]}',
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
      ),
    ),
  );
}
