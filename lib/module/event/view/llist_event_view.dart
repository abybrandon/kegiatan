import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';
import 'package:newtest/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../../../widget/empty_state.dart';

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
