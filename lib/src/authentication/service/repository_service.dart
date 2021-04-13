import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../authentication/constant/message_type.dart';
import '../../chatting_screen/model/chat_info.dart';
import '../model/local_user.dart';

abstract class RepositoryService {
  Future<UserCredential> signInWithCredential(AuthCredential credential);

  Future<void> signOut();

  Future<void> registerUser(LocalUser user);

  Future<LocalUser> getUser(String userId);

  Future<LocalUser> updateUser(LocalUser user);

  Stream<QuerySnapshot> getChatHistory(ChatInfo chatInfo);

  Future<void> sendChatMsg(ChatInfo chatInfo, String content, MessageType type);

  Future<void> setChatLastMsg(ChatInfo chatInfo, String lastContent);
}
