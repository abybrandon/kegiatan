import 'package:get/get.dart';

import '../controller/community_controller.dart';
import '../controller/community_detail_controller.dart';

class CommunityBinding extends Bindings {
  @override
  void dependencies() {
    //controller
    Get.lazyPut(() => CommunityController());
    Get.lazyPut(() => CommunityDetailController());
  }
}
