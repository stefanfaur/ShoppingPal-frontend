import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
              width: 250,
            ),
            CustomButton(title: 'Insert Image', onClick: () => {}),
            const SizedBox(height: 15),
            CustomButton(title: 'Take Photo', onClick: () => {})
          ],
        ),
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required VoidCallback onClick,
}) {
  return Container(
    child: ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(220, 121, 0, 1),
          fixedSize: const Size(150, 50),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(title),
    ),
  );
}
