import 'package:flutter/material.dart';
//Hocam fonksiyonu static yapıp --- //LinearGradientBoxDecoration.buildGradientBoxDecoration(),
//böyle mi kullanmak lazım yoksa static yapmayıp,aşağıdaki gibi mi kullanmak daha mantıklı
//LinearGradientBoxDecoration().buildGradientBoxDecoration(),
//Şuan ikinci gösterdiğim gibi kullandım ama hangisi daha verimli bilmiyorum.
class LinearGradientBoxDecoration {
   BoxDecoration buildGradientBoxDecoration() {
  //static BoxDecoration buildGradientBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.purple, Colors.blue],
      ),
    );
  }
}
