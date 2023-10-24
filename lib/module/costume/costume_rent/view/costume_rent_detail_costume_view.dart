part of 'costume_rent_detail_view.dart';

class DetailCostume extends GetView<CostumeRentDetailController> {
  const DetailCostume({super.key, required this.detail});
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.h.heightBox,
          Text(
            detail,
            style: TextStyle(
                fontWeight: Config.reguler, fontSize: 12.sp, color: basicBlack),
          ),
        ],
      ),
    );
  }
}
