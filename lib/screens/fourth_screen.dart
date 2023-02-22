import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController();
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(
      Uri.parse('https://twitter.com/explore'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
