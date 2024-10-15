import 'package:flutter/material.dart';

import '../offre_formation_folder/offre_ingenieur_page.dart';

class OffreIngenieurComponent extends StatelessWidget {
  const OffreIngenieurComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OffreIngenieurPage(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color(0xFF90e698).withOpacity(0.5),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/ingenieur_image.png",
              ),
              SizedBox(height: 7),
              Text(
                "Ingenieur",
                style: Theme.of(context).textTheme.headline6!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
