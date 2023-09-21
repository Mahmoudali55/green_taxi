// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_texi/controller/auth_controller.dart';
import 'package:pinput/pinput.dart';

class RoundWithShadow extends StatefulWidget {
  @override
  State<RoundWithShadow> createState() => _RoundWithShadowState();
  @override
  String toStringShort() => 'Round With Shadow';
}

class _RoundWithShadowState extends State<RoundWithShadow> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  AuthCountroller authCountroller = Get.find<AuthCountroller>();
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 60,
        height: 64,
        textStyle: GoogleFonts.poppins(
          fontSize: 20,
          color: Color.fromRGBO(70, 69, 66, 1),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(232, 235, 241, 0.37),
          borderRadius: BorderRadius.circular(8),
        ));
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    return Pinput(
      length: 6,
      controller: controller,
      focusNode: focusNode,
      onCompleted: (String input) {
        authCountroller.verifyOtp(input);
      },
      defaultPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05333333865889849),
                offset: Offset(0, 3),
                blurRadius: 16,
              )
            ]),
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05333333865889849),
              offset: Offset(0, 3),
              blurRadius: 16,
            )
          ])),
      showCursor: true,
      cursor: cursor,
    );
  }
}
