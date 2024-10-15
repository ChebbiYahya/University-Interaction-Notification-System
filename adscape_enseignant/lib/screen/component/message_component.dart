import 'package:adscape_enseignant/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/message_controller.dart';
import '../../theme/constants.dart';
import '../contenu_message_page.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({super.key, this.msg, this.specialite});
  final MessageModel? msg;
  final String? specialite;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageController());

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContenuMessagePage(msg: msg)),
        );
      },
      child: Dismissible(
        key: ValueKey(msg),
        onDismissed: (DismissDirection direction) {
          controller.deleteMsgController(msg!, specialite!);
        },
        child: Container(
          height: 150,
          margin: EdgeInsets.all(10),
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
          child: Row(
            children: [
              Expanded(
                flex: 4,
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
                            )),
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
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Prof : ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: msg!.nomProf.toString(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        msg!.description.toString(),
                        style:
                            Theme.of(context).textTheme.headline6!.copyWith(),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      msg!.checkImportant == true
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
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
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
