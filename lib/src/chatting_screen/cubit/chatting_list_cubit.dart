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
    // TODO: getChatHistory doesn't work, have to fix this first
    emit(ChattingListLoading());
    await _storeChatMessages(_repository.getChatHistory(chatInfo))
        ? emit(ChattingListRoomReady())
        : emit(ChattingListNoHistory());
  }

  void receivingChatFromRemote() {
    emit(ChattingListReceivingChat());
  }

  void sendChatToTheRemote(String msg) {
    emit(ChattingListUpdateOdd());
    emit(ChattingListUpdateEven());
  }

  Future<bool> _storeChatMessages(Stream<QuerySnapshot> stream) async {
    var querySnapshot = await stream.single;

    if (querySnapshot.size == 0) {
      return false;
    } else {
      for (var snapshot in querySnapshot as Iterable) {
        var chatDirection = snapshot["idFrom"] == _user.id
            ? ChatDirection.send
            : ChatDirection.receive;

        chattingMessages.add(ChattingMessage(
            chatDirection == ChatDirection.send
                ? chatInfo.fromUser
                : chatInfo.toUser,
            snapshot["content"],
            chatDirection));
      }
      return true;
    }
  }
}
