import 'package:newtest/module/event/bindings/event_binding.dart';
import 'package:newtest/module/login/bindings/login_binding.dart';
import 'package:get/get.dart';
import 'package:newtest/module/signup/view/sign_up_view.dart';

import '../module/event/view/llist_event_view.dart';
import '../module/home/bindings/home_binding.dart';
import '../module/home/home_screen.dart';
import '../module/home/view/home_view.dart';
import '../module/login/view/login_view.dart';
import '../module/prelogin/binding/prelogin_binding.dart';
import '../module/prelogin/view/prelogin_view.dart';
import '../module/signup/binding/sign_up_binding.dart';

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
  ];
}
