import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pinotech_cloud/screens/MainScreen.dart';
import 'package:pinotech_cloud/components/Navigation.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  void login() {
    setState(() {
      isLogin = true;
    });
  }

  void register() {
    setState(() {
      isLogin = true;
    });
  }

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
      home:
          isLogin ? Navigation() : MainScreen(login: login, register: register),
    );
  }
}
