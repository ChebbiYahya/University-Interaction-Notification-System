import 'package:flutter/material.dart';

class ReclamationPage extends StatefulWidget {
  const ReclamationPage({super.key});

  @override
  State<ReclamationPage> createState() => _ReclamationPageState();
}

class _ReclamationPageState extends State<ReclamationPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text("Reclamation page"),
          ],
        ),
      ),
    );
  }
}
