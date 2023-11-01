import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/toast.dart';

import '../../../../admin/module/create_costume/model/costume_model.dart';
import '../view/costume_rent_detail_view.dart';

class CostumeRentDetailController extends GetxController with StateMixin {
  @override
  void onInit() {
    change(null, status: RxStatus.loading());

    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<CostumeRentDetailController>();
    super.onClose();
  }

  final Rx<ModelCostume?> costumeRentDetail = Rx<ModelCostume?>(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //data
  String nameCostume = '';
  String charackterName = '';
  String charackterOrigin = '';
  List<String> categoryCostume = [];
  List<String> sizeAvail = [];
  String brandName = '';

  String detailCostume = '';
  String deskripsi = '';
  List<String> listPict = [];
  List<String> listGuestStart = [];
  double latitudeLoc = 0;
  double longitudeLoc = 0;

  List<String> getImages() {
    int desiredLength = 3;

    String placeholderImage =
        'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/uploads%2FnoPhoto.png?alt=media&token=727f17d6-63c3-45e3-948f-d54d6c96b2eb&_gl=1*1nyzdex*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5Nzc2ODE3OC41MS4xLjE2OTc3Njg5MzguMzIuMC4w';

    if (listPict.length < desiredLength) {
      int additionalImagesCount = desiredLength - listPict.length;

      for (int i = 0; i < additionalImagesCount; i++) {
        listPict.add(placeholderImage);
      }
    }

    return listPict;
  }

  Future<void> fetchCostumeRentDetailById(String id) async {
    change(null, status: RxStatus.loading());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.showErrorToastWithoutContext('No Internet Connection');
    } else {
      try {
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('costume')
            .doc('costume')
            .collection('costume_rent')
            .doc(id)
            .get();
        if (snapshot.exists) {
          final dataCostume = ModelCostume.fromJson(snapshot.data()!);

          costumeRentDetail.value = dataCostume;
          nameCostume = dataCostume.nameCostume;
          listPict = dataCostume.listPhotoCostume;
          charackterName = dataCostume.charackterName.name;
          charackterOrigin = dataCostume.charackterOrigin.name;
          categoryCostume = dataCostume.categoryCostume;
          sizeAvail = dataCostume.availSize;
          brandName = dataCostume.brandCostume.name;
          detailCostume = dataCostume.detailCostume;
        } else {
          print('Dokumen tidak ditemukan');
        }
      } catch (e) {
        // Handle error jika terjadi
        print(e.toString());
      }
    }

    change(null, status: RxStatus.success());
  }

  //tabbar

  RxInt selectedButton = 0.obs;

  Widget get tabbarWidget {
    if (selectedButton.value == 0) {
      return DetailCostume(
        detail: detailCostume,
      );
    } else {
      return RulesRent();
    }
  }

  //appbar

  final RxBool isAppBarVisible = false.obs;
  final RxBool isSearching = false.obs;
}
