import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:our_emoji_chatting/src/chatting_screen/cubit/chatting_input_state.dart';
import 'package:our_emoji_chatting/src/chatting_screen/model/user_text.dart';

import 'dart:developer' as developer;

class ChattingInputCubit extends Cubit<ChattingInputState> {
  ChattingInputCubit() : super(const ChattingInputState());

  void onTyping(String text) {
    final userText = UserText.dirty(text);

    developer.log(userText.toString());

    emit(state.copyWith(
      userText: userText,
      status: Formz.validate([userText]),
    ));
  }
}
