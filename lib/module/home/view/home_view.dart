import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/home/trynotification.dart';
import 'package:newtest/module/home/view/trynavigationbar.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/empty_state.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../../../local_storage/local_storage_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/bottom_sheet_action.dart';
import '../../../widget/custom_multi_select.dart';
import '../controller/home_controller.dart';
import '../createscreen.dart';
import '../showlist_bysearch.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event List'),
          actions: [
            InkWell(
              child: Icon(Icons.logout),
              onTap: () async {
                await SharedPreferenceHelper.removeUserUid();
                Get.offAllNamed(Routes.LOGIN);
              },
            )
          ],
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.EVENT_LIST);
              },
              child: Container(
                height: 20,
                color: bgRed,
                child: Text('go to list event'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await controller.getLocation();
                    print(controller.roleOption);
                  },
                  child: Container(
                    height: 20,
                    width: 90,
                    color: bgRed,
                    child: Text('filter Tanggal'),
                  ),
                ),
                20.widthBox,
                InkWell(
                  onTap: () async {
                    await controller.tryQuery();
                  },
                  child: Container(
                    height: 20,
                    color: bgRed,
                    child: Text('try query'),
                  ),
                ),
                10.widthBox,
                InkWell(
                  onTap: () async {
                    // await controller.tryQuery(
                    //     sortingAtoZ: controller.isSorting.value);
                    // Get.bottomSheet(
                    //   _BulkActionBottomSheet(),
                    //   isScrollControlled: true,
                    //   backgroundColor: Colors.white,
                    // );
                    Get.to(HomePage());

                  },
                  child: Container(
                    height: 20,
                    color: bgRed,
                    child: Text('sorting a to z'),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () async {
                Get.to(ApiScreen());
              },
              child: Container(
                height: 20,
                color: bgRed,
                child: Text('coba notification'),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    await controller.tryQuery(
                        sortingAtoZ: controller.isSorting.value,
                        cityFilter: 'Bekasi');
                  },
                  child: Container(
                    height: 20,
                    color: bgRed,
                    child: Text('Filter By Kota'),
                  ),
                ),
                10.widthBox,
                InkWell(
                  onTap: () async {
                    Get.to(Create_Screen());
                  },
                  child: Container(
                    height: 20,
                    color: bgRed,
                    child: Text('Created Data'),
                  ),
                ),
                10.widthBox,
                InkWell(
                  onTap: () async {
                    // controller.takeDate(context);
                  },
                  child: Container(
                    height: 20,
                    color: bgRed,
                    child: Text('Pilih tanggal'),
                  ),
                ),
                10.widthBox,
                InkWell(
                  onTap: () {
                    Get.to(Showlistrange());
                  },
                  child: Container(
                    height: 20,
                    color: bgRed,
                    child: Text('Search'),
                  ),
                ),
              ],
            ),
            RoleSelectorMulti(
              tittle: Text(
                'Pick Location',
                style: TextStyle(
                    fontSize: 12.sp,
                    overflow: TextOverflow.clip,
                    color: generalLabel,
                    fontWeight: FontWeight.w400),
              ),
              label: 'Daftar Kota',
              items: controller.roleOption,
              onSelect: (selectedItems) {
                print(selectedItems);
                // controller.selectedSystemRole.value =
                //     selectedItems.map((e) => e.id).toList();
                // controller.tittleFormSystemRole.value = selectedItems
                //     .map((e) => e.name)
                //     .toList()
                //     .toString()
                //     .replaceAll('[', '')
                //     .replaceAll(']', '');
              },
            ),
            Obx(() => controller.jadwalList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: controller.jadwalList.length,
                      itemBuilder: (context, index) {
                        final jadwal = controller.jadwalList[index];
                        return InkWell(
                          onTap: () {
                            controller.getFormattedDate(jadwal.createdDate);
                          },
                          child: ListTile(
                            title: Text(jadwal.tryValue1),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(jadwal.tryValue2),
                                Text(
                                  controller
                                      .getFormattedDate(jadwal.createdDate),
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            trailing: InkWell(
                                onTap: () {
                                  controller.deleteDocument(jadwal.id);
                                },
                                child: Icon(FeatherIcons.delete)),
                          ),
                        );
                      },
                    ),
                  )
                : EmptyState()),
          ],
        ));
  }
}

class _BulkActionBottomSheet extends StatelessWidget {
  const _BulkActionBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 16.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            title: 'Active',
            icon: Remix.check_line,
            iconColor: bgBlue,
            onTap: () {
              // Get.dialog(const _BulkDeleteConfirmDialog());
            },
          ),
          BottomSheetAction(
            title: 'Inactive',
            icon: Remix.close_line,
            iconColor: bgBlue,
            onTap: () {
              // Get.dialog(const _BulkDeleteConfirmDialog());
            },
          ),
          BottomSheetAction(
            title: 'Delete',
            titleColor: dangerDefault,
            icon: Remix.delete_bin_6_line,
            iconColor: dangerDefault,
            onTap: () {
              // Get.dialog(const _BulkDeleteConfirmDialog());
            },
          ),
        ],
      ),
    );
  }
}
