import 'package:flutter/material.dart';
import 'package:meal/constants/colors.dart';
import 'package:meal/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: const AppBarTheme(
          color: Colors.black87,
          elevation: 0.0,
        ),
      ),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBgColor,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: kPrimaryColor),
            color: kBgColor,
            elevation: 0.0,
            centerTitle: true),
      ),
      home: const Home(),
    );
  }
}
