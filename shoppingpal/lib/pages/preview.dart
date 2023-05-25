import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingpal/pages/photo.dart';
import 'package:shoppingpal/services/image.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  List _items = [];
  final _image = get_image();

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
                          key: ValueKey(_items[index]["id"]),
                          margin: const EdgeInsets.all(10),
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
                  onClick: () => {},
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
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      onChanged: (value) => {print(value)},
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
            Radius.circular(10.0),
          ),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
