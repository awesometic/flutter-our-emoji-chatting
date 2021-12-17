import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../main.dart';
import '../../authentication/constant/constants.dart' show MessageType;
import '../../authentication/model/local_user.dart';
import '../../authentication/service/auth_service.dart';
import '../../authentication/service/repository_service.dart';
import '../../chatting_screen/model/chat_info.dart';
import '../chatting_screen.dart';

class ChattingListCubit extends Cubit<ChattingListState> {
  ChattingListCubit() : super(ChattingListInit());

  ChatInfo? _chatInfo;

  final _chatHistory = BehaviorSubject<QuerySnapshot>();
  final _repository = getIt<RepositoryService>();
  final _user = getIt<AuthService>().getCurrentUser();

  int _shownMessageNum = 20;
  final _numForMoreMsg = 20;

  Stream<QuerySnapshot> get chatHistory => _chatHistory.stream;

  LocalUser get user => _user;

  ChatInfo get chatInfo => _chatInfo!;

  void initChatRoom() async {
    var oppositeUserId =
        _user.oppositeUserId!.isEmpty ? '' : _user.oppositeUserId!.first;

    emit(ChattingListLoading());
    await _repository.getUser(oppositeUserId).then((value) {
      _chatInfo = ChatInfo(_user, value);
    });
    _chatHistory.addStream(_repository
        .getChatHistory(_chatInfo!, _shownMessageNum)
        .take(_shownMessageNum));

    emit(ChattingListInit());
  }

  void loadMoreChats() async {
    var oppositeUserId =
        _user.oppositeUserId!.isEmpty ? '' : _user.oppositeUserId!.first;
    _shownMessageNum += _numForMoreMsg;

    emit(ChattingListLoading());
    await _repository.getUser(oppositeUserId).then((value) {
      _chatInfo = ChatInfo(_user, value);
    });

    // Close and add a new stream that loads more messages
    // TODO: How to add a new stream with the new parameters?
    await _chatHistory.drain();
    _chatHistory.close();
    _chatHistory.addStream(_repository
        .getChatHistory(_chatInfo!, _shownMessageNum)
        .take(_shownMessageNum));
    emit(ChattingListLoaded());
  }

  void thereIsNoHistory() {
    emit(ChattingListNoHistory());
  }

  void sendChatToTheRemote(String content, MessageType type) {
    _repository.sendChatMsg(_chatInfo!, content, type);
  }
}
