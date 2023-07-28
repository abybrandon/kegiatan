import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';

import '../controller/detail_event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());

    Get.lazyPut(() => DetailEventController());
  }
}
