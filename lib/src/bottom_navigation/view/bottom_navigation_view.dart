import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../chatting_screen/view/chatting_view.dart';
import '../../my_profile_screen/view/my_profile_view.dart';
import '../../settings_screen/view/settings_view.dart';
import '../../utility/string_const.dart';
import '../cubit/bottom_navigation_cubit.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);

  final appScreens = <Widget>[
    const ChattingView(),
    const MyProfileView(),
    const SettingsView(),
  ];

  final bottomNavigationItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        label: StringConstant.bottomNavigationBarItemNames.chatting,
        icon: const Icon(Icons.chat_bubble)),
    BottomNavigationBarItem(
        label: StringConstant.bottomNavigationBarItemNames.profile,
        icon: const Icon(Icons.person)),
    BottomNavigationBarItem(
        label: StringConstant.bottomNavigationBarItemNames.settings,
        icon: const Icon(Icons.settings)),
  ];

  @override
  Widget build(BuildContext context) {
    var bottomNavigationCubit = BottomNavigationCubit(0);

    return Scaffold(
      appBar: AppBar(title: const Text(StringConstant.appName)),
      body: SizedBox.expand(
        child: BlocConsumer<BottomNavigationCubit, int>(
          bloc: bottomNavigationCubit,
          builder: (_, __) => IndexedStack(
            index: bottomNavigationCubit.state,
            children: appScreens,
          ),
          listener: (_, __) {},
        ),
      ),
      bottomNavigationBar: BlocConsumer<BottomNavigationCubit, int>(
          bloc: bottomNavigationCubit,
          builder: (_, __) => BottomNavigationBar(
                currentIndex: bottomNavigationCubit.state,
                onTap: (index) => bottomNavigationCubit.setState(index),
                items: bottomNavigationItems,
              ),
          listener: (_, __) {}),
    );
  }
}
