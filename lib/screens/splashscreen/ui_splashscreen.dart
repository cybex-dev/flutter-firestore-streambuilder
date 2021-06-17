import 'package:flutter/material.dart';

class UiSplashScreen extends StatefulWidget {
  @override
  _UiSplashScreenState createState() => new _UiSplashScreenState();
}

class _UiSplashScreenState extends State<UiSplashScreen> {
  final splashScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: splashScreenKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome"),
            SizedBox(height: 12,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}