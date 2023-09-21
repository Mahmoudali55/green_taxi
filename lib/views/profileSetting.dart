import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_texi/utils/app_color.dart';

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
                  child: Container(
                    width: 120,
                    height: 120,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffD6D6D6)),
                    child: Center(
                        child: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    )),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  TextFieldWidget('Name', Icons.person_outline, nameController),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget('Home', Icons.home_outlined, homeController),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget('Business Address', Icons.card_travel,
                      businessController),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget('Shopping Center',
                      Icons.shopping_cart_outlined, shopController),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  greenButton('Sumit', () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFieldWidget(
      String titel, IconData iconData, TextEditingController controller) {
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
          ),
          child: TextFormField(
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
