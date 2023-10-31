import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/selector/multi_select.dart';
import 'package:newtest/widget/selector/single_select.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../theme.dart';
import '../../../../widget/custom_textfield.dart';
import '../controller/create_event_admin_controller.dart';
import '../widget/location_event_selector.dart';

class CreateEventAdmin extends GetView<CreateEventAdminController> {
  const CreateEventAdmin({super.key});

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
            'Create Event',
            style: TextStyle(color: bgRed),
          ),
        ),
        body: controller.obx((state) => _FormUpload(),
            onLoading: Stack(
              children: [_FormUpload(), Loader()],
            )));
  }
}

class _FormUpload extends GetView<CreateEventAdminController> {
  const _FormUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          30.heightBox,
          Obx(
            () => controller.photoList.isNotEmpty
                ? Column(
                    children: [
                      PhotoListWidget(),
                      InkWell(
                        onTap: () {
                          controller.getImageGalery();
                        },
                        child: Text('Edit Photo'),
                      )
                    ],
                  )
                : Center(
                    child: InkWell(
                        onTap: () {
                          controller.getImageGalery();
                        },
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(color: bgRed)),
                          height: 100,
                          width: 300,
                          child: Icon(
                            Remix.upload_2_fill,
                            color: bgRed,
                          ),
                        )),
                  ),
          ),
          40.heightBox,
          15.heightBox,
          CustomTextField(
            normalTextfield: true,
            errorText: 'Nama Event',
            hintText: 'Nama Event',
            controller: controller.nameEventController,
            borderStyle: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: bgGrey)),
          ),
          15.heightBox,
          CustomTextField(
            normalTextfield: true,
            hintText: 'Organizer Event',
            errorText: 'Organizer Event',
            controller: controller.organizerController,
            borderStyle: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: bgGrey)),
          ),
          15.heightBox,
          CustomTextField(
            normalTextfield: true,
            hintText: 'Lokasi Kota',
            errorText: 'Lokasi Kota',
            controller: controller.cityEventController,
            borderStyle: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: bgGrey)),
          ),
          15.heightBox,
          TextField(
            maxLines: null,
            controller: controller.deskripsiEventController,
            decoration: InputDecoration(hintText: 'Deskripsi'),
          ),
          15.heightBox,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bgRed,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SingleSelect(
                    items: controller.locationOption,
                    onSelect: (selectedItem) {
                      controller.eventLatitude = selectedItem?.latitude ?? 00;
                      controller.selectedNameLocaiton.value =
                          selectedItem?.locationName ?? '';
                      controller.eventLongitude = selectedItem?.longitude ?? 00;
                      controller.locationCity =
                          selectedItem?.locationCity ?? '';
                    },
                  ),
                );
              },
              child: Text('Pick Location Event')),
          15.heightBox,
          Obx(() => controller.selectedNameLocaiton.isNotEmpty
              ? Text(controller.selectedNameLocaiton.value)
              : SizedBox()),
          15.heightBox,
          Obx(
            () => MultiSelectorWidget(
              label: 'Artist Event',
              onSelect: (selectedItems) {
                controller.selectedGuestStart.value = selectedItems;
              },
              // functionReset:
              //   controller.getCategoryCostume(),
              items: controller.artistOption,
              bodyWidget: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: bgRed,
                  ),
                  child: Center(
                    child: Text(
                      'Select Artist',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: bgWhite,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
          ),
          LocationEventSelector(
            tittle: Obx(
              () => Text(
                controller.artistEventName.value,
                style: TextStyle(
                    fontSize: 14.sp,
                    overflow: TextOverflow.clip,
                    color: bgWhite,
                    fontWeight: FontWeight.w400),
              ),
            ),
            label: 'Artist Event',
            items: controller.artistOption,
            onSelect: (selectedItems) {
              controller.selectedGuestStart.value = selectedItems;
            },
          ),
          15.heightBox,
          Obx(() => controller.selectedGuestStart.isNotEmpty
              ? Text(controller.selectedGuestStart.toString())
              : SizedBox()),
          15.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgRed,
                    ),
                    onPressed: () {
                      controller.getDateStart(context);
                    },
                    child: Text(
                      'Tanggal Awal Event',
                      style: TextStyle(fontSize: 12),
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgRed,
                    ),
                    onPressed: () {
                      controller.getDateEnd(context);
                    },
                    child: Text(
                      'Tanggal Akhir Event',
                      style: TextStyle(fontSize: 12),
                    )),
              ),
            ],
          ),
          6.heightBox,
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(controller.selectedDateStartText.value),
                  Text(controller.selectedDateEndText.value)
                ],
              )),
          15.heightBox,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bgRed,
              ),
              onPressed: () {
                // controller.createJadwalKegiatan(
                //   controller.controller.text,
                //   controller.controller1.text,
                //   controller.selectedDate.value,
                // );
                controller.createEventWithPict(
                    cityEvent: controller.locationCity,
                    nameEevent: controller.nameEventController.text,
                    organizerEvent: controller.organizerController.text,
                    deskripsi: controller.deskripsiEventController.text,
                    date: controller.selectedDateEndEvent.value,
                    dateStart: controller.selectedDateStartEvent.value,
                    dateEnd: controller.selectedDateEndEvent.value,
                    imageFiles: controller.photoList);
                print(controller.selectedDateEndEvent);
              },
              child: Text('Upload'))
        ]),
      ),
    );
  }
}

class PhotoListWidget extends GetView<CreateEventAdminController> {
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
