import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../theme/constants.dart';
import '../message_page.dart';

class SpecialiteComponent extends StatefulWidget {
  const SpecialiteComponent({super.key, this.specialite, this.usr});
  final String? specialite;
  final UserModel? usr;

  @override
  State<SpecialiteComponent> createState() => _SpecialiteComponentState();
}

class _SpecialiteComponentState extends State<SpecialiteComponent> {
  List<String> listeIng = ['1ING', '2ING', '3ING', '1IDL1', '2IDL2', '2IDL1'];
  List<String> listeLicence = ['Lce1', 'Lce2'];
  List<String> listeMaster = ['MDL', 'SSII', 'SIIOT'];
  String imageUrl = "assets/images/empty_image.png";

  @override
  void initState() {
    super.initState();
    if (listeIng.contains(widget.specialite)) {
      imageUrl = "assets/images/ingenieur_image.png";
    } else if (listeLicence.contains(widget.specialite)) {
      imageUrl = "assets/images/licence_image.png";
    } else {
      imageUrl = "assets/images/master_image.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MessagePage(usr: widget.usr, specialite: widget.specialite),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(child: Image.asset(imageUrl)),
              SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline6!,
                  children: <TextSpan>[
                    TextSpan(
                      text: "Specialité : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBlueColor,
                      ),
                    ),
                    TextSpan(
                      text: "${widget.specialite}",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
