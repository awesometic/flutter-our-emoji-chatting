import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/chatting_screen/chatting_screen.dart';

import 'dart:developer' as developer;

class ChattingListCubit extends Cubit<ChattingListState> {
  ChattingListCubit(ChattingListState state) : super(state);

  List<ChattingMessage> chattingMessages = [];

  void init() {
    // Temporary work around,
    // This will access to a remote server to get the current message lists
    emit(ChattingListState.MessageUpdatedOdd);
  }

  void newMessage(String message) {
    chattingMessages.add(ChattingMessage(text: message));

    developer.log(chattingMessages.map((message) => message.text).join(','));

    if (chattingMessages.length % 2 == 0)
      emit(ChattingListState.MessageUpdatedOdd);
    else
      emit(ChattingListState.MessageUpdatedEven);
  }
}
