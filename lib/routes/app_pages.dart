import 'package:newtest/admin/module/home_admin/view/create_event_admin.dart';
import 'package:newtest/module/event/bindings/event_binding.dart';
import 'package:newtest/module/favorite/binding/favorite_binding.dart';
import 'package:newtest/module/home/view/home_view2.dart';
import 'package:newtest/module/login/bindings/login_binding.dart';
import 'package:get/get.dart';
import 'package:newtest/module/signup/view/sign_up_view.dart';

import '../admin/module/home_admin/bindings/create_event_admin_binding.dart';
import '../admin/module/home_admin/view/create_artist_admin_view.dart';
import '../admin/module/home_admin/view/menu_admin.dart';
import '../module/event/view/event_detail_view.dart';
import '../module/event/view/llist_event_view.dart';
import '../module/favorite/view/favorite_detail.dart';
import '../module/favorite/view/favorite_view.dart';
import '../module/home/bindings/home_binding.dart';
import '../module/home/home_screen.dart';
import '../module/home/view/home_view.dart';
import '../module/login/view/login_view.dart';
import '../module/prelogin/binding/prelogin_binding.dart';
import '../module/prelogin/view/prelogin_view.dart';
import '../module/signup/binding/sign_up_binding.dart';
import '../navigation_bar.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: Routes.PRE_LOGIN,
        page: () => const PreLoginView(),
        binding: PreLoginBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginView(), binding: LoignBinding()),
    GetPage(
        name: Routes.SIGN_UP,
        page: () => SignUpView(),
        binding: SignUpBinding()),

    GetPage(name: Routes.HOME, page: () => HomeView(), binding: HomeBinding()),

    //event list
    GetPage(
        name: Routes.EVENT_LIST,
        page: () => ListEventView(),
        binding: EventBinding()),
    GetPage(
        name: Routes.EVENT_DETAIL,
        page: () => EventDetailView(),
        binding: EventBinding()),

    //ADMIN
    //create event
    GetPage(
        name: Routes.CREATE_EVENT_ADMIN,
        page: () => CreateEventAdmin(),
        binding: CreateEventAdminBinding()),

    //create artist
    GetPage(
        name: Routes.CREATE_ARTIST_ADMIN,
        page: () => CreateArtistAdminView(),
        binding: CreateEventAdminBinding()),

    //favorite user
    GetPage(
        name: Routes.FAVORITE,
        page: () => FavoriteView(),
        binding: FavoriteBinding()),

    //favorite detail
    GetPage(
        name: Routes.FAVORITE_Detail,
        page: () => FavoriteDetail(),
        binding: FavoriteBinding()),

    //navigation home
    GetPage(
        name: Routes.NAVIGATION_BAR,
        page: () => NavigationBar(),
        bindings: [
          HomeBinding(),
          CreateEventAdminBinding(),
          FavoriteBinding()
        ],
        children: [
          GetPage(
            name: Routes.HOME2,
            page: () => HomeView2(),
          ),
          GetPage(
              name: Routes.FAVORITE,
              page: () => FavoriteView(),
              binding: FavoriteBinding()),
          GetPage(
              name: Routes.HOME,
              page: () => HomeView(),
              bindings: [HomeBinding()]),
          GetPage(
              name: Routes.MENU_ADMIN,
              page: () => MenuAdmin(),
              binding: CreateEventAdminBinding()),
        ]),
  ];
}
