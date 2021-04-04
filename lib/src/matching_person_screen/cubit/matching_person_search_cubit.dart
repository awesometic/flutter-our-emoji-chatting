import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../authentication/service/auth_service.dart';
import 'matching_person_search_state.dart';

class MatchingPersonSearchCubit extends Cubit<MatchingPersonSearchState> {
  MatchingPersonSearchCubit() : super(MatchingPersonSearchInitState()) {
    _checkIfOppositeExists();
  }

  final _authService = getIt<AuthService>();

  void _checkIfOppositeExists() {
    if (_authService.getCurrentUser().oppositeUserId != null) {
      emit(MatchingPersonSearchOppositeExists());
    }
  }

  void onTyping() {
    emit(MatchingPersonSearchSearchedState());
  }

  void onContinueButtonClicked() {
    emit(MatchingPersonSearchSelectedState());
  }
}
