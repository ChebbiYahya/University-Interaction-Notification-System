import 'package:flutter/material.dart';

import '../../theme/constants.dart';
import '../derniere_actualite_page.dart';

class DernierArticleComponent extends StatelessWidget {
  const DernierArticleComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DerniereActualitePage(),
          ),
        );
      },
      child: Container(
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
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: "hero_1",
                  child: Image.asset(
                    "assets/images/empty_image.png",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: kGreeyColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Important",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Comparing the AstraZeneca and Sinovac COVID-19 Vaccines",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
