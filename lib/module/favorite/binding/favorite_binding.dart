import 'package:get/get.dart';
import 'package:newtest/module/favorite/controller/favorite_controller.dart';

import '../controller/favorite_detail_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());

    Get.lazyPut(() => FavoriteDetailController());
  }
}
