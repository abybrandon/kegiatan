import 'package:get/get.dart';

import '../local_storage/local_storage_helper.dart';

class ControllerUniversal extends GetxController {
  //cek prelogin status
  RxBool statusPrelogin = false.obs;

  Future<void> routeName() async {
    int? data = await SharedPreferenceHelper.getDataPrelogin();
    print(data);
    if (data == 1) {
      statusPrelogin.value = true;
    } else {
      statusPrelogin.value = false;
    }
    print(statusPrelogin);
  }

  @override
  void onInit() {
    routeName();
    super.onInit();
  }
}
