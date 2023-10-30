import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newtest/widget/toast.dart';

class TryDataController extends GetxController with StateMixin {
  RxList<MockApiModel> dataMockapi = <MockApiModel>[].obs;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    getListData();
    super.onInit();
  }

  Future<void> getListData() async {
    change(null, status: RxStatus.loading());
    try {
      const linkData =
          'https://6424f3887ac292e3cff480d8.mockapi.io/example/api/data/';

      final response = await http.get(Uri.parse(linkData));
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body);
        final List<dynamic> dataFinal = dataResponse;

        final dataList =
            dataFinal.map((element) => MockApiModel.fromJson(element)).toList();
        dataMockapi.value = dataList;
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

class MockApiModel {
  final String id;
  final String tittle;
  final String content;

  MockApiModel({required this.id, required this.tittle, required this.content});

  factory MockApiModel.fromJson(Map<String, dynamic> json) {
    return MockApiModel(
        id: json['id'], tittle: json['tittle'], content: json['content']);
  }
}
