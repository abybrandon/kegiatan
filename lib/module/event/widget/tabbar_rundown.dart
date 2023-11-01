part of '../view/event_detail_view.dart';

class _RundownPage extends GetView<DetailEventController> {
  const _RundownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rundown',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
        10.heightBox,
        controller.listRundown.isEmpty
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
                      final data = controller.listRundown[index];
                      return AssetPhoto(
                        image: data,
                      );
                    },
                    itemCount: controller.listRundown.length,
                    loop: false,
                    pagination: SwiperPagination(
                      builder: SwiperPagination.dots,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
