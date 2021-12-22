import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_our_emoji_chatting/src/utility/nav_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../utility/setting_option.dart';
import '../../utility/string_const.dart';
import '../../utility/theme_const.dart';
import '../settings_screen.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SettingsCubit? _settingsCubit;
  bool? _valUsePattern;
  bool? _valUseFingerprint;

  @override
  void initState() {
    super.initState();

    _settingsCubit = SettingsCubit();

    // Set the variables to false before loading the actual values
    _valUsePattern = false;
    _valUseFingerprint = false;

    // Get the actual values asynchronously then redraw the page
    _updateValues();
  }

  void _updateValues() async {
    _valUsePattern = await _settingsCubit?.getOption(
            optionKey: OptKey.usePatternAsLockMethod) ??
        false;
    _valUseFingerprint = await _settingsCubit?.getOption(
            optionKey: OptKey.useFingerprintAsLockMethod) ??
        false;

    _settingsCubit?.requestInvokeLoadedState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
        create: (_) => _settingsCubit!,
        child: BlocConsumer<SettingsCubit, SettingsState>(
          bloc: _settingsCubit,
          builder: (context, state) => SettingsList(
            sections: [
              SettingsSection(
                title: StringConstant.settingsScreen.catLockApplication,
                tiles: [
                  SettingsTile.switchTile(
                    title: StringConstant.settingsScreen.setUsingPattern,
                    leading: const Icon(Icons.pattern),
                    switchValue: _valUsePattern,
                    onToggle: (value) {
                      // TODO: Go to the new page that sets a new pattern

                      // TODO: If a pattern is set then set the value
                      _settingsCubit!.saveOption(
                          optionKey: OptKey.usePatternAsLockMethod,
                          optionValue: !_valUsePattern!);
                    },
                  ),
                  SettingsTile(
                    title: StringConstant.settingsScreen.changePattern,
                    subtitle: '',
                    leading: Icon(Icons.password),
                    enabled: !_valUsePattern!,
                    onPressed: (context) {
                      // TODO: Go to the new page that sets the pattern
                    },
                  ),
                  SettingsTile.switchTile(
                    title: StringConstant.settingsScreen.setUsingFingerprint,
                    leading: Icon(Icons.fingerprint),
                    switchValue: _valUseFingerprint,
                    onToggle: (value) {
                      // TODO: Go to the new page that sets a new fingerprint

                      // TODO: If a fingerprint is set then set the value
                      _settingsCubit!.saveOption(
                          optionKey: OptKey.useFingerprintAsLockMethod,
                          optionValue: !_valUseFingerprint!);
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
                    onPressed: (context) => _settingsCubit!.logout(),
                  ),
                ],
              ),
            ],
          ),
          listener: (context, state) {
            switch (state.runtimeType) {
              case Init:
                break;
              case Loaded:
                setState(() {});
                break;
              case Saved:
                // Will load the new values and will invoke Loaded state
                _updateValues();
                break;
              case Logout:
                Fluttertoast.showToast(
                    msg: StringConstant.messages.loggedOut,
                    backgroundColor: ThemeConstant.toastColor);

                navigateToAndRemoveUntil(
                    context, StringConstant.routeLogin, null);
                break;
            }
          },
        ));
  }
}
