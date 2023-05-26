import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shoppingpal/pages/preview.dart';

File? _tempImage;

File? get_image() {
  return _tempImage;
}

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        _image = imagePermanent;
      });

      _tempImage = _image;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

//  directory documentation:
//  https://docs.flutter.dev/cookbook/persistence/reading-writing-files
  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: _image != null
                  ? Image.file(_image!,
                      width: 300, height: 400, fit: BoxFit.cover)
                  : const SizedBox(height: 250),
            ),
            CustomButton(
              title: 'Insert Image',
              onClick: () => getImage(ImageSource.gallery),
              icon: Icons.photo_camera,
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Take Photo',
              onClick: () => getImage(ImageSource.camera),
              icon: Icons.collections,
            ),
            const SizedBox(height: 15),
            Container(
              child: _image != null
                  ? CustomButton(
                      title: 'Submit',
                      onClick: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PreviewPage()),
                        ),
                      },
                      icon: Icons.done,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required VoidCallback onClick,
  IconData? icon,
}) {
  return Container(
    child: ElevatedButton.icon(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(233, 128, 0, 1),
        fixedSize: const Size(180, 60),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      icon: icon != null ? Icon(icon) : Container(),
      label: Center(child: Text(title)),
    ),
  );
}
