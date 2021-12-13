import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../utility/setting_option.dart';
import '../../utility/string_const.dart';
import '../settings_screen.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SettingsCubit _settingsCubit;
  bool _valLockApplication;

  @override
  void initState() {
    super.initState();

    _settingsCubit = SettingsCubit();
    _updateValues();
  }

  void _updateValues() async {
    _valLockApplication =
        await _settingsCubit.getOption(optionKey: OptKey.lockApplication);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _settingsCubit,
        child: SettingsList(
          sections: [
            SettingsSection(
              title: StringConstant.settingsScreen.catEnvironment,
              tiles: [
                SettingsTile.switchTile(
                  title: StringConstant.settingsScreen.setLockApp,
                  leading: Icon(Icons.lock),
                  switchValue: _valLockApplication,
                  onToggle: (value) async {
                    _settingsCubit.saveOption(
                        optionKey: OptKey.lockApplication,
                        optionValue: !_valLockApplication);
                    await _updateValues();

                    setState(() {});
                  },
                ),
                SettingsTile(
                  title: StringConstant.settingsScreen.changePattern,
                  subtitle: '',
                  leading: Icon(Icons.password),
                  enabled: _valLockApplication,
                  onPressed: (context) {
                    // TODO: Go to the new page that sets the pattern
                  },
                ),
                SettingsTile.switchTile(
                  title: StringConstant.settingsScreen.setUsingFingerprint,
                  leading: Icon(Icons.fingerprint),
                  enabled: _valLockApplication,
                  switchValue: false,
                  onToggle: (value) {
                    // TODO: Go to the new page that sets the fingerprint if not set before
                  },
                ),
              ],
            ),
            SettingsSection(
              title: StringConstant.settingsScreen.catAccount,
              tiles: [
                SettingsTile(
                  title: StringConstant.settingsScreen.logout,
                  leading: Icon(Icons.logout),
                  onPressed: (context) {
                    // TODO: Logout using authentication implementations
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
