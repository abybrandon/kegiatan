import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../routes/app_pages.dart';
import '../../event/model/event_detail_model.dart';
import '../controller/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgRed,
      ),
      body: _BodyFavorit(),
    );
  }
}

class _BodyFavorit extends StatefulWidget {
  _BodyFavorit({super.key});

  @override
  _BodyFavoritState createState() => _BodyFavoritState();
}

final controller = Get.find<FavoriteController>();

class _BodyFavoritState extends State<_BodyFavorit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<EventDetailModel>>(
          future: controller.getSavedEventList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final savedEventList2 = snapshot.data ?? [];
              return Expanded(
                child: GridView.builder(
                  itemCount: savedEventList2.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Jumlah kolom pada grid
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 10.h,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final event = savedEventList2[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.FAVORITE_Detail,
                            parameters: {'id': event.id});
                        //       final tryList = savedEventList2
                        //     .firstWhere((element) => element.id == event.id);
                        // print(tryList.eventName);
                      },
                      child: Stack(
                        children: [
                          Card(
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  height: 170,
                                  imageUrl: event.eventPict[0],
                                  fit: BoxFit.contain,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                4.h.heightBox,
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(event.eventName),
                                        Text(
                                          controller.getFormattedDate(
                                              event.createdDate),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.w,
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Remix.heart_fill,
                                  color: generalGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
