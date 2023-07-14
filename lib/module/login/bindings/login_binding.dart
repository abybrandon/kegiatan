import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoignBinding extends Bindings{
  @override
  void dependencies() {
 
 Get.lazyPut(() => LoginController());
  }

}