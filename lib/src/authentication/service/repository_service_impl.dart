import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_emoji_chatting/src/chatting_screen/model/chat_info.dart';

import '../model/local_user.dart';
import '../resource/fireauth_provider.dart';
import '../resource/firestore_provider.dart';
import 'repository_service.dart';

class RepositoryServiceImpl implements RepositoryService {
  final _fireAuthProvider = FireAuthProvider();
  final _fireStoreProvider = FireStoreProvider();

  Future<UserCredential> signInWithCredential(AuthCredential credential) =>
      _fireAuthProvider.signInWithCredential(credential);

  Future<void> signOut() => _fireAuthProvider.signOut();

  Future<void> registerUser(LocalUser user) =>
      _fireStoreProvider.registerUser(user);

  Future<LocalUser> getUser(String userId) {
    return _fireStoreProvider.getUser(userId);
  }

  Future<LocalUser> updateUser(LocalUser user) {
    return _fireStoreProvider.updateUser(user);
  }

  Stream<QuerySnapshot> getChatHistory(ChatInfo chatInfo) =>
      _fireStoreProvider.getChatHistory(chatInfo);

  Future<void> sendChatMsg(ChatInfo chatInfo, String content, int type) =>
      _fireStoreProvider.sendChatMsg(chatInfo, content, type);

  Future<void> setChatLastMsg(ChatInfo chatInfo, String lastContent) =>
      _fireStoreProvider.setChatLastMsg(chatInfo, lastContent);
}
