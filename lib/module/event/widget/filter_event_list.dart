import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/admin/module/home_admin/model/artist_event_model.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/date_picker/date_picker.dart';
import 'package:newtest/widget/empty_state.dart';
import 'package:newtest/widget/multi_select/multi_select.dart';
import 'package:newtest/widget/shimmer_effect.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

class FilterEventController extends GetxController with StateMixin {
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
    Get.delete<FilterEventController>();
    super.onClose();
  }

  final List<SelectItem<String>> cityOption = [
    SelectItem(label: 'Kota Jakarta', value: 'Jakarta'),
    SelectItem(label: 'Kota Surabaya', value: 'Surabaya'),
    SelectItem(label: 'Kota Bandung', value: 'Bandung'),
    SelectItem(label: 'Kota Bekasi', value: 'Bekasi'),
    SelectItem(label: 'Kota Medan', value: 'Medan'),
    SelectItem(label: 'Kota Semarang', value: 'Semarang'),
    SelectItem(label: 'Kota Makassar', value: 'Makassar'),
  ];

  final List<SelectItem<String>> locationOption = [
    SelectItem(label: 'Nearest', value: 'Nearest'),
    SelectItem(label: 'Random', value: 'Random'),
    SelectItem(label: 'Hype', value: 'Hype'),
  ];

  final RxList<String> selectedTag = RxList();

  final List<SelectItem<String>> eventOrganizer = [
    SelectItem(label: 'Raf Creatif', value: 'Raf Creatif'),
    SelectItem(label: 'Momiji Gari', value: 'Momiji Gari'),
    SelectItem(label: 'Mukashi', value: 'Momiji Gari'),
  ];

  //date filter

  final RxString selectedDateOption = 'all'.obs;
  final RxList<DateTime> selectedDateRange = RxList();

  void onResetFilter() {
    selectedTag.clear();
    selectedModelTypes.clear();
  }
}

class FilterEventList extends StatefulWidget {
  final void Function(
    List<int> name,
    List<int> brand,
    List<int> model,
    List<String> status,
  )? onApply;

  const FilterEventList({
    super.key,
    this.onApply,
  });

  @override
  State<FilterEventList> createState() => FilterEventListState();
}

class FilterEventListState extends State<FilterEventList> {
  @override
  void initState() {
    // curSelectedAssetname.value = [...controller.selectedAssetname];
    // curSelectedBrand.value = [...controller.selectedBrands];
    // curSelectedModel.value = [...controller.selectedModelTypes];
    // curSelectedStatus.value = [...controller.selectedTag];

    curSelectedDate.value = [...controller.selectedDateRange];
    super.initState();
  }

  void showDateSelector() {
    Get.bottomSheet(
      DateSelector(
        selectedRange: controller.selectedDateOption.value,
        customDateSelected: curSelectedDate.isEmpty ? null : curSelectedDate,
        onApply: (selectedOption, date) {
          controller.selectedDateOption.value = selectedOption;
          curSelectedDate.value = [...(date ?? [])];
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  RxList<DateTime> curSelectedDate = <DateTime>[].obs;

  String get formattedDate {
    if (controller.selectedDateOption.value == 'all') {
      return '-';
    }

    final dateFormat = DateFormat('dd/MM/y');

    return '${dateFormat.format(
      curSelectedDate[0],
    )} - ${dateFormat.format(
      curSelectedDate[1],
    )}';
  }

  RxList<int> curSelectedAssetname = <int>[].obs;
  RxList<int> curSelectedBrand = <int>[].obs;
  RxList<int> curSelectedModel = <int>[].obs;
  RxList<String> curSelectedStatus = <String>[].obs;
  FilterEventController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final filterForm = Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          Obx(
            () => BadgeSelectorField(
              label: 'Short By',
              items: controller.locationOption,
              selectedItems: curSelectedAssetname,
              onSelect: (selectedItems) {
                // curSelectedAssetname.value = [...selectedItems];
              },
            ),
          ),
          12.h.heightBox,
          Obx(
            () => BadgeSelectorField(
              label: 'Event Organizer',
              items: controller.eventOrganizer,
              selectedItems: curSelectedStatus,
              onSelect: (selectedItems) {
                curSelectedStatus.value = [...selectedItems];
              },
            ),
          ),
          SizedBox(height: 12.h),
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
              label: 'City',
              items: controller.cityOption,
              selectedItems: curSelectedStatus,
              onSelect: (selectedItems) {
                curSelectedStatus.value = [...selectedItems];
              },
            ),
          ),
          12.h.heightBox,
          Text(
            'Date',
            style: TextStyle(
              fontSize: 14.sp,
              color: headerWeak,
            ),
          ),
          SizedBox(height: 12.h),
          InkWell(
            onTap: showDateSelector,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.sp,
                    color: generalPlaceholder,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: generalBody,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: showDateSelector,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 15.r,
                    icon: Icon(
                      Remix.calendar_event_fill,
                      color: bgRed,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
