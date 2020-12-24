import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:our_emoji_chatting/src/chatting_screen/cubit/chatting_list_state.dart';

import 'dart:developer' as developer;

class ChattingListCubit extends Cubit<ChattingListState> {
  ChattingListCubit() : super(ChattingListInit()) {
    // Do some jobs right after initializing
    _createChattingList();
  }

  void _createChattingList() {
    // Do some jobs here before showing to the user
    emit(ChattingListCreated());
  }

  void receiveChatFromRemote() {
    // Do some jobs here right after the receving chat message then show the user the result
    emit(ChattingListReceiveChat());
  }

  void sendChatToTheRemote() {
    // Do some jobs here right before sending chat message then show the user the result
    emit(ChattingListSendChat());
  }
}
