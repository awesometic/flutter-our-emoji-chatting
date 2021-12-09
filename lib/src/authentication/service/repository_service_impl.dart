import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../authentication/constant/constants.dart' show MessageType;
import '../../chatting_screen/model/chat_info.dart';
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

  Stream<QuerySnapshot> getChatHistory(ChatInfo chatInfo, int messageLength) =>
      _fireStoreProvider.getChatHistory(chatInfo, messageLength);

  Future<void> sendChatMsg(
      ChatInfo chatInfo, String content, MessageType type) {
    var lastContent = content;
    switch (type) {
      case MessageType.image:
        lastContent = "Image was sent";
        break;
      case MessageType.sticker:
        lastContent = "Sticker was sent";
        break;
      default:
        break;
    }

    return _fireStoreProvider
        .sendChatMsg(chatInfo, content, type)
        .then((_) => _fireStoreProvider.setChatLastMsg(chatInfo, lastContent));
  }

  Future<void> setChatLastMsg(ChatInfo chatInfo, String lastContent) =>
      _fireStoreProvider.setChatLastMsg(chatInfo, lastContent);
}
