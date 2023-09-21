// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget greenIntroWidget() {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadiusDirectional.vertical(
            bottom: Radius.elliptical(100, 100))),
    height: Get.height * 0.6,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/leaf_icons.png',
          height: 150,
        ),
        Text(
          'GREEN TAXI',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50),
        )
      ],
    ),
  );
}
