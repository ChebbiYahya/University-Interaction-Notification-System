import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/message_model.dart';
import '../theme/constants.dart';

class ContenuMessagePage extends StatelessWidget {
  const ContenuMessagePage({super.key, this.msg});
  final MessageModel? msg;
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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Hero(
                    tag: msg!.idMsg.toString(),
                    transitionOnUserGestures: true,
                    child: Image.network(
                      msg!.urlImg.toString(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          msg!.title.toString(),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        msg!.checkImportant == true
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: kGreeyColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Important",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            : Container(),
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
                        Text(
                          msg!.description.toString(),
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(),
                          textAlign: TextAlign.start,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
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
