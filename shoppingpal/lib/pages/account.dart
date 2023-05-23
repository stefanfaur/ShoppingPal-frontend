import 'package:flutter/material.dart';

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
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 300,
          ),
          ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(220, 121, 0, 1),
                  fixedSize: const Size(150, 50),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text('Sign Out')),
        ],
      ),
    ));
  }
}
