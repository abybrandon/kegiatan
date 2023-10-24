part of '../view/event_detail_view.dart';

class _GuestStartPage extends GetView<DetailEventController> {
  const _GuestStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Guest Start',
            style: TextStyle(fontWeight: Config.semiBold, fontSize: 14.sp, color: basicBlack)),
        10.heightBox,
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: controller.listGuestStart.map((e) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Icon(Remix.star_fill, color: bgRed,), 10.w.widthBox,
                  Text(e),
                ],
              ),
            )).toList()),
      ],
    );
  }
}
