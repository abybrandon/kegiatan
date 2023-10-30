part of '../view/profile_user_view.dart';
class _SingleActionLikedContent extends StatelessWidget {
  const _SingleActionLikedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 20.w,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Remix.heart_2_fill, color: bgRed, size: 20.sp,),
                12.w.widthBox,
                Text(
                  'Liked Content',
                  style: TextStyle(
                      color: bgRed, fontWeight: Config.semiBold, fontSize: 16.sp),
                ),
              ],
            ),
            20.h.heightBox,
            BottomSheetAction(
              title: 'Liked Event',
              icon: Remix.file_info_line,
              iconColor: bgRed,
              imagePath: 'assets/img/gate.png',
              onTap: () {
                Get.back();
              },
            ),
            BottomSheetAction(
              title: 'Liked Costume',
              icon: Remix.shirt_line,
              imagePath: 'assets/img/costume.png',
              iconColor: bgRed,
              onTap: () {
                Get.back();
              },
            ),
            BottomSheetAction(
              title: 'Liked Community',
              imagePath: 'assets/img/comunt.png',
              icon: Remix.file_info_line,
              iconColor: bgRed,
              onTap: () {
                Get.back();
              },
            ),
          ]),
    );
  }
}
