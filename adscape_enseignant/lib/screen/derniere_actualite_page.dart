import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/constants.dart';

class DerniereActualitePage extends StatefulWidget {
  const DerniereActualitePage({super.key});

  @override
  State<DerniereActualitePage> createState() => _DerniereActualitePageState();
}

class _DerniereActualitePageState extends State<DerniereActualitePage> {
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
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Hero(
                    tag: "hero_1",
                    transitionOnUserGestures: true,
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
                  child: SingleChildScrollView(
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
                        SizedBox(height: 10),
                        Text(
                          "Comparing the AstraZeneca and Sinovac COVID-19 Vaccines Comparing the AstraZeneca and Sinovac COVID-19 Vaccines Comparing the AstraZeneca and Sinovac COVID-19 Vaccines Comparing the AstraZeneca and Sinovac COVID-19 Vaccines ",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.start,
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
