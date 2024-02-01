import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantial/features/search/image_pick.dart';

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {

  File? image;

  pickImage(ImageSource source){
    ImagePick(source: source)
      .pick(onPick: (File? image){
        setState(() {
          this.image = image;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Image'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 55,
              width: 300,
              child: TextButton(
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                style: ButtonStyle(
                    backgroundColor:
                    const MaterialStatePropertyAll(Color(0xFF4b8e4b)),
                    shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)))),
                child: const Text(
                  "Pick Image from Camera",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 55,
              width: 300,
              child: TextButton(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                style: ButtonStyle(
                    backgroundColor:
                    const MaterialStatePropertyAll(Color(0xFF4b8e4b)),
                    shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)))),
                child: const Text(
                  "Pick Image from Gallery",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 5),
            image != null
                ? Expanded(
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover, // Adjust this based on your needs
                    ),
                  )
                : const Text("Please select an image"),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 85,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    child: TextButton(
                      onPressed: () {
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          const MaterialStatePropertyAll(Color(0xFF4b8e4b)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)))),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
