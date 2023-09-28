import 'package:get/get.dart';

import '../controller/costume_rent_controller.dart';
class CostumeRentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CostumeRentController());

  }
}
