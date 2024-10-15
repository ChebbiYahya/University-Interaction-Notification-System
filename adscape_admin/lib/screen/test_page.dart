import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../theme/constants.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String selectedFile = "";
  Uint8List? selectedImageInBytes;

  _selectFile() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      setState(() {
        selectedFile = fileResult!.files.first.name;

        selectedImageInBytes = fileResult!.files.first.bytes;
      });
    }
    print("*********** pathhhhhhhhhhhhhhhh=");
    print("*********** ${fileResult!.files.first.path}");
    print("*********** pathhhhhhhhhhhhhhhh=");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (content) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: Text("Ajoute un nouveau message"),
                    content: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  FilePickerResult? fileResult =
                                      await FilePicker.platform.pickFiles();
                                  if (fileResult != null) {
                                    setState(() {
                                      selectedFile =
                                          fileResult!.files.first.name;

                                      selectedImageInBytes =
                                          fileResult!.files.first.bytes;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: selectedFile.isEmpty
                                      ? Center(
                                          child: Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              size: 30),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            selectedImageInBytes!,
                                            fit: BoxFit.cover,
                                          )),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text('Annuler'),
                      ),
                      ElevatedButton(
                        onPressed: () async {},
                        child: Text('OK'),
                      ),
                    ],
                  );
                });
              });
        },
        child: Icon(
          Icons.add,
          color: kWhiteColor,
        ),
        backgroundColor: kBlueColor.withOpacity(0.6),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await _selectFile();
              },
              child: Text("Sélectionner une image"),
            ),
          ),
          Container(
            height: 100,
            child: selectedFile.isEmpty
                ? Image.asset(
                    "defaultImageUrl",
                    fit: BoxFit.cover,
                  )
                : Image.memory(selectedImageInBytes!),
          ),
        ],
      ),
    ));
  }
}
