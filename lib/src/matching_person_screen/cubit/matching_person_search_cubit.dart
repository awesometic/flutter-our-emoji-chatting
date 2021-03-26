import 'package:flutter_bloc/flutter_bloc.dart';
import 'matching_person_search_state.dart';

class MatchingPersonSearchCubit extends Cubit<MatchingPersonSearchState> {
  MatchingPersonSearchCubit() : super(MatchingPersonSearchInitState());

  void onTyping() {
    emit(MatchingPersonSearchSearchedState());
  }

  void onContinueButtonClicked() {
    emit(MatchingPersonSearchSelectedState());
  }
}
