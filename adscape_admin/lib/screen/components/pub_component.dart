import 'package:adscape_admin/models/pub_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/pub_controller.dart';
import '../../theme/constants.dart';

class PubComponent extends StatelessWidget {
  const PubComponent({
    super.key,
    required this.pub,
  });
  final PubModel pub;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PubController());
    return Card(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: pub!.urlImg.toString() == ""
                      ? Image.asset(
                          "assets/images/empty_image.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Image.network(
                          pub.urlImg.toString(),
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                ),
                SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline6!,
                    children: <TextSpan>[
                      TextSpan(
                        text: "Description : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBlueColor,
                        ),
                      ),
                      TextSpan(
                        text: pub.description.toString(),
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (content) {
                      return AlertDialog(
                        title: Text("Êtes-vous sûr de vouloir supprimer"),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            child: Text(' Annuler '),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              controller.deletePubController(pub);
                              Navigator.of(context).pop();
                            },
                            child: Text(' Supprimer '),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.redAccent,
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
