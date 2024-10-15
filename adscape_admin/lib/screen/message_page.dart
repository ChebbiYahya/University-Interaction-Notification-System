import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../controllers/message_controller.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../theme/constants.dart';
import 'components/message_component.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.specialite, required this.usr});
  final String specialite;
  final UserModel usr;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController _titreController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _isChecked = false;
  final controller = Get.put(MessageController());

  late String tempPath;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    String selectedFile = "";
    Uint8List? selectedImageInBytes;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: SvgPicture.asset(
            "assets/images/logo_title_image.svg",
            height: 40,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
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
                        key: formkey,
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
                                          fileResult.files.first.name;
                                      selectedImageInBytes =
                                          fileResult.files.first.bytes;
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
                            TextFormField(
                              controller: _titreController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: "Titre",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              style: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              validator: MultiValidator(
                                [
                                  RequiredValidator(errorText: "* Obligatoire"),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              style: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              validator: MultiValidator(
                                [
                                  RequiredValidator(errorText: "* Obligatoire"),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isChecked = newValue!;
                                    });
                                  },
                                ),
                                Text(
                                  "Important",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
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
                            String time = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();
                            final msg = MessageModel(
                              title: _titreController.text.trim(),
                              description: _descriptionController.text.trim(),
                              idProf: widget.usr.id,
                              nomProf: widget.usr.fullName,
                              time: time,
                              checkImportant: _isChecked,
                            );
                            await controller.createMsgController(
                                msg, widget.specialite, selectedImageInBytes!);

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
        child: Icon(
          Icons.add,
          color: kWhiteColor,
        ),
        backgroundColor: kBlueColor.withOpacity(0.6),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Les Messages",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                  stream: controller.getMessageController(widget.specialite),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _size.width < 900
                                ? ((_size.width > 650) ? 2 : 1)
                                : 3,
                          ),
                          itemBuilder: (context, index) {
                            return MessageComponent(
                              msg: snapshot.data![index],
                              specialite: widget.specialite,
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
