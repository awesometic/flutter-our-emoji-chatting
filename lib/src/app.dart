import 'package:flutter/material.dart';

import 'router/router.dart' as router;
import 'utility/string_const.dart';

class MyApp extends StatelessWidget {
  static const String _title = 'Our Emoji Chatting';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: StringConstant.routeLogIn,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
