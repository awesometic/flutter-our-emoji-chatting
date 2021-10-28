import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../authentication/service/auth_service.dart';
import '../my_profile_screen.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(Init());

  final _authService = getIt<AuthService>();

  String getUserAvatar() => _authService.getCurrentUser().avatar;

  String getUserName() => _authService.getCurrentUser().name;

  String getUserId() => _authService.getCurrentUser().id;

  // TODO: It should display all the opposite users
  String getUserOppositeId() => _authService.getCurrentUser().oppositeUserId[0];
}
