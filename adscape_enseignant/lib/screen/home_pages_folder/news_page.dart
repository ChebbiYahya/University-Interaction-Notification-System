import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/pub_controller.dart';
import '../../models/pub_model.dart';
import '../component/dernier_article_component.dart';
import '../component/offre_ingenieur_component.dart';
import '../component/offre_licence_component.dart';
import '../component/offre_master_component.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final controller = Get.put(PubController());
  final listImages = [
    "assets/images/news_images/news_image1.jpg",
    "assets/images/news_images/news_image2.jpg",
    "assets/images/news_images/news_image3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nos Evenement",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<List<dynamic>>(
                  stream: controller.getPubController(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return Text('No data available');
                    } else {
                      return CarouselSlider.builder(
                        itemCount: snapshot.data!.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          pageSnapping: true,
                          //autoPlayInterval: Duration(seconds: 2),
                          //viewportFraction: 1
                          reverse: false,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return buildImage(snapshot.data![index]);
                        },
                      );
                    }
                  }),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dernieres Actualités",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: 20,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return DernierArticleComponent();
                  },
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Offre de formation",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  OffreLicenceComponent(),
                  OffreMasterComponent(),
                  OffreIngenieurComponent(),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ISI en chiffres",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/isi_chiffre_image.png",
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(PubModel pub) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        //color: Colors.grey.withOpacity(0.5),
        child: Column(
          children: [
            Expanded(
              child: pub.urlImg.toString() == ""
                  ? Image.asset(
                      "assets/images/empty_image.png",
                      fit: BoxFit.fitWidth,
                    )
                  : Image.network(
                      pub.urlImg.toString(),
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 10),
            Text(
              pub.description!,
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
      );
}
