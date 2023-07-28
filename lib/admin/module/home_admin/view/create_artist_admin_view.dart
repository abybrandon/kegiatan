import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

import '../../../../widget/custom_textfield.dart';
import '../controller/create_artist_admin_controller.dart';

class CreateArtistAdminView extends GetView<CreateArtistAdminController> {
  const CreateArtistAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: bgRed),
        body: controller.obx((state) => _FormCreateArtist(),
            onLoading: Stack(
              children: [_FormCreateArtist(), Loader()],
            )));
  }
}

class _FormCreateArtist extends GetView<CreateArtistAdminController> {
  _FormCreateArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            CustomTextField(
              errorText: '',
              hintText: 'Nama Artist',
              controller: controller.nameArtist,
            ),
            20.h.heightBox,
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: bgRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Memberikan border berbentuk rounded pada button
                    )),
                onPressed: () {
                  controller.createaArtist();
                },
                child: Text('Create Artist')),
          ],
        ),
      ),
    );
  }
}
