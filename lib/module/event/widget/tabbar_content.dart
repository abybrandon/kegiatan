part of '../view/event_detail_view.dart';

class _ContentPage extends GetView<DetailEventController> {
  const _ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Content',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
        10.heightBox,
        Obx(() => controller.listContent.isNotEmpty
            ? Column(
                children: List.generate(controller.listContent.length, (index) {
                  final data = controller.listContent[index];
                  return ExpandableWidget(
                      tittle: data.name,
                      widget: Column(
                        children: [
                          AssetPhoto(
                            image: data.pict,
                            height: 150.h,
                            width: double.infinity,
                          ),
                          8.h.heightBox,
                          Text(data.detail),
                        ],
                      ));
                }),
              )
            : Image.asset(
                'assets/img/staytuned.png',
                height: 100.h,
              ))
      ],
    );
  }
}
