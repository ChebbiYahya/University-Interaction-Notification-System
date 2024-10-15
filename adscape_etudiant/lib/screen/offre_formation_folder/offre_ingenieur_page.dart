import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OffreIngenieurPage extends StatefulWidget {
  const OffreIngenieurPage({super.key});

  @override
  State<OffreIngenieurPage> createState() => _OffreIngenieurPageState();
}

class _OffreIngenieurPageState extends State<OffreIngenieurPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
        Uri.parse("http://www.isi.rnu.tn/institut/formations/ingenierie/"));
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
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
