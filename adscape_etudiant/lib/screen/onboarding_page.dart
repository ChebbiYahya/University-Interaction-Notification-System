import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../theme/constants.dart';
import 'component/card_planet.dart';
import 'sign_in_page.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});
  final data = [
    CardPlanetData(
      title: "Online Learning Platform",
      subtitle:
          "A handful of model sentence structures, too generate Lorem which looks reason able.",
      image: const AssetImage("assets/images/splash/splash1_image.png"),
      backgroundColor: kBlueBackgroundColor,
      titleColor: kOrangeColor,
      subtitleColor: kDarkBlueColor,
      background: LottieBuilder.asset("assets/animation/bg.json"),
    ),
    CardPlanetData(
      title: "Learn on your Schedule",
      subtitle:
          "A handful of model sentence structures, too generate Lorem which looks reason able.",
      image: const AssetImage("assets/images/splash/splash2_image.png"),
      backgroundColor: kOrangeBackgroundColor,
      titleColor: kGreenBdColor,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg.json"),
    ),
    CardPlanetData(
      title: "Explore it Today!",
      subtitle:
          "A handful of model sentence structures, too generate Lorem which looks reason able.",
      image: const AssetImage("assets/images/splash/splash3_image.png"),
      backgroundColor: kGreenBackgroundColor,
      titleColor: kBlueBackgroundColor,
      subtitleColor: kDarkBlueColor,
      background: LottieBuilder.asset("assets/animation/bg.json"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          itemCount: data.length,
          reverse: false,
          itemBuilder: (int index) {
            return CardPlanet(data: data[index]);
          },
          onFinish: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
        ),
      ),
    );
  }
}
