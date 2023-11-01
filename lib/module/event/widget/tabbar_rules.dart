part of '../view/event_detail_view.dart';

class _RulesPage extends GetView<DetailEventController> {
  const _RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rules',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
        10.heightBox,
        controller.listRules.isEmpty
            ? Image.asset(
                'assets/img/staytuned.png',
                height: 100.h,
              )
            : Theme(
                data: ThemeData(primaryColor: bgRed),
                child: SizedBox(
                  height: 300.h,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      final data = controller.listRules[index];
                      return AssetPhoto(
                        image: data,
                      );
                    },
                    itemCount: controller.listRules.length,
                    loop: false,
                    pagination: SwiperPagination(
                      builder: SwiperPagination.dots,
                    ),
                  ),
                ),
              ),
        10.h.heightBox,
      ],
    );
  }
}
