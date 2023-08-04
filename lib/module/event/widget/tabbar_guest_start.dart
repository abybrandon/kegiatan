part of '../view/event_detail_view.dart';

class _GuestStartPage extends GetView<DetailEventController> {
  const _GuestStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Guest Start',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        10.heightBox,
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: controller.listGuestStart.map((e) => Text(e)).toList()),
      ],
    );
  }
}
