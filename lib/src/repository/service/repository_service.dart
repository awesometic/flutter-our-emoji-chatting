import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../authentication/model/local_user.dart';
import '../../chatting_screen/model/chat_info.dart';
import '../../utility/auth_const.dart' show MessageType;

abstract class RepositoryService {
  Future<UserCredential> signInWithCredential(AuthCredential credential);

  Future<void> signOut();

  Future<void> registerUser(LocalUser user);

  Future<LocalUser> getUser(String userId);

  Future<LocalUser> updateUser(LocalUser user);

  Stream<QuerySnapshot> getChatHistory(ChatInfo chatInfo, int meesageLength);

  Future<void> sendChatMsg(ChatInfo chatInfo, String content, MessageType type);

  Future<void> setChatLastMsg(ChatInfo chatInfo, String lastContent);
}
