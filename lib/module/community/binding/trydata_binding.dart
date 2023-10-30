import 'package:get/get.dart';

import '../controller/try_data_controller.dart';
import '../controller/try_data_detail_controller.dart';

class TryDatBinding extends Bindings {
  @override
  void dependencies() {
    //controller
    Get.lazyPut(() => TryDataController());
    Get.lazyPut(() => TryDataDetailController(),fenix: true);
  }
}
