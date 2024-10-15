import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../components/specialite_component.dart';

class SpecialitePage extends StatefulWidget {
  const SpecialitePage({super.key, required this.usr});
  final UserModel usr;

  @override
  State<SpecialitePage> createState() => _SpecialitePageState();
}

class _SpecialitePageState extends State<SpecialitePage> {
  List<String> specialiteList = [
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
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(10),
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
                child: GridView.builder(
                  itemCount: specialiteList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _size.width > 600 ? 4 : 2,
                  ),
                  itemBuilder: (context, index) {
                    return SpecialiteComponent(
                      usr: widget.usr,
                      specialite: specialiteList[index],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
