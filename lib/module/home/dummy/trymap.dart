// import 'package:newtest/module/home/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:get/get.dart';
// import 'package:maps_launcher/maps_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

// class TryMap extends StatelessWidget {
//   const TryMap({super.key});

// // void openMap() async {
// //   final latitude = 51.509364;
// //   final longitude = -0.128928;
// //   final title = 'London';

// //   try {
// //     final availableMaps = await MapsLauncher.installedMaps;

// //     await MapLauncher.showMarker(
// //       mapType: availableMaps.first,
// //       coords: Coords(latitude, longitude),
// //       title: title,
// //     );
// //   } catch (e) {
// //     print(e.toString());
// //   }
// // }
//   void launchGoogleMapsNavigation(double latitude, double longitude) async {
//     final String googleMapsUrl =
//         'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';

//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       throw 'Could not launch Google Maps';
//     }
//   }

//   final double latitude = -6.248748;
//   final double longitude = 106.9568013;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return DetailScreen(
//                     imageUrl:
//                         'https://codeshack.io/web/img/posts/secure-login-system-php-mysql.png');
//               }));
//             },
//             child: Hero(
//               tag: 'imageHero',
//               child: Image.network(
//                   'https://codeshack.io/web/img/posts/secure-login-system-php-mysql.png'),
//             ),
//           ),
//           ElevatedButton(
//               onPressed: () => MapsLauncher.launchCoordinates(
//                   37.4220041, -122.0862462, 'Google Headquarters are here'),
//               child: Text('Launch lokasi map')),
//           ElevatedButton(
//               onPressed: () {
//                 launchGoogleMapsNavigation(latitude, longitude);
//               },
//               child: Text('GO')),
//           InkWell(
//             child: Container(
//               height: 200,
//               width: 400,
//               child: Expanded(
//                 child: FlutterMap(
//                   options: MapOptions(
//                     center: LatLng(
//                         -6.2122975, 106.8053066), // Koordinat tengah peta

//                     zoom: 13.0, // Tingkat zoom awal
//                   ),
//                   children: [
//                     TileLayer(
//                       urlTemplate:
//                           'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',

//                       subdomains: [
//                         'a',
//                         'b',
//                         'c'
//                       ], // Subdomain yang digunakan oleh tile provider
//                     ),
//                     MarkerLayer(markers: [
//                       Marker(
//                           width: 20.0,
//                           height: 20.0,
//                           point: LatLng(-6.2122975, 106.8053066),
//                           builder: (ctx) => Container(
//                                 child: Icon(
//                                   Icons.location_pin,
//                                   color: Colors.red,
//                                   size: 30.0,
//                                 ),
//                               ))
//                     ])
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DetailScreen extends StatelessWidget {
//   final String imageUrl;

//   const DetailScreen({required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: InteractiveViewer(
//           minScale: 0.5,
//           maxScale: 4.0,
//           child: Hero(
//             tag: 'imageHero',
//             child: Image.network(imageUrl),
//           ),
//         ),
//       ),
//     );
//   }
// }
