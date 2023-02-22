import 'package:flutter/material.dart';

import '../utils/my_constant.dart';
import '../utils/my_theme.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowTitle(
          title: MyConstant.appName,
          textStyle: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: const [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ShowImage(path: MyConstant.gistdaLogo),
            ElevatedButton(
              onPressed: () {
                print('Go to First Screen');
                Navigator.pushNamed(context, MyConstant.routeFirstScreen);
              },
              child: const Text('First Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Go to Second Screen');
                Navigator.pushNamed(context, MyConstant.routeSecondScreen);
              },
              child: const Text('Second Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Go to Third Screen');
                Navigator.pushNamed(context, MyConstant.routeThirdScreen);
              },
              child: const Text('Third Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Go to Fourth Screen');
                Navigator.pushNamed(context, MyConstant.routeFourthScreen);
              },
              child: const Text('Fourth Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
