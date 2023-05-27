import 'package:flutter/material.dart';
import 'package:shoppingpal/pages/photo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppingpal/services/get_user_info.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<Map<String, dynamic>> getUserAdminStatus() async {
    final user = FirebaseAuth.instance.currentUser!;
    var userInfo = await getUserInfo(user.uid);
    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Container(
        child: Center(
            child: Column(children: [
      const SizedBox(
        height: 70,
      ),
      Container(
        decoration:
            const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5))),
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<Map<String, dynamic>>(
                  future: getUserAdminStatus(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if (snapshot.data!['is_admin'] == true) {
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          child: Text(
                            'You are an admin!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: Text(
                            'You are not an admin.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                    }
                  },
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
    ])));
  }
}
