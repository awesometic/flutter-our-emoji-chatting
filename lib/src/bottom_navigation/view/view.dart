import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bottom_navigation_cubit.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key key}) : super(key: key);

  final appScreens = <Widget>[
    Container(
      color: Colors.blueGrey,
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
  ];

  final bottomNavigationItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        title: Text('Chatting'), icon: Icon(Icons.chat_bubble)),
    BottomNavigationBarItem(title: Text('Me'), icon: Icon(Icons.person)),
    BottomNavigationBarItem(
        title: Text('Settings'), icon: Icon(Icons.settings)),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavigationCubit bottomNavigationCubit = BottomNavigationCubit(0);

    return Scaffold(
      appBar: AppBar(title: Text("Our Emoji Chatting")),
      body: SizedBox.expand(
        child: BlocConsumer<BottomNavigationCubit, int>(
          cubit: bottomNavigationCubit,
          builder: (_, __) => appScreens[bottomNavigationCubit.state],
          listener: (_, __) {},
        ),
      ),
      bottomNavigationBar: BlocConsumer<BottomNavigationCubit, int>(
          cubit: bottomNavigationCubit,
          builder: (_, __) => BottomNavigationBar(
                currentIndex: bottomNavigationCubit.state,
                onTap: (index) => bottomNavigationCubit.setState(index),
                items: bottomNavigationItems,
              ),
          listener: (_, __) {}),
    );
  }
}
