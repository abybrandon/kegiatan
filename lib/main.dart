import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/module/notification/pages/home_page.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'controller_universal/controller_universal.dart';
import 'local_storage/local_storage_helper.dart';
import 'local_storage/user_model.dart';
import 'module/home/dummy/trynotification.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

bool _isLoggedIn = false;
bool _preLoginStatus = false;
bool _isAdmin = false;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await FlutterMapTileCaching.initialise();
  await FMTC.instance('mapStore').manage.createAsync();
  await Firebase.initializeApp();
  Get.put(ControllerUniversal());
  NotificationService().initNotification();

  UserData? dataUser = await SharedPreferenceHelper.getUserData();

  int? statusPrelogin = await SharedPreferenceHelper.getDataPrelogin();

  if (dataUser != null) {
    _isLoggedIn = true;
    if (dataUser.role == 'admin') {
      _isAdmin = true;
    }
  }
  if (statusPrelogin == 1) {
    _preLoginStatus = true;
  }

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
  await Future.delayed(const Duration(milliseconds: 1));
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _getInitialRoute() {
    String initialRoute = Routes.PRE_LOGIN;

    if (_isLoggedIn) {
      if (_isAdmin) {
        initialRoute = Routes.MENU_ADMIN;
      } else {
        initialRoute = Routes.NAVIGATION_BAR;
      }
    } else if (_preLoginStatus) {
      initialRoute = Routes.LOGIN;
    }

    return initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(360, 800),
        builder: (_, __) => GetMaterialApp(
            theme: Config.getTheme(),
            defaultTransition: Transition.cupertinoDialog,
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            getPages: AppPages.routes,
            initialRoute: _getInitialRoute()
            // home: MyHomePage(),
            ));
  }
}
