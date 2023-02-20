import 'package:flutter/material.dart';

class SizeConfig {
  static late double defaultSize;
  static late Orientation orientation;
  static late double screenHeight;
  static late double screenWidth;

  static late MediaQueryData _mediaQueryData;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

//ambil proporsi height setiap ukuran tinggi
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  //812 adalah layout height yg digunakan desainer
  return (inputHeight / 812.0) * screenHeight;
}

//ambil proporsi weight setiap ukurang lebar
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  //372 adalah layout width yang digunakan desainer
  return (inputWidth / 372.0) * screenWidth;
}
