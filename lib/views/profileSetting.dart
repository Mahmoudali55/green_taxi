import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_texi/controller/auth_controller.dart';
import 'package:green_texi/utils/app_color.dart';
import 'package:green_texi/views/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  AuthCountroller authCountroller = Get.find<AuthCountroller>();
  GlobalKey<FormState> formkay = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.4,
              child: Stack(children: [
                greenIntroWidgetWithoutLogos(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      getImage(ImageSource.camera);
                    },
                    child: selectedImage == null
                        ? Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffD6D6D6)),
                            child: Center(
                                child: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.white,
                            )),
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(selectedImage!),
                                    fit: BoxFit.fill),
                                shape: BoxShape.circle,
                                color: Color(0xffD6D6D6)),
                          ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formkay,
                child: Column(
                  children: [
                    TextFieldWidget(
                        'Name', Icons.person_outline, nameController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Name is required!';
                      }
                      if (input.length < 5) {
                        return 'Please enter a valid name!';
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget('Home', Icons.home_outlined, homeController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'home address is required!';
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget('Business Address', Icons.card_travel,
                        businessController, (String? input) {
                      if (input!.isEmpty) {
                        return 'business address is required!';
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        'Shopping Center',
                        Icons.shopping_cart_outlined,
                        shopController, (String? input) {
                      if (input!.isEmpty) {
                        return 'shoping center is required!';
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Obx(() => authCountroller.isProfileUploading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : greenButton('Sumit', () {
                            if (!formkay.currentState!.validate()) {
                              return;
                            }
                            if (selectedImage == null) {
                              Get.snackbar('Warning', 'please add your image');
                              return;
                            }
                            authCountroller.isProfileUploading(true);
                            authCountroller.storgeUserInfo(
                                selectedImage!,
                                nameController.text,
                                homeController.text,
                                businessController.text,
                                shopController.text);
                          }))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFieldWidget(String titel, IconData iconData,
      TextEditingController controller, Function validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titel,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            validator: (input) => validator(input),
            controller: controller,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffA7A7A7)),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,
                  color: AppColors.greenColor,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget greenButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: AppColors.greenColor,
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget greenIntroWidgetWithoutLogos() {
    return Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadiusDirectional.vertical(
                bottom: Radius.elliptical(100, 100))),
        height: Get.height * 0.3,
        child: Container(
          height: Get.height * .1,
          width: Get.width,
          margin: EdgeInsets.only(bottom: Get.height * .05),
          child: Center(
            child: Text(
              'Profile Settings',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ));
  }
}
