import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/selector/multi_select.dart';
import 'package:newtest/widget/selector/single_select.dart';
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    errorText: '',
                    hintText: 'Nama Costume',
                    controller: controller.nameCostumeController,
                  ),
                  20.h.heightBox,
                  Obx(
                    () => controller.photoList.isNotEmpty
                        ? Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    controller.getImageGalery();
                                  },
                                  child: Text('Edit Photo')),
                              PhotoListWidget(),
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              controller.getImageGalery();
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
                  15.h.heightBox,
                  Text('Charackter Origin'),
                  5.h.heightBox,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: bgRed,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleSelect(
                            items: controller.chacarckterOption,
                            onSelect: (selectedItem) {
                              controller.selectedCharackter.value =
                                  selectedItem;
                            },
                          ),
                        );
                      },
                      child: Text('Select Charackter')),
                  Obx(
                    () => controller.selectedCharackter.value != null
                        ? Text(
                            'Value : ${controller.selectedCharackter.value?.name ?? ''}')
                        : SizedBox.shrink(),
                  ),
                  15.h.heightBox,
                  Text('Category Costume'),
                  5.h.heightBox,
                  Obx(
                    () => MultiSelectorWidget(
                      label: 'Category Costume',
                      onSelect: (selectedItems) {
                        controller.selectedCategory.assignAll(selectedItems);
                      },
                      // functionReset:
                      //   controller.getCategoryCostume(),
                      items: controller.categoryOption,
                      bodyWidget: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: bgRed,
                          ),
                          child: Center(
                            child: Text(
                              'Select Category',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: bgWhite,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ),
                  ),
                  Obx(() => controller.selectedCategory.isNotEmpty
                      ? Row(
                          children: controller.selectedCategory.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: generalGrey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(category.name),
                              ),
                            );
                          }).toList(),
                        )
                      : SizedBox.shrink()),
                  15.h.heightBox,
                  Text('Select Brand'),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: bgRed,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleSelect(
                            items: controller.brandOption,
                            onSelect: (selectedItem) {
                              controller.selectedBrand.value =
                                  selectedItem;
                            },
                          ),
                        );
                      },
                      child: Text('Select Brand')),
                  Obx(
                    () => controller.selectedBrand.value != null
                        ? Text(
                            'Value : ${controller.selectedBrand.value?.name ?? ''}')
                        : SizedBox.shrink(),
                  ),
                  15.h.heightBox,
                  Text('Gender Costume'),
                  Row(
                    children: [
                      _widgetSize(
                        isChecked: controller.maleOnChecked,
                        tittle: 'Male',
                      ),
                      _widgetSize(
                        isChecked: controller.femaleOnChecked,
                        tittle: 'Female',
                      ),
                    ],
                  ),
                  Text('Rental Price'),
                  10.h.heightBox,
                  TextField(
                    controller: controller.controllerPrice,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      labelText: 'Enter Price',
                      prefixText: 'Rp ',
                    ),
                  ),
                  20.h.heightBox,
                  Text('Detail Costume'),
                  TextField(
                    maxLines: null,
                    minLines: 3,
                    controller: controller.controlelrDetail,
                    decoration:
                        InputDecoration(hintText: 'Include wig, acc etc'),
                  ),
                ],
              ),
            ),
          ),
        ),
        _FloatingButtonSubmit()
      ],
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

class _FloatingButtonSubmit extends GetView<CreateCostumeController> {
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
            // final isSuccess = await controller.onAssignAsset();
            // if (isSuccess) {
            //   controllerPrelist.allAsetsAssignListPagingController
            //       .refresh();
            //   controllerPrelist.selectedAllAssetsId.clear();
            // }
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

class PhotoListWidget extends GetView<CreateCostumeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.photoList.isEmpty) {
        return SizedBox.shrink();
      }
      return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.photoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.file(controller.photoList[index]),
            );
          },
        ),
      );
    });
  }
}
