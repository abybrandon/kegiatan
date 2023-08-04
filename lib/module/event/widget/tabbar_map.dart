part of '../view/event_detail_view.dart';

class _MapsEvent extends GetView<DetailEventController> {
  const _MapsEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgWhite,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Maps Location',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            10.heightBox,
            InkWell(
              child: Container(
                height: 600,
                child: FlutterMap(
                  nonRotatedChildren: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.h),
                        child: InkWell(
                          onTap: () {
                            controller.openMapsSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 4.h),
                            color: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/img/google-maps.png',
                                  height: 15,
                                  width: 15,
                                  fit: BoxFit.contain,
                                ),
                                10.widthBox,
                                Text(
                                  'Get Direction',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    RichAttributionWidget(
                      popupBackgroundColor: Colors.white,
                      animationConfig: const ScaleRAWA(),
                      showFlutterMapAttribution: false,
                      attributions: [
                        TextSourceAttribution('OpenStreetMap contributors',
                            onTap: () {}),
                      ],
                    ),
                  ],
                  options: MapOptions(
                    onPositionChanged: (position, hasGesture) {},
                    maxZoom: 18,
                    minZoom: 13,
                    center:
                        LatLng(controller.latitudeLoc, controller.longitudeLoc),
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      retinaMode: false,
                      keepBuffer: 10,
                      errorTileCallback: (tile, error, stackTrace) =>
                          Get.dialog(_ErrorDialog()),
                      evictErrorTileStrategy:
                          EvictErrorTileStrategy.notVisibleRespectMargin,
                      errorImage: AssetImage('assets/img/google-maps.png'),
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      panBuffer: 10,
                      tileProvider: FMTC.instance('mapStore').getTileProvider(),
                    ),
                    MarkerLayer(markers: [
                      Marker(
                          width: 20.0,
                          height: 20.0,
                          point: LatLng(
                              controller.latitudeLoc, controller.longitudeLoc),
                          builder: (ctx) => Container(
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                              ))
                    ])
                  ],
                ),
              ),
            ),
            10.heightBox,
          ]),
    );
  }
}
