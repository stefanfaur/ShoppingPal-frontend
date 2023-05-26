import 'package:firebase_auth/firebase_auth.dart';

class getUserID {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static String getUID() {
    final User user = auth.currentUser!;
    final uid = user.uid;
    return uid;
  }
}
