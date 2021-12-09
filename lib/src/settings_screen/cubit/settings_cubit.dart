import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings_screen.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(Init());
}
