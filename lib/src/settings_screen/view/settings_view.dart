import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/utility/string_const.dart';
import 'package:settings_ui/settings_ui.dart';

import '../settings_screen.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: SettingsList(
        sections: [
          SettingsSection(
            title: StringConstant.settingsScreen.catEnvironment,
            tiles: [
              SettingsTile.switchTile(
                title: StringConstant.settingsScreen.setLockApp,
                leading: Icon(Icons.lock),
                switchValue: true, // TODO: Should be changed by the selection
                onToggle: (value) {},
              ),
              SettingsTile(
                title: StringConstant.settingsScreen.changePattern,
                subtitle: '',
                leading: Icon(Icons.password),
                onPressed: (context) {},
              ),
              SettingsTile.switchTile(
                title: StringConstant.settingsScreen.setUsingFingerprint,
                leading: Icon(Icons.fingerprint),
                switchValue: true, // TODO: Should be changed by the selection
                onToggle: (value) {},
              ),
            ],
          ),
          SettingsSection(
            title: StringConstant.settingsScreen.catAccount,
            tiles: [
              SettingsTile(
                title: StringConstant.settingsScreen.logout,
                leading: Icon(Icons.logout),
                onPressed: (context) {},
              ),
            ],
          ),
        ],
      )
    );
  }
}
