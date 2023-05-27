import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppingpal/pages/getUserID.dart';
import 'package:shoppingpal/pages/photo.dart';
import 'package:shoppingpal/pages/utils.dart';
import 'package:shoppingpal/services/signup_to_db.dart';
import '../main.dart';

class SignupPage extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignupPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    } finally {
      createUser(getUserID.getUID(), getUserID.getUserEmail()!);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                top: 0,
                bottom: 34,
              ),
              child: const Text(
                'Create a new account!',
                style: TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? 'Enter minimum 6 characters'
                  : null,
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Sign Up',
              onClick: signUp,
              icon: Icons.lock_open,
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Login',
              onClick: widget.onClickedSignIn,
              icon: Icons.person_add,
            ),
          ],
        ),
      ),
    );
  }
}
