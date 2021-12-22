import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../authentication/model/local_user.dart';
import '../../chatting_screen/model/chat_info.dart';
import '../../utility/auth_const.dart' show MessageType;
import '../provider/fireauth_provider.dart';
import '../provider/firestore_provider.dart';
import 'repository_service.dart';

class RepositoryServiceImpl implements RepositoryService {
  final _fireAuthProvider = FireAuthProvider();
  final _fireStoreProvider = FireStoreProvider();

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) =>
      _fireAuthProvider.signInWithCredential(credential);

  @override
  Future<void> signOut() => _fireAuthProvider.signOut();

  @override
  Future<void> registerUser(LocalUser user) =>
      _fireStoreProvider.registerUser(user);

  @override
  Future<LocalUser> getUser(String userId) {
    return _fireStoreProvider.getUser(userId);
  }

  @override
  Future<LocalUser> updateUser(LocalUser user) {
    return _fireStoreProvider.updateUser(user);
  }

  @override
  Stream<QuerySnapshot> getChatHistory(ChatInfo chatInfo) =>
      _fireStoreProvider.getChatHistory(chatInfo);

  @override
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

  @override
  Future<void> setChatLastMsg(ChatInfo chatInfo, String lastContent) =>
      _fireStoreProvider.setChatLastMsg(chatInfo, lastContent);
}
