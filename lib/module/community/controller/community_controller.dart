import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/toast.dart';

import '../datasource/community_datasource.dart';
import '../model/community_list_model.dart';

class CommunityController extends GetxController with StateMixin {
  CommunityCollections firestoreCollections = CommunityCollections();

  @override
  void onClose() {
    Get.delete<CommunityController>();
    super.onClose();
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    fetchData();

    super.onInit();
  }

  //list communt
  RxList<CommunityListModel> communList = <CommunityListModel>[].obs;
  RxList<CommunityListModel> filteredComunList = <CommunityListModel>[].obs;

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
        final QuerySnapshot snapshot = await firestoreCollections
            .communityCollection
            .orderBy('createdDate', descending: true)
            .get();
        final List<CommunityListModel> fetchedData = snapshot.docs
            .map((doc) =>
                CommunityListModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        communList.value = fetchedData;
        filteredComunList.assignAll(communList);
      } catch (error) {
        Toast.showErrorToastWithoutContext('Error Get Data');
        print(error.toString());
      }
    }
    change(null, status: RxStatus.success());
  }

  final RxBool isSearching = false.obs;
}
