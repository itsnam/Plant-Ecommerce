import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantial/features/search/image_pick.dart';
import 'package:plantial/features/search/result.dart';

import '../styles/styles.dart';

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  pickImage(ImageSource source) {
    ImagePick(source: source).pick(onPick: (File? image) {
      if (image != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Result(image: image)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Tìm kiếm bằng hình ảnh',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
      ),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              width: 325,
              child: TextButton(
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(primary),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)))),
                child: const Text(
                  "Tìm bằng máy ảnh",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 60,
              width: 325,
              child: TextButton(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(primary),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)))),
                child: const Text(
                  "Tìm trong thư viện",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
