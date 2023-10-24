import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/admin/module/create_costume/model/category_costume_model.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/empty_state.dart';
import 'package:newtest/widget/multi_select/multi_select.dart';
import 'package:newtest/widget/shimmer_effect.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

class FilterCostumeRentController extends GetxController with StateMixin {
  //city option

  final CollectionReference brandCostumeCollection = FirebaseFirestore.instance
      .collection('costume')
      .doc('brand')
      .collection('list_brand');

  Future<void> getBrandCostume() async {
    change(null, status: RxStatus.loading());
    try {
      final QuerySnapshot snapshot = await brandCostumeCollection.get();
      final List<CategoryModel> fetchedArtist = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      allArtist.value = fetchedArtist;
    } catch (error) {
      print(error.toString());
    }
    change(null, status: RxStatus.success());
  }

  final RxList<CategoryModel> allArtist = RxList();
  final RxList<String> selectedModelTypes = RxList();

  List<SelectItem<String>> get artistOption {
    return allArtist.map(
      (data) {
        return SelectItem(
          label: data.name,
          value: data.name,
        );
      },
    ).toList();
  }

  @override
  void onInit() {
    getBrandCostume();
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
    Get.delete<FilterCostumeRentController>();
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

  final List<SelectItem<String>> statusOption = [
    SelectItem(label: 'Ready', value: 'Ready'),
    SelectItem(label: 'Booked', value: 'Booked'),
  ];

  final List<SelectItem<String>> genreOption = [
    SelectItem(label: 'Anime', value: 'Anime'),
    SelectItem(label: 'Game', value: 'Game'),
    SelectItem(label: 'Disney', value: 'Disney'),
    SelectItem(label: 'Original', value: 'Original'),
  ];

final List<SelectItem<String>> animeOption = [
    SelectItem(label: 'Naruto', value: 'Naruto'),
    SelectItem(label: 'One Piece', value: 'One Piece'),
    SelectItem(label: 'Attack on Titan', value: 'Attack on Titan'),
    SelectItem(label: 'Dragon Ball Z', value: 'Dragon Ball Z'),
    SelectItem(label: 'Death Note', value: 'Death Note'),
    SelectItem(label: 'Fullmetal Alchemist: Brotherhood', value: 'Fullmetal Alchemist: Brotherhood'),
    SelectItem(label: 'My Hero Academia', value: 'My Hero Academia'),
    SelectItem(label: 'Cowboy Bebop', value: 'Cowboy Bebop'),
    SelectItem(label: 'One Punch Man', value: 'One Punch Man'),
    SelectItem(label: 'Hunter x Hunter', value: 'Hunter x Hunter'),
    SelectItem(label: 'Bleach', value: 'Bleach'),
    SelectItem(label: 'Sword Art Online', value: 'Sword Art Online'),
    SelectItem(label: 'Neon Genesis Evangelion', value: 'Neon Genesis Evangelion'),
    SelectItem(label: 'Code Geass', value: 'Code Geass'),
    SelectItem(label: 'Fairy Tail', value: 'Fairy Tail'),
    SelectItem(label: 'Steins;Gate', value: 'Steins;Gate'),
    SelectItem(label: 'Black Clover', value: 'Black Clover'),
    SelectItem(label: 'Demon Slayer: Kimetsu no Yaiba', value: 'Demon Slayer: Kimetsu no Yaiba'),
    SelectItem(label: 'Tokyo Ghoul', value: 'Tokyo Ghoul'),
   
];
  final RxList<String> selectedTag = RxList();

  void onResetFilter() {
    selectedTag.clear();
    selectedModelTypes.clear();
  }
}

class FilterCostumeRent extends StatefulWidget {
  final void Function(
    List<int> name,
    List<int> brand,
    List<int> model,
    List<String> status,
  )? onApply;

  const FilterCostumeRent({
    super.key,
    this.onApply,
  });

  @override
  State<FilterCostumeRent> createState() => FilterCostumeRentState();
}

class FilterCostumeRentState extends State<FilterCostumeRent> {
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

  FilterCostumeRentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final filterForm = Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          Obx(
            () => BadgeSelectorField(
              label: 'Status',
              items: controller.statusOption,
              selectedItems: curSelectedStatus,
              onSelect: (selectedItems) {
                curSelectedStatus.value = [...selectedItems];
              },
            ),
          ),
          12.h.heightBox,
          Obx(
            () => BadgeSelectorField(
              label: 'Brand',
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
              label: 'Genre',
              items: controller.genreOption,
              selectedItems: curSelectedAssetname,
              onSelect: (selectedItems) {
                // curSelectedAssetname.value = [...selectedItems];
              },
            ),
          ),
          12.h.heightBox,
           Obx(
            () => BadgeSelectorField(
              label: 'Anime',
              items: controller.animeOption,
              selectedItems: curSelectedAssetname,
              onSelect: (selectedItems) {
                // curSelectedAssetname.value = [...selectedItems];
              },
            ),
          ),
          12.h.heightBox,
          Obx(
            () => BadgeSelectorField(
              label: 'Location',
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
