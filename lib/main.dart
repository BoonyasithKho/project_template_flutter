import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/fifth_screen.dart';
import 'screens/first_sceen.dart';
import 'screens/second_screen.dart';
import 'screens/third_screen.dart';
import 'screens/fourth_screen.dart';
import 'screens/landing_page.dart';
import 'utils/my_constant.dart';
import 'utils/my_theme.dart';

final Map<String, WidgetBuilder> mapRoute = {
  '/landingPage': (context) => const LandingPage(),
  '/firstScreen': (context) => const FirstScreen(),
  '/secondScreen': (context) => const SecondScreen(),
  '/thirdScreen': (context) => const ThirdScreen(),
  '/fourthScreen': (context) => const FifthScreen(),
  '/fifthScreen': (context) => const FourthScreen(),
};

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static String title = MyConstant.appName;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          routes: mapRoute,
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          initialRoute: MyConstant.routeLanding,
        );
      });
}
