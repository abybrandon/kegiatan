import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/try_data_detail_controller.dart';

class TryDataDetail extends GetView<TryDataDetailController> {
  const TryDataDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Try Data Detail')),
        body: controller.obx(
          (state) => Center(
            child: Column(children: [
              Text(
                controller.dataMockapi.value?.id ?? '',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                controller.dataMockapi.value?.tittle ?? '',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                controller.dataMockapi.value?.content ?? '',
                style: TextStyle(fontSize: 20),
              ),
            ]),
          ),
        ));
  }
}
