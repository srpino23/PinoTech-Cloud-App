import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pinotech_cloud/screens/MainScreen.dart';
import 'package:pinotech_cloud/screens/LoginScreen.dart';
import 'package:pinotech_cloud/screens/RegisterScreen.dart';
import 'package:pinotech_cloud/components/Navigation.dart';
import 'package:pinotech_cloud/screens/HomeScreen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation(),
    );
  }
}
