import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newtest/module/costume/costume_rent/widget/filter_costume_rent.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/universal_appbar.dart';
import 'package:get/get.dart';

import '../../costume_rent/view/costume_rent_list_view.dart';
import '../controller/costume_main_controller.dart';
import '../widget/widget_tabbar.dart';

class CostumeMainView extends GetView<CostumeMainController> {
  const CostumeMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
        statusBarColor: bgWhite,
      ),
      child: Scaffold(
        backgroundColor: bgWhite,
        appBar: AppBarUniversal(
            isSearching: controller.isSearching, title: 'Costume',
            fuctionFilter: () {
                  showModalBottomSheet(
                context: Get.overlayContext!,
                isScrollControlled: true,
                builder: (context) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: Get.height * 0.7),
                    child: FilterCostumeRent(),
                  );
                },
              );
            },
            ),
        body: Column(
          children: [
            WidgetTabCostumeMain(),
          ],
        ),
      ),
    );
  }
}

class WidgetTabCostumeMain extends GetView<CostumeMainController> {
  final RxBool isOn = false.obs;
  WidgetTabCostumeMain({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 1))),
                child: TabBar(
                  indicatorWeight: 0.7,
                  onTap: (value) {},
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: bgRed,
                  unselectedLabelColor: const Color(0xffA0A3BD),
                  labelColor: bgRed,
                  indicatorColor: bgRed,
                  tabs: const [
                    WidgetTabbarDuoTittle(
                      tittle: "Pre-Order / Sell",
                    ),
                    WidgetTabbarDuoTittle(
                      tittle: "Rental",
                    ),
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(
                    
                children: [CostumeRentListView(), CostumeRentListView()],
              ))
            ],
          )),
    );
  }
}
