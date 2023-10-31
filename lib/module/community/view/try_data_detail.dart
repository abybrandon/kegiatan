import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/try_data_detail_controller.dart';

class TryDataDetail extends StatefulWidget {
  TryDataDetail({super.key});

  @override
  State<TryDataDetail> createState() => _TryDataDetailState();
}

class _TryDataDetailState extends State<TryDataDetail> {
  final controller = Get.find<TryDataDetailController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getDetailData(Get.parameters["id"]!);
    });
    super.initState();
  }

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
