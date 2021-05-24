import 'package:autowallpaper_admin/constants.dart';
import 'package:autowallpaper_admin/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AutoWallpaperAdmin());
}

class AutoWallpaperAdmin extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto wallpaper Admin',
      theme: ThemeData(
        primarySwatch: primaryAppColor,
      ),
      home: HomePage(title: 'Auto Wallpaper Admin',),
    );
  }
}
