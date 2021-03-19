import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_social_state.dart';

class LoginSocialCubit extends Cubit<LoginSocialState> {
  LoginSocialCubit() : super(InitialState());

  void onGoogleClicked() {
    developer.log('Google auth button clicked');
    emit(LoadingState());
  }
}