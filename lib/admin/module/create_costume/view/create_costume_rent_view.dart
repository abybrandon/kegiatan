import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/selector/multi_select.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/create_costume_controller.dart';

class CreateCostumeRentView extends GetView<CreateCostumeController> {
  const CreateCostumeRentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: bgRed),
        body: controller.obx((state) => _FormCreateCostume(),
            onLoading: Stack(
              children: [_FormCreateCostume(), Loader()],
            )));
  }
}

class _FormCreateCostume extends GetView<CreateCostumeController> {
  _FormCreateCostume({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.h.heightBox,
            CustomTextField(
              errorText: '',
              hintText: 'Nama Costume',
              controller: controller.nameArtist,
            ),
            20.h.heightBox,
            CustomTextField(
              errorText: '',
              hintText: 'From Charackter',
              controller: controller.nameArtist,
            ),
            20.h.heightBox,
            InkWell(
              onTap: () {
                controller.getImageGalery();
              },
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(border: Border.all(color: bgRed)),
                  child: Center(
                      child: Icon(
                    Remix.upload_2_line,
                    color: bgRed,
                  )),
                ),
              ),
            ),
            10.heightBox,
            Text('Size Avail'),
            10.h.heightBox,
            Row(
              children: [
                _widgetSize(
                  isChecked: controller.sizeSonChecked,
                  tittle: 'S',
                ),
                _widgetSize(
                  isChecked: controller.sizeMonChecked,
                  tittle: 'M',
                ),
                _widgetSize(
                  isChecked: controller.sizeLonChecked,
                  tittle: 'L',
                ),
                _widgetSize(
                  isChecked: controller.sizeXLonChecked,
                  tittle: 'XL',
                ),
              ],
            ),
            10.h.heightBox,
            Text('Category Costume'),
            5.h.heightBox,
            Obx(
              () => MultiSelectorWidget(
                label: 'Category Costume',
                onSelect: (selectedItems) {},
                // functionReset:
                //   controller.getCategoryCostume(),
                items: controller.categoryOption,
                bodyWidget: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: bgRed,
                    ),
                    child: Text(
                      'Select Category',
                      style: TextStyle(fontSize: 14.sp, color: bgWhite),
                    )),
              ),
            ),
               10.h.heightBox,
            Text('Charackter Origin'),
            5.h.heightBox,
            Obx(
              () => MultiSelectorWidget(
                label: 'Charackter Origin',
                onSelect: (selectedItems) {},
                // functionReset:
                //   controller.getCategoryCostume(),
                items: controller.categoryOption,
                bodyWidget: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: bgRed,
                    ),
                    child: Text(
                      'Select Category',
                      style: TextStyle(fontSize: 14.sp, color: bgWhite),
                    )),
              ),
            ),
            10.h.heightBox,
            Text('Rental Price'),
            10.h.heightBox,
            CustomTextField(
              errorText: '',
              hintText: 'Price Rent',
              controller: controller.nameArtist,
              digitOnly: true,
              maxWidth: 100,
            ),
            20.h.heightBox,
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: bgRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                onPressed: () {},
                child: Text('Create Artist')),
          ],
        ),
      ),
    );
  }
}

class _widgetSize extends StatelessWidget {
  _widgetSize({super.key, required this.isChecked, required this.tittle});
  RxBool isChecked = false.obs;
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          tittle,
          style: TextStyle(fontSize: 12),
        ),
        Obx(
          () => Checkbox(
            value: isChecked.value,
            onChanged: (value) {
              isChecked.value = value!;
            },
          ),
        ),
        4.w.widthBox
      ],
    );
  }
}
