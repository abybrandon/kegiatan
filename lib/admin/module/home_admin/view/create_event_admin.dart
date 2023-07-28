import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        appBar: AppBar(),
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
    openMapsSheet(context) async {
      try {
        final coords = Coords(-6.2122975, 106.8027317);
        final title = "Mall Taman Anngrek";
        final availableMaps = await MapLauncher.installedMaps;

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Wrap(
                    children: <Widget>[
                      for (var map in availableMaps)
                        ListTile(
                          onTap: () => map.showDirections(
                            destination: coords,
                            destinationTitle: title,
                            directionsMode: DirectionsMode.driving,
                          ),
                          leading: SvgPicture.asset(
                            map.icon,
                            height: 30.0,
                            width: 30.0,
                          ),
                          title: Text(map.mapName),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          30.heightBox,
          ElevatedButton(
              onPressed: () {
                openMapsSheet(context);
              },
              child: Text('try map')),
          Obx(
            () => controller.photoList.isNotEmpty
                ? PhotoListWidget()
                : InkWell(
                    onTap: () {
                      controller.getImageGalery();
                    },
                    child: SizedBox(height: 100, child: Placeholder())),
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

              print(
                  "${controller.eventLatitude} ${controller.eventLongitude} ");
            },
          ),
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
              controller.selectedGuestStart = selectedItems;
              print(controller.selectedGuestStart);
            },
          ),
          40.heightBox,
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
          ElevatedButton(
              onPressed: () {
                controller.getDate(context);
                print(controller.selectedDate.value);
              },
              child: Text('Pilih tanggal Event')),
          6.heightBox,
          ElevatedButton(
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
                    date: controller.selectedDate.value,
                    imageFiles: controller.photoList);
                print(controller.selectedDate);
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
