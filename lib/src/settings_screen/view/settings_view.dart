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

    // Set the variables to false before loading the actual values
    _valLockApplication = false;

    // Get the actual values asynchronously then redraw the page
    _updateValues();
  }

  void _updateValues() async {
    _valLockApplication =
        await _settingsCubit.getOption(optionKey: OptKey.lockApplication) ??
            false;

    _settingsCubit.requestInvokeLoadedState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _settingsCubit,
        child: BlocConsumer<SettingsCubit, SettingsState>(
          bloc: _settingsCubit,
          builder: (context, state) => SettingsList(
            sections: [
              SettingsSection(
                title: StringConstant.settingsScreen.catEnvironment,
                tiles: [
                  SettingsTile.switchTile(
                    title: StringConstant.settingsScreen.setLockApp,
                    leading: Icon(Icons.lock),
                    switchValue: _valLockApplication,
                    onToggle: (value) => _settingsCubit.saveOption(
                        optionKey: OptKey.lockApplication,
                        optionValue: !_valLockApplication),
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
          ),
          listener: (context, state) async {
            switch (state.runtimeType) {
              case Init:
                break;
              case Loaded:
                setState(() {});
                break;
              case Saved:
                // Will load the new values and will invoke Loaded state
                await _updateValues();
                break;
            }
          },
        ));
  }
}
