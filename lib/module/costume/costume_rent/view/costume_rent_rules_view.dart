part of 'costume_rent_detail_view.dart';

class RulesRent extends GetView<CostumeRentDetailController> {
  const RulesRent({super.key});

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
            'RentalAyam',
            style: TextStyle(
                fontSize: 12.sp, color: bgRed, fontWeight: Config.semiBold),
          ),
          Row(
            children: [
              Text(
                'Social Media :',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: basicBlack,
                    fontWeight: Config.medium),
              ),
              4.w.widthBox,
              InkWell(
                onTap: () async {
                  await launchUrl(
                      Uri.parse('https://www.instagram.com/hyper.rentcos'),
                      mode: LaunchMode.externalApplication);
                },
                child: Image.asset(
                  'assets/icon/instagram.png',
                  height: 22.h,
                  width: 22.w,
                ),
              ),
              12.w.widthBox,
              InkWell(
                onTap: () async {
                  await launchUrl(
                      Uri.parse(
                        'https://www.facebook.com/aby.brandon?mibextid=ZbWKwL',
                      ),
                      mode: LaunchMode.externalApplication);
                },
                child: Image.asset(
                  'assets/icon/facebook.png',
                  height: 22.h,
                  width: 22.w,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
