import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/admin/module/home_admin/model/artist_event_model.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/empty_state.dart';
import 'package:newtest/widget/multi_select/multi_select.dart';
import 'package:newtest/widget/shimmer_effect.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

class FilterAssignController extends GetxController with StateMixin {
  //city option

  final CollectionReference artistEventCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('events')
      .collection('artist');

  Future<void> getArtistEventModel() async {
    change(null, status: RxStatus.loading());
    try {
      final QuerySnapshot snapshot = await artistEventCollection.get();
      final List<ArtistEventModel> fetchedArtist = snapshot.docs
          .map((doc) =>
              ArtistEventModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      allArtist.value = fetchedArtist;
    } catch (error) {
      print(error.toString());
    }
    change(null, status: RxStatus.success());
  }

  final RxList<ArtistEventModel> allArtist = RxList();
  final RxList<String> selectedModelTypes = RxList();

  List<SelectItem<String>> get artistOption {
    return allArtist.map(
      (data) {
        return SelectItem(
          label: data.nameArtist,
          value: data.nameArtist,
        );
      },
    ).toList();
  }

  @override
  void onInit() {
    getArtistEventModel();
    super.onInit();
  }

  // void fetchAll() async {
  //   try {
  //     await Future.wait(
  //       [fetchBrands(), fetchModel(), listAssetType()],
  //       eagerError: true,
  //     ).then(
  //       (_) {
  //         change(
  //           null,
  //           status: RxStatus.success(),
  //         );
  //       },
  //     );
  //   } on Exception {
  //     change(null, status: RxStatus.error());
  //   }
  // }

  @override
  void onClose() {
    Get.delete<FilterAssignController>();
    super.onClose();
  }

final List<SelectItem<String>> cityOption = [
  SelectItem(label: 'Jakarta', value: 'Jakarta'),
  SelectItem(label: 'Surabaya', value: 'Surabaya'),
  SelectItem(label: 'Bandung', value: 'Bandung'),
  SelectItem(label: 'Bekasi', value: 'Bekasi'),
  SelectItem(label: 'Medan', value: 'Medan'),
  SelectItem(label: 'Semarang', value: 'Semarang'),
  SelectItem(label: 'Makassar', value: 'Makassar'),
];


  final RxList<String> selectedTag = RxList();

  void onResetFilter() {
    selectedTag.clear();
    selectedModelTypes.clear();
  }
}

class FilterAssignAsset extends StatefulWidget {
  final void Function(
    List<int> name,
    List<int> brand,
    List<int> model,
    List<String> status,
  )? onApply;

  const FilterAssignAsset({
    super.key,
    this.onApply,
  });

  @override
  State<FilterAssignAsset> createState() => FilterAssignAssetState();
}

class FilterAssignAssetState extends State<FilterAssignAsset> {
  @override
  void initState() {
    // curSelectedAssetname.value = [...controller.selectedAssetname];
    // curSelectedBrand.value = [...controller.selectedBrands];
    // curSelectedModel.value = [...controller.selectedModelTypes];
    // curSelectedStatus.value = [...controller.selectedTag];
    super.initState();
  }

  RxList<int> curSelectedAssetname = <int>[].obs;
  RxList<int> curSelectedBrand = <int>[].obs;
  RxList<int> curSelectedModel = <int>[].obs;
  RxList<String> curSelectedStatus = <String>[].obs;

  FilterAssignController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final filterForm = Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          Obx(
            () => BadgeSelectorField(
              label: 'Artist',
              items: controller.artistOption,
              selectedItems: curSelectedAssetname,
              onSelect: (selectedItems) {
                // curSelectedAssetname.value = [...selectedItems];
              },
            ),
          ),
          12.h.heightBox,
          Obx(
            () => BadgeSelectorField(
              label: 'Status',
              items: controller.cityOption,
              selectedItems: curSelectedStatus,
              onSelect: (selectedItems) {
                curSelectedStatus.value = [...selectedItems];
              },
            ),
          ),
          12.h.heightBox,
        ],
      ),
    ));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 24.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: headerWeak,
                ),
              ),
              InkWell(
                onTap: () {
                  curSelectedAssetname.clear();
                  curSelectedBrand.clear();

                  curSelectedModel.clear();
                  curSelectedStatus.clear();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: headerWeak,
                  ),
                ),
              )
            ],
          ),
        ),
        12.h.heightBox,
        controller.obx(
          (state) {
            return filterForm;
          },
          onLoading: const Expanded(child: _FilterLoading()),
          onError: (_) => const Expanded(
            child: EmptyState(),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 24.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 1.sp,
                color: generalLine,
              ),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1.h),
                blurRadius: 10.r,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: bgRed),
            onPressed: () {
              if (widget.onApply != null) {
                widget.onApply!(curSelectedAssetname, curSelectedBrand,
                    curSelectedModel, curSelectedStatus);
                // controller.selectedAssetname.value = [...curSelectedAssetname];
                // controller.selectedBrands.value = [...curSelectedBrand];
                // controller.selectedModelTypes.value = [...curSelectedModel];
                // controller.selectedTag.value = [...curSelectedStatus];
              }

              Get.back();
            },
            child: Text(
              'Apply',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterLoading extends StatelessWidget {
  const _FilterLoading();

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 12.sp),
            child: const Text(
              'Name',
              style: TextStyle(color: headerWeak),
            ),
          ),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.filled(5, 0)
                .map(
                  (_) => ShimmerEffect(
                    width: random.nextInt(30) + 70,
                    height: 30,
                    radius: 12,
                  ),
                )
                .toList(),
          ),
          12.h.heightBox,
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 12.sp),
            child: const Text(
              'Brand',
              style: TextStyle(color: headerWeak),
            ),
          ),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.filled(5, 0)
                .map(
                  (_) => ShimmerEffect(
                    width: random.nextInt(30) + 70,
                    height: 30,
                    radius: 12,
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 12.h),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 12.sp),
            child: const Text(
              'Model/Type',
              style: TextStyle(color: headerWeak),
            ),
          ),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.filled(5, 0)
                .map(
                  (_) => ShimmerEffect(
                    width: random.nextInt(30) + 70,
                    height: 30,
                    radius: 12,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
