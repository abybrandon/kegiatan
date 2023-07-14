import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'controller_universal/controller_universal.dart';
import 'local_storage/local_storage_helper.dart';
import 'module/home/trynotification.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

bool _isLoggedIn = false;
bool _preLoginStatus = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ControllerUniversal());
  NotificationService().initNotification();

  String? dataUser = await SharedPreferenceHelper.getUserUid();
  int? statusPrelogin = await SharedPreferenceHelper.getDataPrelogin();
  if (dataUser != null) {
    _isLoggedIn = true;
    print(dataUser);
  }
  if (statusPrelogin == 1) {
    _preLoginStatus = true;
  }
  runApp(MyApp());
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
      initialRoute = Routes.HOME;
    } else if (_preLoginStatus) {
      initialRoute = Routes.LOGIN;
    }

    return initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(360, 800),
        builder: (_, __) => GetMaterialApp(
            theme: Config.getTheme(),
            builder: FToastBuilder(),
            defaultTransition: Transition.rightToLeft,
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            getPages: AppPages.routes,
            initialRoute: _getInitialRoute()));
  }
}
