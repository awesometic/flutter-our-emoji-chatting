import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../authentication/service/auth_service.dart';
import '../../utility/auth_const.dart' show AuthType;
import 'login_social_state.dart';

class LoginSocialCubit extends Cubit<LoginSocialState> {
  LoginSocialCubit() : super(InitialState());

  final _authService = getIt<AuthService>();

  void onSocialLoginButtonClicked(AuthType type) async {
    emit(LoadingState());

    var result = await _authService.userSignIn(type);

    emit(LoadedState());
    if (result) {
      emit(LogInState());
    } else {
      emit(ErrorState());
    }
  }
}
