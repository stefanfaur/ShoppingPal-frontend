import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/login_page.dart';
import 'package:shoppingpal/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(255, 140, 0, 1),
            title: const Center(child: Text('ShoppingPal')),
          ),
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong!'));
                }
                if (snapshot.hasData) {
                  return MainPage();
                } else {
                  return LoginPage();
                }
              }),
        ));
  }
}
