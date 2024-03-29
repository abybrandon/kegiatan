part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const PRE_LOGIN = '/pre-login';
  static const LOGIN = '/login';
  static const SIGN_UP = '/sign-up';
  static const HOME = '/home';
  static const HOME2 = '/home2';
  static const EVENT_LIST = '/event-list';
  static const EVENT_DETAIL = '/event-list/detail';

  //navigation
  static const NAVIGATION_BAR = '/navigation-bar';

  //favorite
  static const FAVORITE = '/favorite';
  static const FAVORITE_Detail = '/favorite/detail';

  //profile
  static const PROFILE = '/profile';
  //change username
  static const CHANGE_USERNAME = '/profile/change-username';
  //change password
  static const CHANGE_PASSWORD = '/profile/change-password';

  //reminder
  static const REMINDER = '/reminder';

  //admin

  static const MENU_ADMIN = '/admin/menu';
  static const CREATE_ARTIST_ADMIN = '/admin/artist';
  static const CREATE_EVENT_ADMIN = '/admin/create-admin';
  static const CREATE_COSTUME_RENT = '/admin/create-costume';
  static const CREATE_COMMUNITY = '/admin/create-community';

  //costume
  //costume rent
  static const COSTUME_RENT = '/costume/rent';

  //costume rent detail
  static const COSTUME_RENT_DETAIL = '/costume/rent/detail';

  //community
  static const COMMUNITY_LIST = '/community/list';
  //community detail
  static const COMMUNITY_DETAIL = '/community/detail';

}
