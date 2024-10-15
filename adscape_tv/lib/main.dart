import 'package:adscape_tv/firebase_options.dart';
import 'package:adscape_tv/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adscape Tv',
      theme: TAppTheme.mobileTheme,
      home: AnimatedSplashScreen(
        splash: SvgPicture.asset("assets/images/logo_title_image.svg"),
        splashIconSize: 400,
        duration: 1500,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: HomePage(),
      ),
    );
  }
}
