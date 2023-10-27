import 'package:get/get.dart';

import '../change_password/controller/change_password_controller.dart';
import '../change_username/controller/change_username_controller.dart';
import '../controller/profile_user_controller.dart';
class ProfileUserBinding extends Bindings {
  @override
  void dependencies() {
  
 Get.lazyPut(() => ProfileUserController());
  Get.lazyPut(() => ChangeUsernameController());
  Get.lazyPut(() => ChangePasswordController());
 
   
  }
}
