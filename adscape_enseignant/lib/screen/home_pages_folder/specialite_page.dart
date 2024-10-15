import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../theme/constants.dart';
import '../component/specialite_component.dart';

class SpecialitePage extends StatefulWidget {
  const SpecialitePage({super.key, required this.usr});
  final UserModel usr;

  @override
  State<SpecialitePage> createState() => _SpecialitePageState();
}

class _SpecialitePageState extends State<SpecialitePage> {
  List<String> specialite = [
    '1ING',
    '2ING',
    '3ING',
    '1IDL1',
    '1IDL2',
    '2IDL1',
    '2IDL2',
    'Lce1',
    'Lce2',
    'MDL',
    'SSII',
    'SIIOT',
  ];
  String? selectedSpecialite = '1ING';
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (content) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: Text("Selectionner la spécialité à ajouter"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: selectedSpecialite,
                          items: specialite
                              .map(
                                (item) => DropdownMenuItem<String>(
                                    value: item, child: Text(item)),
                              )
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectedSpecialite = item;
                          }),
                        ),
                      ],
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
                          if (selectedSpecialite != null) {
                            await controller.addSpecialiteToListController(
                                widget.usr.id.toString(),
                                selectedSpecialite.toString());
                          }
                          Navigator.of(context).pop();
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
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Les spécialités",
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
              stream: controller.getListSpecilityController(widget.usr.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('No data available');
                } else {
                  List<dynamic> listData = snapshot.data!;

                  return GridView.builder(
                    itemCount: listData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return SpecialiteComponent(
                          specialite: listData[index], usr: widget.usr);
                    },
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
