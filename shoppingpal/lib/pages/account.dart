import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/photo.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5))),
            child: const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.account_circle_sharp,
                    size: 100,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text('etrusc1 - parola de la db',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 300,
          ),
          CustomButton(
            title: 'Sign Out',
            onClick: () => {},
          ),
        ],
      ),
    ));
  }
}
