// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_texi/controller/auth_controller.dart';

import 'package:green_texi/utils/app_color.dart';
import 'package:green_texi/widgets/green_widget.dart';
import 'package:green_texi/widgets/otp_verificationwidget.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen(
    this.phoneNumber,
  );
  String phoneNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  AuthCountroller authCountroller = Get.put(AuthCountroller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCountroller.phoneAuth(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            greenIntroWidget(),
            Positioned(
              top: 60,
              left: 20,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.greenColor,
                    size: 20,
                  ),
                ),
              ),
            )
          ]),
          SizedBox(
            height: 50,
          ),
          otpVerificationWidget(),
        ]),
      ),
    );
  }
}
