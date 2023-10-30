import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/routes/app_pages.dart';

import '../controller/try_data_controller.dart';

class TryDataList extends GetView<TryDataController> {
  const TryDataList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('try data')),
      body: controller.obx((state) => ListView.builder(
            itemCount: controller.dataMockapi.length,
            itemBuilder: (context, index) {
              final data = controller.dataMockapi[index];
              return Padding(
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                        Get.toNamed(Routes.COSTUME_RENT_DETAIL,parameters: {'id' : data.id});
                  },
                  child: Card(
                      child: Column(
                    children: [
                      Text(data.id),
                      Text(data.tittle),
                      Text(data.content),
                    ],
                  )),
                ),
              );
            },
          )),
    );
  }
}
