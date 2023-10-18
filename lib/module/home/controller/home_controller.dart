import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxBool isAppBarVisible = false.obs;

  final searchController = TextEditingController();
  RxString searchText = ''.obs;
  List dataCity = [
    'Jakarta',
    'Bekasi',
    'Bogor',
    'Tangerang',
    'Depok',
    'Bengkulu',
    'Yogyakarta',
    'Karawang',
    'Banten'
  ];

  List<Map<String, dynamic>> dataEvent = [
    {
      'eventName': 'Impactnation Japanfest Indonesia',
      'dateEvent': '23 September 2023',
      'city': 'Jakarta',
      'image': 'festImage.png',
      'totalLiked': 20
    },
    {
      'eventName': 'Momijigadi Shirayuki',
      'dateEvent': '13 Desember 2023',
      'city': 'Jakarta',
      'image': 'festImage2.png',
      'totalLiked': 20
    },
    {
      'eventName': 'Jakjapan Matsuri',
      'dateEvent': '2 September 2023',
      'city': 'Jakarta',
      'image': 'festimage4.png',
      'totalLiked': 20
    },
    {
      'eventName': 'Jiyuu Matsuri 2023',
      'dateEvent': '5 juli 2023',
      'city': 'Bengkulu',
      'image': 'festImage.png',
      'totalLiked': 20
    },
  ];

  List<Map<String, dynamic>> dataCostume = [
    {
      'nameCostume': 'Costume Hutao Genshin Impact',
      'charackterOrigin': 'Genshin Impact',
      'priceRent': {'rentDay': 3, 'rentPrice': '100.000'},
      'categoryCostume': ['Game', 'Genshin'],
      'location': 'Jakarta',
      'image': 'costumePeg.png',
    },
    {
      'nameCostume': 'Costume Uta One Piece',
      'charackterOrigin': 'One Piece',
      'priceRent': {'rentDay': 3, 'rentPrice': '200.000'},
      'categoryCostume': ['Game', 'One Piece'],
      'location': 'Tangerang',
      'image': 'costumePeg2.png',
    },
    {
      'nameCostume': 'Costume Klee Genshin Impact',
      'charackterOrigin': 'Genshin Impact',
      'priceRent': {'rentDay': 3, 'rentPrice': '100.000'},
      'categoryCostume': ['Game', 'Genshin'],
      'location': 'Jakarta',
      'image': 'costumePeg3.png',
    },
    {
      'nameCostume': 'Costume Hutao Genshin Impact',
      'charackterOrigin': 'Genshin Impact',
      'priceRent': {'rentDay': 3, 'rentPrice': '100.000'},
      'categoryCostume': ['Game', 'Genshin'],
      'location': 'Jakarta',
      'image': 'costumePeg.png',
    },
  ];
}
