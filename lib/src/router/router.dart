import 'package:flutter/material.dart';

import '../bottom_navigation/bottom_navigation.dart';
import '../login_screen/login_screen.dart';
import '../matching_person_screen/matching_person_screen.dart';
import '../utility/string_const.dart';
import '../full_photo_screen/full_photo_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case StringConstant.routeLogin:
        return MaterialPageRoute(builder: (context) => LogInView());
      case StringConstant.routeSearchPerson:
        return MaterialPageRoute(builder: (context) => MatchingPersonView());
      case StringConstant.routeMain:
        return MaterialPageRoute(builder: (context) => BottomNavigation());
      case StringConstant.routeShowFullPhoto:
        return MaterialPageRoute(builder: (context) => const FullPhotoView());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                body: Center(
                    child: Text(StringConstant.messages.widgetNotFound))));
    }
  }
}
