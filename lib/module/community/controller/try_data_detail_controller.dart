
import 'dart:convert';

import 'package:get/get.dart';
import 'package:newtest/module/community/controller/try_data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:newtest/widget/toast.dart';
class TryDataDetailController extends GetxController with StateMixin {
  Rx<MockApiModel?> dataMockapi = Rx<MockApiModel?>(null);



  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    getDetailData(Get.parameters["id"]!);
    super.onInit();
  }

  Future<void> getDetailData(String id) async {
    change(null, status: RxStatus.loading());
    try {
      final linkData =
          'https://6424f3887ac292e3cff480d8.mockapi.io/example/api/data/$id';

      final response = await http.get(Uri.parse(linkData));
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
     
        dataMockapi.value = MockApiModel.fromJson(dataResponse);
      } else {
        Toast.showErrorToastWithoutContext('Failed to get data');
      }
    } catch (e) {
      Toast.showErrorToastWithoutContext('Something error');
      print(e);
    }
    change(null, status: RxStatus.success());
  }
}