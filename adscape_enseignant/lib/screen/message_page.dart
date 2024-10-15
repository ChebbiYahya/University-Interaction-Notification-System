import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/message_controller.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../theme/constants.dart';
import 'component/message_component.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, this.usr, this.specialite});
  final UserModel? usr;
  final String? specialite;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final controller = Get.put(MessageController());
  TextEditingController _titreController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _isChecked = false;
  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          children: [
                            SizedBox(height: 10),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 80);
                                  setState(() {
                                    if (pickedFile != null) {
                                      _image = File(pickedFile.path);
                                    } else {
                                      print("no image picked");
                                    }
                                  });
                                },
                                child: Container(
                                    height: 200,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: _image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              _image!.absolute,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Center(
                                            child: Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                                size: 30),
                                          )),
                              ),
                            ),
                            SizedBox(height: 10),
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
                                idProf: widget.usr!.id,
                                nomProf: widget.usr!.fullName,
                                time: time,
                                checkImportant: _isChecked);
                            await controller.createMsgController(
                                msg, widget.specialite!, _image!.path);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                });
              },
            );
          },
          child: Icon(
            Icons.add,
            color: kWhiteColor,
          ),
          backgroundColor: kBlueColor.withOpacity(0.6),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Les messages",
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
                    stream: controller.getMessageController(
                        widget.specialite!, widget.usr!.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return Text('No data available');
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.vertical,
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
      ),
    );
  }
}
