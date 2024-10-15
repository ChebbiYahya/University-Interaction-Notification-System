import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../theme/constants.dart';
import '../sign_in_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key, required this.usr});
  final UserModel usr;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Bienvenue",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Image.asset(
                "assets/images/person_image.png",
                height: 100,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Dr " + widget.usr.fullName!,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {},
                child: Text(
                  "Parametres et confidentialité",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: kWhiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {},
                child: Text(
                  "Envoyer Réclamation",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: kWhiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  controller.logoutController().then(
                        (value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        ),
                      );
                },
                child: Text(
                  "Déconncter",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: kWhiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
