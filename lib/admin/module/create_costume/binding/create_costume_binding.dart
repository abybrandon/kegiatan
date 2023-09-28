import 'package:get/get.dart';

import '../controller/create_costume_controller.dart';


class CreateCostumeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCostumeController());
    
  }
}
