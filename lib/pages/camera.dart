// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io' show File, Platform;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart' as file_picker;

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _CameraPageState();
}

class _CameraPageState extends State<PickImage> {
  Uint8List? _image;
  File? selectedImage;
  List<String> modelSelectionOptions = [
    "YOLO v5s",
    "YOLO v5m",
    "YOLO v5l",
    "YOLO v5x"
  ];
  String selectedModel = "YOLO v5s";
  TextEditingController imgSizeController = TextEditingController(text: "416");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Upload your image, \nand select a YOLO v5 model",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? Container(
                              width: 280,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.grey.shade200,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(_image!),
                                ),
                              ),
                            )
                          : Container(
                              width: 280,
                              height: 200,
                              color: Colors.grey.shade200,
                            ),
                      Positioned(
                        bottom: -4,
                        left: 232,
                        child: IconButton(
                          onPressed: () {
                            showImagePickerOption(context);
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                          ),
                          iconSize: 32,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Upload Images",
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DropdownButtonFormField(
                            value: selectedModel,
                            items: modelSelectionOptions
                                .map((selection) => DropdownMenuItem(
                                      value: selection,
                                      child: Text(selection),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedModel = value.toString();
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "Select YOLO Model",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: imgSizeController,
                            decoration: const InputDecoration(
                              labelText: "Model Inference Size",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle form submission
                            },
                            child: const Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 90,
          child: BottomAppBar(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 12,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/home',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/search',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.explore_outlined,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/camera',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.camera_rounded,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/mypage',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.cases_outlined,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'My Page',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.amber.shade100,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Platform.isMacOS
                          ? _pickImageFromWeb()
                          : _pickImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text(
                            "Gallery",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text(
                            "Camera",
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future _pickImageFromWeb() async {
    try {
      final result = await file_picker.FilePicker.platform.pickFiles(
        type: file_picker.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = File(result.files.single.path!);
      setState(() {
        selectedImage = file;
        _image = file.readAsBytesSync();
      });
    } catch (e) {
      print("Error picking image from web: $e");
    }
    Navigator.of(context).pop();
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}
