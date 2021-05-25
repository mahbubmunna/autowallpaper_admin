import 'package:autowallpaper_admin/constants.dart';
import 'package:autowallpaper_admin/home/bloc/bloc.dart';
import 'package:autowallpaper_admin/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(AutoWallpaperAdmin());
}

class AutoWallpaperAdmin extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AutoWallpaperAdminState createState() => _AutoWallpaperAdminState();
}

class _AutoWallpaperAdminState extends State<AutoWallpaperAdmin> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeScreenBloc(InitialHomeScreenState()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auto wallpaper Admin',
        theme: ThemeData(
          primarySwatch: primaryAppColor,
        ),
        home: HomeScreen(title: 'Auto Wallpaper Admin',),
      ),
    );
  }
}
