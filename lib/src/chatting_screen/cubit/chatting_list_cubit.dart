import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/chatting_screen/chatting_screen.dart';

import 'dart:developer' as developer;

class ChattingListCubit extends Cubit<ChattingListState> {
  ChattingListCubit() : super(ChattingListInit()) {
    // Do some jobs right after initializing
    _createChattingList();
  }

  List<ChattingMessage> chattingMessages = List<ChattingMessage>();

  void _createChattingList() {
    // Do some jobs here before showing to the user
    emit(ChattingListCreated());
  }

  void receivingChatFromRemote() {
    // Do some jobs here before showing the user the opposite writing a message
    emit(ChattingListReceivingChat());
  }

  void sendChatToTheRemote(String msg) {
    // Do some jobs here right before sending chat message then show the user the result
    chattingMessages.insert(
        0,
        ChattingMessage(
          by: "Test Sender",
          text: msg,
          direction: ChatDirection.send,
        ));

    if (chattingMessages.length % 2 == 0)
      emit(ChattingListUpdateOdd());
    else
      emit(ChattingListUpdateEven());
  }
}
