import 'package:adscape_etudiant/firebase_options.dart';
import 'package:adscape_etudiant/screen/onboarding_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdScape Etudiant',
      theme: TAppTheme.mobileTheme,
      home: AnimatedSplashScreen(
        splash: SvgPicture.asset("assets/images/logo_title_image.svg"),

        splashIconSize: 400,
        duration: 1500,
        splashTransition: SplashTransition.fadeTransition,
        //nextScreen: SignInPage(),
        nextScreen: OnBoardingPage(),
      ),
    );
  }
}
