import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/setting_option.dart';
import '../settings_screen.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(Init());

  bool _isBool(dynamic value) {
    if (value is bool) {
      return true;
    } else {
      throw Exception('Value is not boolean type');
    }
  }

  void saveOption({required OptKey optionKey, dynamic optionValue}) async {
    var sharedPref = await SharedPreferences.getInstance();

    try {
      sharedPref.setBool(optionKey.toShortString(),
          optionValue is bool ? optionValue : _isBool(optionValue));
    } on Exception catch (exception) {
      print(exception.toString());
    }

    emit(Saved());
  }

  Future<bool> getOption({required OptKey optionKey}) async {
    var sharedPref = await SharedPreferences.getInstance();

    // TODO: Temporary, if no value is found, return false
    return sharedPref.getBool(optionKey.toShortString()) ?? false;
  }

  // TODO: Is it needed? A better way to late-loading the variables on the settings page?
  void requestInvokeLoadedState() => emit(Loaded());
}
