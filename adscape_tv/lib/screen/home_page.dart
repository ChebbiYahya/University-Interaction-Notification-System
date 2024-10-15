import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../controllers/pub_controller.dart';
import '../models/pub_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(PubController());

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: StreamBuilder<List<dynamic>>(
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(PubModel pub) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
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
