import 'package:newtest/module/login/controller/login_controller.dart';
import 'package:newtest/module/login/view/tes.dart';
import 'package:newtest/module/signup/controller/sign_up_controller.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:feather_icons/feather_icons.dart';

import '../../../local_storage/local_storage_helper.dart';
import '../../../routes/app_pages.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final SignUpController controller = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            right: 40.w,
            top: -50.h,
            child: SizedBox(
                height: 213.w,
                width: 360.w,
                child: Image.asset(
                  'assets/img/tree.png',
                  fit: BoxFit.contain,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 180.h, left: 24.w, right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: basicBlack),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Text('Username',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Config.medium,
                        color: basicBlack)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
                  errorText: 'errorText',
                  hintText: 'Masukan Username',
                  controller: controller.controllerUsername,
                  icon: FeatherIcons.user,
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text('Email',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Config.medium,
                        color: basicBlack)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
                  errorText: 'errorText',
                  hintText: 'Masukan Email',
                  controller: controller.controllerEmail,
                  icon: FeatherIcons.mail,
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text('Password',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Config.medium,
                        color: basicBlack)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
                  errorText: 'errorText',
                  hintText: 'Masukan Password',
                  icon: FeatherIcons.eyeOff,
                  controller: controller.controllerPassword,
                ),
                SizedBox(
                  height: 40.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bgRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    controller.signupAuth(
                        context,
                        controller.controllerEmail.text,
                        controller.controllerPassword.text,
                        controller.controllerUsername.text);
                  },
                  child: Container(
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: Config.bold,
                          fontSize: 18.sp,
                          color: Colors.white),
                    )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: generalGrey,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: generalGrey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: generalGrey,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff1877F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    controller.loginWithGoogle();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                            color: Colors.white,
                            height: 28.h,
                            width: 28.w,
                            child: Image.asset(
                              'assets/img/googleLogo.png',
                              fit: BoxFit.contain,
                            )),
                        Expanded(
                          child: Text(
                            'Sign in with Google',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: Config.bold,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: Config.reguler,
                          color: generalGrey),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: bgRed),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
