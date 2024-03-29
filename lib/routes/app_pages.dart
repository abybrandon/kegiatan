import 'package:newtest/admin/module/home_admin/view/create_event_admin.dart';
import 'package:newtest/module/community/view/community_detail_view.dart';
import 'package:newtest/module/costume/costume_main/binding/costume_rent_binding.dart';
import 'package:newtest/module/event/bindings/event_binding.dart';
import 'package:newtest/module/favorite/binding/favorite_binding.dart';
import 'package:newtest/module/home/view/home_view.dart';
import 'package:newtest/module/login/bindings/login_binding.dart';
import 'package:get/get.dart';
import 'package:newtest/module/signup/view/sign_up_view.dart';

import '../admin/module/create_community/bindings/create_commun_admin_binding.dart';
import '../admin/module/create_community/view/create_commun_admin_view.dart';
import '../admin/module/create_costume/binding/create_costume_binding.dart';
import '../admin/module/create_costume/view/create_costume_rent_view.dart';
import '../admin/module/home_admin/bindings/create_event_admin_binding.dart';
import '../admin/module/home_admin/view/create_artist_admin_view.dart';
import '../admin/module/home_admin/view/menu_admin.dart';
import '../module/community/binding/community_binding.dart';
import '../module/community/view/community_list_view.dart';
import '../module/costume/costume_main/view/costume_main_view.dart';
import '../module/costume/costume_rent/view/costume_rent_detail_view.dart';
import '../module/event/view/event_detail_view.dart';
import '../module/event/view/llist_event_view.dart';
import '../module/favorite/view/favorite_detail.dart';
import '../module/favorite/view/favorite_view.dart';
import '../module/home/bindings/home_binding.dart';
import '../module/home/dummy/home_view.dart';
import '../module/login/view/login_view.dart';
import '../module/prelogin/binding/prelogin_binding.dart';
import '../module/prelogin/view/prelogin_view.dart';
import '../module/profile_user/binding/profile_user_binding.dart';
import '../module/profile_user/change_password/view/change_password_view.dart';
import '../module/profile_user/change_username/view/change_username_view.dart';
import '../module/profile_user/view/profile_user_view.dart';
import '../module/reminder/binding/reminder_binding.dart';
import '../module/reminder/view/reminder_view.dart';
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

    //create costume rent
    GetPage(
        name: Routes.CREATE_COSTUME_RENT,
        page: () => CreateCostumeRentView(),
        binding: CreateCostumeBinding()),

    //create artist
    GetPage(
        name: Routes.CREATE_ARTIST_ADMIN,
        page: () => CreateArtistAdminView(),
        binding: CreateEventAdminBinding()),

    //menu admin
    GetPage(
        name: Routes.MENU_ADMIN,
        page: () => MenuAdmin(),
        binding: CreateEventAdminBinding()),

    //create commun
    GetPage(
        name: Routes.CREATE_COMMUNITY,
        page: () => CreateCommunAdminView(),
        binding: CreateCommunAdminBinding()),

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

    //costume
    //costume rent
    GetPage(
        name: Routes.COSTUME_RENT,
        page: () => CostumeMainView(),
        binding: CostumeBinding()),
   
    //costume detail rent
    GetPage(
        name: Routes.COSTUME_RENT_DETAIL,
        page: () => CostumeRentDetailView(),
        binding: CostumeBinding()),

    //community
     GetPage(
        name: Routes.COMMUNITY_LIST,
        page: () => CommunityListView(),
        binding: CommunityBinding()),
    
    //community detail
         GetPage(
        name: Routes.COMMUNITY_DETAIL,
        page: () => CommunityDetailView(),
        binding: CommunityBinding()),
    

    //profile user
    //change username
      GetPage(
              name: Routes.CHANGE_USERNAME,
              page: () => ChangeUsernameView(),
              binding: ProfileUserBinding()),
    //change password
     GetPage(
              name: Routes.CHANGE_PASSWORD,
              page: () => ChangePasswordView(),
              binding: ProfileUserBinding()),


    //navigation home
    GetPage(
        name: Routes.NAVIGATION_BAR,
        page: () => NavigationBar(),
        bindings: [
          HomeBinding(),
          FavoriteBinding(),
          ReminderBinding(),
          ProfileUserBinding()
        ],
        children: [
          GetPage(
            name: Routes.HOME2,
            page: () => HomeView(),
          ),
          // GetPage(
          //     name: Routes.FAVORITE,
          //     page: () => FavoriteView(),
          //     binding: FavoriteBinding()),
          GetPage(
              name: Routes.REMINDER,
              page: () => ReminderView(),
              bindings: [ReminderBinding()]),
          GetPage(
              name: Routes.HOME,
              page: () => HomeView(),
              bindings: [HomeBinding()]),
          // GetPage(
          //     name: Routes.MENU_ADMIN,
          //     page: () => MenuAdmin(),
          //     binding: CreateEventAdminBinding()),
          GetPage(
              name: Routes.PROFILE,
              page: () => ProfileUserView(),
              binding: ProfileUserBinding()),
        ]),
  ];
}
