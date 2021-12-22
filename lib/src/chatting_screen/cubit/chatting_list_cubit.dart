import 'dart:developer' as developer;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../main.dart';
import '../../authentication/model/local_user.dart';
import '../../authentication/service/auth_service.dart';
import '../../chatting_screen/model/chat_info.dart';
import '../../repository/service/repository_service.dart';
import '../../utility/auth_const.dart' show MessageType;
import '../chatting_screen.dart';

class ChattingListCubit extends Cubit<ChattingListState> {
  ChattingListCubit() : super(ChattingListInit());

  ChatInfo? _chatInfo;

  final _chatHistory = BehaviorSubject<QuerySnapshot>();
  final _repository = getIt<RepositoryService>();
  final _user = getIt<AuthService>().getCurrentUser();

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
    _chatHistory.addStream(_repository.getChatHistory(_chatInfo!));

    emit(ChattingListInit());
  }

  void thereIsNoHistory() {
    emit(ChattingListNoHistory());
  }

  void sendFileToRemote(File media) async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    UploadTask uploadTask = _repository.uploadFile(media, fileName);

    try {
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      sendChatToTheRemote(imageUrl, MessageType.image);
    } on FirebaseException catch (e) {
      developer.log(e.message ?? e.toString());
    }
  }

  void sendChatToTheRemote(String content, MessageType type) {
    _repository.sendChatMsg(_chatInfo!, content, type);
  }
}
