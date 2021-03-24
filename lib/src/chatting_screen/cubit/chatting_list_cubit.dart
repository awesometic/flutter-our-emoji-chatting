import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../authentication/service/auth_service.dart';
import '../chatting_screen.dart';

class ChattingListCubit extends Cubit<ChattingListState> {
  ChattingListCubit() : super(ChattingListInit()) {
    // Do some jobs right after initializing
    _createChattingList();
  }

  List<ChattingMessage> chattingMessages = <ChattingMessage>[];
  final _user = getIt<AuthService>().getCurrentUser();
  bool msgFlag = false;

  void _createChattingList() {
    // Do some jobs here before showing to the user
    emit(ChattingListCreated());
  }

  void receivingChatFromRemote() {
    // Do some jobs here before showing the user the opposite writing a message
    emit(ChattingListReceivingChat());
  }

  void sendChatToTheRemote(String msg) {
    // Do some jobs here right before sending chat message then show the user
    // the result

    chattingMessages.insert(
        0,
        ChattingMessage(
          by: _user.name,
          text: msg,
          avatar: _user.avatar,
          direction: ChatDirection.send,
        ));

// TODO: Clean up this when the chatting service using Firebase is implemented
    chattingMessages.insert(
        0,
        ChattingMessage(
          by: _user.name,
          text: 'say one more time: $msg',
          avatar: _user.avatar,
          direction: ChatDirection.send,
        ));

    chattingMessages.insert(
        0,
        ChattingMessage(
          by: _user.name,
          text: 'from oppsite',
          avatar: _user.avatar,
          direction: ChatDirection.receive,
        ));

    // if (chattingMessages.length % 2 == 0) {
    if (msgFlag) {
      emit(ChattingListUpdateOdd());
    } else {
      emit(ChattingListUpdateEven());
    }
    msgFlag = !msgFlag;
  }
}
