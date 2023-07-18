import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../../../widget/empty_state.dart';
import '../widget/filter_city_widget.dart';

class ListEventView extends GetView<EventController> {
  const ListEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event List'),
          backgroundColor: bgRed,
        ),
        body: controller.obx((state) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                      controller.filterEventList();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await controller.takeDate(context);
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: bgRed,
                                borderRadius: BorderRadius.circular(8)),
                            child: Obx(
                              () => Text(
                                controller.filterDate.value,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    overflow: TextOverflow.clip,
                                    color: bgWhite,
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                      ),
                      8.w.widthBox,
                      CitySelectorMulti(
                        tittle: Text(
                          controller.filterCity.value,
                          style: TextStyle(
                              fontSize: 14.sp,
                              overflow: TextOverflow.clip,
                              color: bgWhite,
                              fontWeight: FontWeight.w400),
                        ),
                        label: 'System Role',
                        items: controller.cityOption,
                        onSelect: (selectedItems) {
                          print(selectedItems);
                          // controller.selectedSystemRole.value =
                          //     selectedItems.map((e) => e.id).toList();
                          // controller.tittleFormSystemRole.value = selectedItems
                          //     .map((e) => e.name)
                          //     .toList()
                          //     .toString()
                          //     .replaceAll('[', '')
                          //     .replaceAll(']', '');
                        },
                      ),
                    ],
                  ),
                ),
                Obx(() => controller.filteredEventList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredEventList.length,
                          itemBuilder: (context, index) {
                            final event = controller.filteredEventList[index];
                            return InkWell(
                              onTap: () {
                                controller.getFormattedDate(event.createdDate);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(event.eventName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(event.city),
                                      Text(
                                        controller.getFormattedDate(
                                            event.createdDate),
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  trailing: InkWell(
                                      onTap: () {
                                        // controller.deleteDocument(jadwal.id);
                                      },
                                      child: Icon(Remix.delete_bin_6_line)),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : EmptyState()),
              ],
            )));
  }
}
