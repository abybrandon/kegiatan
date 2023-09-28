import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newtest/widget/toast.dart';

import '../model/costume_rent_model.dart';

class CostumeRentController extends GetxController with StateMixin {
  final CollectionReference cosRentCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('costume')
      .collection('costume_list');

  @override
  void onInit() {
    // fetchData();
    // _pagingController.addPageRequestListener((pageKey) {
    //   fetchPage(pageKey);
    // });
    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<CostumeRentController>();
    super.onClose();
  }

  RxBool tryBool = false.obs;
  //list costume
  RxList<CostumeRentModel> costumeList = <CostumeRentModel>[].obs;
  RxList<CostumeRentModel> filteredCostumeList =
      <CostumeRentModel>[].obs;

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
        final QuerySnapshot snapshot = await cosRentCollection.get();
        final List<CostumeRentModel> fetchedList = snapshot.docs
            .map((doc) =>
                CostumeRentModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        costumeList.value = fetchedList;
        filteredCostumeList.assignAll(costumeList);
      } catch (error) {
        Toast.showErrorToastWithoutContext('Error Get Data');
        print(error.toString());
      }
    }
    change(null, status: RxStatus.success());
  }

  // try pagination
  // final CollectionReference tryPaginationCollection = FirebaseFirestore.instance
  //     .collection('costume')
  //     .doc('costume_rent')
  //     .collection('list_costume');

  // final PagingController<int, DocumentSnapshot> _pagingController =
  //     PagingController(firstPageKey: 1);

  // Future<void> fetchPage(int pageKey) async {
    
  //   change(null, status: RxStatus.loading());
  //   try {
  //     final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await FirebaseFirestore.instance
  //             .collection('costume').doc('costume_rent').collection('list_costume') // Ganti dengan koleksi Anda
  //             .orderBy('your_order_field') // Ganti dengan urutan yang sesuai
  //             .limit(5) // Jumlah data per halaman
  //             .startAfterDocument(_pagingController.itemList!
  //                 .last) // Menggunakan dokumen terakhir dari halaman sebelumnya
  //             .get();

  //     final List<CostumeRentPagination> nextPageData =
  //         querySnapshot.docs.cast<CostumeRentPagination>();
  //     final isLastPage = nextPageData.isEmpty;

  //     if (isLastPage) {
  //       allDataPagingController.appendLastPage(nextPageData);
  //     } else {
  //       final nextPageKey = pageKey + 1;
  //       allDataPagingController.appendPage(nextPageData, nextPageKey);
  //     }
  //     print('getdata');
  //   } catch (error) {
  //     print(error);
  //     _pagingController.error = error;
  //   }
    
  //   change(null, status: RxStatus.success());
  // }

  final PagingController<int, CostumeRentPagination> allDataPagingController =
      PagingController(
    firstPageKey: 1,
  );
}
