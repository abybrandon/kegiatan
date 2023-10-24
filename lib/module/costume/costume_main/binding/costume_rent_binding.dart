import 'package:get/get.dart';

import '../../costume_rent/controller/costume_rent_controller.dart';
import '../../costume_rent/controller/costume_rent_detail_controller.dart';
import '../../costume_rent/widget/filter_costume_rent.dart';
import '../controller/costume_main_controller.dart';

class CostumeBinding extends Bindings {
  @override
  void dependencies() {
    //controller
    Get.lazyPut(() => CostumeRentController());
    Get.lazyPut(() => CostumeMainController());

  Get.lazyPut(() => CostumeRentDetailController());



    //filter
        Get.lazyPut(() => FilterCostumeRentController());

    
  }
}
