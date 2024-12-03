import 'package:eduspace/const/color.dart';
import 'package:eduspace/screen/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        fontFamily: 'Comfortaa',
      ),
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}