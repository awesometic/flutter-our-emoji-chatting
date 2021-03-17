import 'package:flutter/material.dart';

import 'login_screen/login_screen.dart';

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginView(),
    );
  }
}
