import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../model/user_text.dart';
import 'chatting_input_state.dart';

class ChattingInputCubit extends Cubit<ChattingInputState> {
  ChattingInputCubit() : super(const ChattingInputState());

  void validate(String text) {
    final userText = UserText.dirty(text);

    developer.log(userText.toString());

    emit(state.copyWith(
      userText: userText,
      status: Formz.validate([userText]),
    ));
  }
}
