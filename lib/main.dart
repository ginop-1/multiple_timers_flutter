import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/Body.dart';
import 'models/Timer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TimersModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Mainbody(),
    );
  }
}
