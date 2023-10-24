import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newtest/widget/toast.dart';

import '../model/costume_rent_model.dart';

class CostumeRentController extends GetxController with StateMixin {
  final CollectionReference cosRentCollection = FirebaseFirestore.instance
      .collection('costume')
      .doc('costume')
      .collection('costume_rent');

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<CostumeRentController>();
    super.onClose();
  }

  //listdata
  RxList<ModelCostume> dataList = <ModelCostume>[].obs;

  RxList<ModelCostume> filtereddataList = <ModelCostume>[].obs;
  
  final RxList<String> likeddataList = <String>[].obs;

  String  isBooked (bool isTrue){
    if(isTrue){
      return 'Ready';
    }else{
      return 'Booked';
    }
  }

  //fetch data
  Future<void> fetchData() async {
    change(null, status: RxStatus.loading());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      change(null, status: RxStatus.loading());

      Toast.showErrorToastWithoutContext('No Internet Connection');
      print('jalan');
    } else {
      try {
        final QuerySnapshot snapshot = await cosRentCollection
            .orderBy('createdDate', descending: true)
            .get();
        final List<ModelCostume> fetcheddatas = snapshot.docs
            .map((doc) =>
                ModelCostume.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        dataList.value = fetcheddatas;
        filtereddataList.assignAll(dataList);
      } catch (error) {
        Toast.showErrorToastWithoutContext('Error Get Data');
        print(error.toString());
      }
    }
    change(null, status: RxStatus.success());
  }

  //appbar

  final RxBool isSearching = false.obs;
}
