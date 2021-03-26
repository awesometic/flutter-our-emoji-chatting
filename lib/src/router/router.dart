import 'package:flutter/material.dart';

import '../bottom_navigation/bottom_navigation.dart';
import '../login_screen/login_screen.dart';
import '../matching_person_screen/matching_person_screen.dart';
import '../utility/string_const.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case StringConstant.routeLogIn:
        return MaterialPageRoute(builder: (context) => LogInView());
      case StringConstant.routeMatchPerson:
        return MaterialPageRoute(builder: (context) => MatchingPersonView());
      case StringConstant.routeMainBottomNav:
        return MaterialPageRoute(builder: (context) => BottomNavigation());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                body: Center(child: Text(StringConstant.errorWidgetNotFound))));
    }
  }
}
