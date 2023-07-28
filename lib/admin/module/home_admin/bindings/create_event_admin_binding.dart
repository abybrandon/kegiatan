import 'package:get/get.dart';

import '../controller/create_artist_admin_controller.dart';
import '../controller/create_event_admin_controller.dart';

class CreateEventAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateEventAdminController());
    Get.lazyPut(() => CreateArtistAdminController());
  }
}
