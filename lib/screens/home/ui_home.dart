import 'package:flutter/material.dart';

class UiHome extends StatefulWidget {
  @override
  _UiHomeState createState() => new _UiHomeState();
}

class _UiHomeState extends State<UiHome> {
  final uiHomeKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: uiHomeKey,
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}