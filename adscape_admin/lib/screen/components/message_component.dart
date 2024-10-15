import 'package:adscape_admin/controllers/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/message_model.dart';
import '../../theme/constants.dart';
import '../contenu_message_page.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({super.key, this.msg, this.specialite});
  final MessageModel? msg;
  final String? specialite;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(MessageController());

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContenuMessagePage(msg: msg)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kLightBlueColor,
          //color: kWhiteColor,

          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4.0, 4.0),
                blurRadius: 15,
                spreadRadius: 1),
            BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15,
                spreadRadius: 1),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Hero(
                      tag: msg!.idMsg.toString(),
                      transitionOnUserGestures: true,
                      child: msg!.urlImg.toString() == ""
                          ? Image.asset(
                              "assets/images/empty_image.png",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Image.network(
                              msg!.urlImg.toString(),
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg!.title.toString(),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Prof : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: msg!.nomProf.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        msg!.checkImportant == true
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                decoration: BoxDecoration(
                                  color: kGreeyColor,
                                  //color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.redAccent,
                                      size: 12,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "IMPORTANT",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: Colors.redAccent),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(height: 10),
                        Text(
                          msg!.description.toString(),
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
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
                                controller.deleteMsgController(
                                    msg!, specialite!);
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
            )
          ],
        ),
      ),
    );
  }
}
