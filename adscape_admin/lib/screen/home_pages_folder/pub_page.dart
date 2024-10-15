import 'package:adscape_admin/controllers/pub_controller.dart';
import 'package:adscape_admin/models/pub_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../theme/constants.dart';
import '../components/pub_component.dart';

class PubPage extends StatefulWidget {
  const PubPage({super.key});

  @override
  State<PubPage> createState() => _PubPageState();
}

class _PubPageState extends State<PubPage> {
  TextEditingController _titreController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String selectedFile = "";
    Uint8List? selectedImageInBytes;

    var _size = MediaQuery.of(context).size;
    final controller = Get.put(PubController());

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Les publicitées",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (content) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: Text("Ajouter une nouvelle publicité"),
                              content: SingleChildScrollView(
                                child: Form(
                                  key: formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: InkWell(
                                          onTap: () async {
                                            FilePickerResult? fileResult =
                                                await FilePicker.platform
                                                    .pickFiles();
                                            if (fileResult != null) {
                                              setState(() {
                                                selectedFile =
                                                    fileResult.files.first.name;
                                                selectedImageInBytes =
                                                    fileResult
                                                        .files.first.bytes;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 200,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.memory(
                                                      selectedImageInBytes!,
                                                      fit: BoxFit.cover,
                                                    )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        controller: _titreController,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          hintText: "Description",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .inputDecorationTheme
                                            .labelStyle,
                                        validator: MultiValidator(
                                          [
                                            RequiredValidator(
                                                errorText: "* Obligatoire"),
                                          ],
                                        ),
                                      ),
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
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      final pub = PubModel(
                                        description:
                                            _titreController.text.trim(),
                                      );
                                      await controller.createPubController(
                                          pub, selectedImageInBytes!);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kBlueColor.withOpacity(0.9),
                    ),
                    child: Icon(
                      Icons.add,
                      color: kWhiteColor,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                  stream: controller.getPubController(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return Text('No data available');
                    } else {
                      return GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _size.width > 600 ? 4 : 2,
                        ),
                        itemBuilder: (context, index) {
                          return PubComponent(pub: snapshot.data![index]);
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
