import 'package:flutter/material.dart';


// fvm dart run asset_generator:generate
class AppAssets {
  static const String logo = 'assets/images/logo.png';
  static const String noInternet = 'assets/images/no_internet/no_internet.webp';
  static const String animatedBackground = 'assets/images/login/animated_background.webp';
}

Future<void> myPrecacheImage(BuildContext context) async {
  await Future.wait([]);
}
