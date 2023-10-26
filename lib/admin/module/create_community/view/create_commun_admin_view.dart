import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/create_commun_admin_controller.dart';

class CreateCommunAdminView extends GetView<CreateCommunAdminController> {
  const CreateCommunAdminView({super.key});

  int countWords(String text) {
    return text.split(' ').length;
  }

  String removeLastWord(String text) {
    final words = text.split(' ');
    if (words.length > 1) {
      words.removeLast();
      return words.join(' ');
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgWhite,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Remix.arrow_left_line,
                color: bgRed,
              )),
          elevation: 2,
          title: Text(
            'Create Communnity',
            style: TextStyle(color: bgRed),
          ),
        ),
        body: controller.obx(
          (state) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.h.heightBox,
                        Center(
                          child: Obx(
                            () => controller.croppedImageFile.value != null
                                ? Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            controller.pickImage();
                                          },
                                          child: const Text('Edit Photo')),
                                      SizedBox(
                                          height: 300,
                                          child: Image.file(File(controller
                                                  .croppedImageFile
                                                  .value!
                                                  .path))
                                                  ),
                                      InkWell(
                                          onTap: () {
                                            controller.cropImage();
                                          },
                                          child: const Text('Crop Photo')),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      controller.pickImage();
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: bgRed)),
                                        child: Center(
                                            child: Icon(
                                          Remix.upload_2_line,
                                          color: bgRed,
                                        )),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        20.heightBox,
                        Text('Name Community'),
                        CustomTextField(
                          errorText: '',
                          hintText: 'Name Community',
                          controller: controller.nameCommunityController,
                          normalTextfield: true,
                          borderStyle: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: bgGrey)),
                        ),
                        10.heightBox,
                        Text('Main location base'),
                        CustomTextField(
                          errorText: '',
                          hintText: 'Main location base',
                          controller: controller.nameLocationController,
                          normalTextfield: true,
                          borderStyle: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: bgGrey)),
                        ),
                        10.h.heightBox,
                        Text('Slogan Community'),
                        CustomTextField(
                          errorText: '',
                          hintText: 'Slogan Community',
                          controller: controller.nameSloganController,
                          normalTextfield: true,
                          borderStyle: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: bgGrey)),
                        ),
                        10.h.heightBox,
                        Text('Bio & Contact'),
                        TextField(
                          maxLines: null,
                          minLines: 3,
                          controller: controller.nameBioContactController,
                          decoration:
                              const InputDecoration(hintText: 'Bio & Contact'),
                        ),
                        10.h.heightBox,
                        Text('Social Media'),
                        Text('Link Facebook'),
                        TextField(
                          maxLines: null,
                          minLines: 3,
                          controller: controller.facebookLinkController,
                          decoration: const InputDecoration(
                              hintText:
                                  'https://www.facebook.com/groups/flutterid'),
                        ),
                        10.h.heightBox,
                        Text('Link Instagram'),
                        TextField(
                          maxLines: null,
                          minLines: 3,
                          controller: controller.instagramLinkController,
                          decoration: const InputDecoration(
                              hintText:
                                  'https://instagram.com/zhuwenxuan_official'),
                        ),
                        20.h.heightBox,
                      ],
                    ),
                  ),
                ),
              ),
              _FloatingButtonSubmit()
            ],
          ),
        ));
  }
}

class _FloatingButtonSubmit extends GetView<CreateCommunAdminController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h, top: 8.h),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: bgRed,
          ),
          onPressed: () async {
            await controller.createData();
          },
          child: Text(
            'Submit',
            style: TextStyle(
                fontSize: 14.sp, fontWeight: FontWeight.w600, color: bgWhite),
          ),
        ),
      ),
    );
  }
}
