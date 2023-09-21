// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_texi/views/otp_verification.dart';

import '../widgets/green_widget.dart';
import '../widgets/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode countryCode =
      CountryCode(name: 'Egypte', code: 'eg', dialCode: '+20');
  onSubmit(String? input) {
    Get.to(() => OtpVerificationScreen(countryCode.dialCode + input!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            greenIntroWidget(),
            SizedBox(
              height: 50,
            ),
            loginWidget(countryCode, () async {
              final code = await countryPicker.showPicker(context: context);
              // Null check
              if (code != null) countryCode = code;
              setState(() {});
            }, onSubmit)
          ]),
        ),
      ),
    );
  }
}
