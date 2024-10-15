import 'package:adscape_admin/screen/home_pages_folder/specialite_page.dart';
import 'package:adscape_admin/screen/home_pages_folder/pub_page.dart';
import 'package:adscape_admin/screen/home_pages_folder/reclamation_page.dart';
import 'package:adscape_admin/screen/signin_page.dart';
import 'package:adscape_admin/screen/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  changeDestination(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 3)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final List<Widget> _pages = [
      SpecialitePage(usr: widget.usr),
      PubPage(),
      ReclamationPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: SvgPicture.asset(
            "assets/images/logo_title_image.svg",
            height: 40,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Color(0xFFE4F1F8),
            unselectedIconTheme:
                IconThemeData(color: kDarkBlueColor, opacity: 1),
            unselectedLabelTextStyle: TextStyle(color: kDarkBlueColor),
            selectedIconTheme: IconThemeData(color: kBlueColor, opacity: 1),
            selectedLabelTextStyle: TextStyle(color: kBlueColor),
            extended: _size.width > 700 ? true : false,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.send_rounded),
                label: Text("Spécialités"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.connected_tv_outlined),
                label: Text("Publicités"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.report_outlined),
                label: Text("Réclamations"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout_outlined),
                label: Text("Déconnexion"),
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: changeDestination,
          ),
          if (_selectedIndex != 3) _pages[_selectedIndex]
        ],
      ),
    );
  }
}
