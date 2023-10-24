import 'package:get/get.dart';

import '../controller/create_commun_admin_controller.dart';

class CreateCommunAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCommunAdminController());
  }
}
