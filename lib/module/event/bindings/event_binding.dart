import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';
import 'package:newtest/module/event/widget/filter_event_list.dart';

import '../controller/detail_event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());

    Get.lazyPut(() => DetailEventController(),fenix: true);

    //filter
    Get.lazyPut(() => FilterEventController());
  }
}
