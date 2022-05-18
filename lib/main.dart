import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/MainScreen/Main.dart';
import 'models/TimerModel.dart';
import 'common/Themes.dart';

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
      title: 'Timer management',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: Mainbody(),
    );
  }
}
