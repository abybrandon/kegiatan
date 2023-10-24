part of '../view/event_detail_view.dart';

class _DescriptionPage extends GetView<DetailEventController> {
  const _DescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
        10.heightBox,
        Text(
          controller.deskripsi,
          style: TextStyle(fontWeight: Config.reguler, fontSize: 12.sp, color: basicBlack),
        ),
      ],
    );
  }
}
