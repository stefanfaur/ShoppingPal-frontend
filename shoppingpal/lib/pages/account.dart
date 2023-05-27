import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/photo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

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
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.account_circle_sharp,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Signed in as:\n${user.email!}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 36, 36, 36),
                    ),
                  ),
                  const SizedBox(
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
            onClick: () => FirebaseAuth.instance.signOut(),
            icon: Icons.arrow_back,
          ),
        ],
      ),
    ));
  }
}
