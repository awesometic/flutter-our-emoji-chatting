import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            title: 'Environments',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English', // TODO: Should be changed by the selection => [ '한글', 'English' ]
                leading: Icon(Icons.language),
                onPressed: (context) {},
              ),
              SettingsTile.switchTile(
                title: 'Lock the application',
                leading: Icon(Icons.lock),
                switchValue: true, // TODO: Should be changed by the selection
                onToggle: (value) {},
              ),
              SettingsTile(
                title: 'Change password',
                subtitle: '',
                leading: Icon(Icons.password),
                onPressed: (context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: true, // TODO: Should be changed by the selection
                onToggle: (value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.logout),
                onPressed: (context) {},
              ),
            ],
          ),
        ],
      )

      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: MediaQuery.of(context).size.height * 1,
      //   decoration: BoxDecoration(
      //     color: Color(0xFFEEEEEE),
      //   ),
      //   child: Padding(
      //     padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
      //     child: Column(
      //     ),
      //   )
      // ),
    );
  }
}
