import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../authentication/service/auth_service.dart';
import '../../authentication/service/repository_service.dart';
import '../../chatting_screen/model/chat_info.dart';
import '../chatting_screen.dart';

class ChattingListCubit extends Cubit<ChattingListState> {
  ChattingListCubit() : super(ChattingListInit());

  List<ChattingMessage> chattingMessages = <ChattingMessage>[];
  ChatInfo chatInfo;
  final _repository = getIt<RepositoryService>();
  final _user = getIt<AuthService>().getCurrentUser();

  void setChatInfo() async {
    var oppositeUserId = _user.oppositeUserId?.first;

    emit(ChattingListLoading());
    await _repository.getUser(oppositeUserId).then((value) {
      chatInfo = ChatInfo(_user, value);
      emit(ChattingListChatInfoSet());
    });
  }

  void getChatHistory() async {
    var stream = _repository.getChatHistory(chatInfo);

    emit(ChattingListLoading());
    await stream.map((querySnapshot) => querySnapshot.docs.map((doc) {
          var chatDirection = doc["idFrom"] == _user.id
              ? ChatDirection.send
              : ChatDirection.receive;

          chattingMessages.add(ChattingMessage(
              chatDirection == ChatDirection.send
                  ? chatInfo.fromUser
                  : chatInfo.toUser,
              doc["content"],
              chatDirection));
        }));

    chattingMessages.isEmpty
        ? emit(ChattingListNoHistory())
        : emit(ChattingListRoomReady());
  }

  void receivingChatFromRemote() {
    emit(ChattingListReceivingChat());
  }

  void sendChatToTheRemote(String msg) {
    chattingMessages.length.isEven
        ? ChattingListUpdateEven()
        : ChattingListUpdateOdd();
  }
}
