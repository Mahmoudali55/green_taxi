import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_texi/views/home_screen.dart';
import 'package:green_texi/views/profileSetting.dart';

class AuthCountroller extends GetxController {
  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;
  phoneAuth(String phone) async {
    try {
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            log('Completed');
            credentials = credential;
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          forceResendingToken: resendTokenId,
          verificationFailed: (FirebaseAuthException e) {
            log('failed');
            if (e.code == 'invalid-phone-number') {
              debugPrint('The provided phone number is not valid');
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            log('Code sent');
            verId = verificationId;
            resendTokenId = resendToken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      log('Error occured $e');
    }
  }

  verifyOtp(String otpNamber) async {
    log('Called');
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otpNamber);
    log('LogedIn');
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  decideRoute() {
    //step 1-check user login?
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      ///step2- check wheth user profile exists?
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.exists) {
          Get.to(() => HomeScreen());
        } else {
          Get.to(() => ProfileSettingScreen());
        }
      });
    }
  }
}
