import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/setting_option.dart';
import '../settings_screen.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(Init());

  void saveOption({OptKey optionKey, dynamic optionValue}) async {
    var sharedPref = await SharedPreferences.getInstance();

    try {
      sharedPref.setBool(optionKey.toShortString(),
          optionValue is bool ? optionValue : () => throw Exception('given value is not boolean type')
      );
    } on Exception catch (exception) {
      print(exception.toString());
    }

    emit(Saved());
  }

  Future<bool> getOption({OptKey optionKey}) async {
    var sharedPref = await SharedPreferences.getInstance();

    return sharedPref.getBool(optionKey.toShortString());
  }

  // TODO: Is it needed? A better way to late-loading the variables on the settings page?
  void requestInvokeLoadedState() => emit(Loaded());
}
