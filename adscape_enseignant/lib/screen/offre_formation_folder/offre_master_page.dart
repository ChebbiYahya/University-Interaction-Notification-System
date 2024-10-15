import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OffreMasterPage extends StatefulWidget {
  const OffreMasterPage({super.key});

  @override
  State<OffreMasterPage> createState() => _OffreMasterPageState();
}

class _OffreMasterPageState extends State<OffreMasterPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://flutter.com"));
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
