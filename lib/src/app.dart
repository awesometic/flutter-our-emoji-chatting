import 'package:flutter/material.dart';

import 'bottom_navigation/bottom_navigation.dart';

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: BottomNavigation(),
    );
  }
}
