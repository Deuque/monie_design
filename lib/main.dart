import 'package:flutter/material.dart';
import 'package:monie_design/home_page.dart';
import 'package:monie_design/navigation_screen.dart';
import 'package:monie_design/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate Design',
      theme: ThemeData(
        fontFamily: 'Euclid',
        colorScheme: ColorScheme.fromSeed(seedColor: orangeF28E13),
        useMaterial3: true,
      ),
      home: const NavigationScreen(),
    );
  }
}
