import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

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
          backgroundColor: bgRed,
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
                ? PhotoListWidget()
                : InkWell(
                    onTap: () {
                      controller.getImageGalery();
                    },
                    child: SizedBox(height: 100, child: Placeholder())),
          ),
          40.heightBox,
          10.heightBox,
          CustomTextField(
            errorText: 'Nama Event',
            hintText: 'Nama Event',
            controller: controller.nameEventController,
          ),
          10.heightBox,
          CustomTextField(
            hintText: 'Organizer Event',
            errorText: 'Organizer Event',
            controller: controller.organizerController,
          ),
          10.heightBox,
          CustomTextField(
            hintText: 'Lokasi Kota',
            errorText: 'Lokasi Kota',
            controller: controller.cityEventController,
          ),
          10.heightBox,
          TextField(
            maxLines: null,
            controller: controller.deskripsiEventController,
            decoration: InputDecoration(hintText: 'Deskripsi'),
          ),
          10.heightBox,
          LocationEventSelector(
            tittle: Obx(
              () => Text(
                controller.locationEventName.value,
                style: TextStyle(
                    fontSize: 14.sp,
                    overflow: TextOverflow.clip,
                    color: bgWhite,
                    fontWeight: FontWeight.w400),
              ),
            ),
            label: 'Lokasi Event',
            items: controller.locationOption,
            onSelect: (selectedItems) {
              List<double> eventLatitude =
                  selectedItems.map((e) => e.latitude).toList();
              controller.eventLatitude = eventLatitude[0];
              List<double> eventLongitude =
                  selectedItems.map((e) => e.longitude).toList();
              controller.eventLongitude = eventLongitude[0];
              controller.selectedNameLocaiton.value =
                  selectedItems.map((e) => e.locationName).toList()[0];
            },
          ),
          10.heightBox,
          Obx(() => controller.selectedNameLocaiton.isNotEmpty
              ? Text(controller.selectedNameLocaiton.value)
              : SizedBox()),
          10.heightBox,
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
              print(controller.selectedGuestStart);
            },
          ),
          10.heightBox,
          Obx(() => controller.selectedGuestStart.isNotEmpty
              ? Text(controller.selectedGuestStart.toString())
              : SizedBox()),
          10.heightBox,
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
          10.heightBox,
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
                    cityEvent: controller.cityEventController.text,
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
