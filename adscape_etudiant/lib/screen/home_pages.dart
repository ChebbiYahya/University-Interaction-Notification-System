import 'package:adscape_etudiant/screen/home_pages_folder/specialite_page.dart';
import 'package:adscape_etudiant/screen/home_pages_folder/news_page.dart';
import 'package:adscape_etudiant/screen/home_pages_folder/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../models/user_model.dart';
import '../theme/constants.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key, required this.usr});
  final UserModel usr;

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      NewsPage(),
      SpecialitePage(usr: widget.usr),
      ProfilPage(usr: widget.usr),
    ];
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            gap: 10,
            padding: EdgeInsets.all(12),
            color: kDarkBlueColor,
            activeColor: kBlueColor,
            duration: Duration(milliseconds: 600),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                backgroundColor: kBlueClairColor,
                icon: Icons.home,
                text: "Accueil",
              ),
              GButton(
                backgroundColor: kBlueClairColor,
                icon: Icons.send_outlined,
                text: "Message",
              ),
              GButton(
                backgroundColor: kBlueClairColor,
                icon: Icons.person_outline_rounded,
                text: "Profil",
              ),
            ],
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
