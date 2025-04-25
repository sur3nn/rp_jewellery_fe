import 'package:flutter/material.dart';
import 'package:rp_jewellery/screens/auth/change_pass.dart';
import 'package:rp_jewellery/screens/auth/login.dart';
import 'package:rp_jewellery/screens/auth/pass_recovery.dart';
import 'package:rp_jewellery/screens/bottom_navigation/bottom_navigation.dart';
import 'package:rp_jewellery/screens/home_screen/home_screen.dart';
import 'package:rp_jewellery/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      // Dark theme is inclided in the Full template
      themeMode: ThemeMode.light,
      home: BottomNavigation(),
    );
  }
}
