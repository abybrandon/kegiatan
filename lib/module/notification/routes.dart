import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:newtest/module/notification/pages/home_page.dart';
import 'package:newtest/module/notification/pages/notification_page.dart';

import 'controller/notification_controller.dart';

class Routes {
  static const String routeHome = '/';
  static const String routeNotification = '/notification-page';

  static List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];
    pageStack.add(MaterialPageRoute(builder: (_) => const MyHomePage()));

    if (initialRouteName == routeNotification &&
        NotificationController.initialAction != null) {
      pageStack.add(MaterialPageRoute(
          builder: (_) => NotificationPage(
              receivedAction: NotificationController.initialAction!)));
    }
    return pageStack;
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => const MyHomePage());

      case routeNotification:
        ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return MaterialPageRoute(
            builder: (_) => NotificationPage(receivedAction: receivedAction));
    }
    return null;
  }
}
