import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../authentication/constant/constants.dart' show MessageType;
import '../../chatting_screen/model/chat_info.dart';
import '../model/local_user.dart';

// TODO: In the future, oppositeUserId should be assigned/used in List<String> type
class FireStoreProvider {
  final _firestore = FirebaseFirestore.instance;

  Future<bool> authenticateUser() async {
    final result = await _firestore.collection("users").get();
    final List<DocumentSnapshot> docs = result.docs;

    return docs.isEmpty ? false : true;
  }

  Future<void> registerUser(LocalUser user) async {
    _firestore.collection('users').doc(user.id).set({
      'id': user.id,
      'name': user.name,
      'avatar': user.avatar,
      'aboutMe': user.aboutMe,
      'oppositeUserId': user.oppositeUserId[0],
    });
  }

  Future<LocalUser> updateUser(LocalUser user) async {
    return _firestore.collection("users").doc(user.id).update({
      'name': user.name,
      'avatar': user.avatar,
      'aboutMe': user.aboutMe,
      'oppositeUserId': user.oppositeUserId[0],
    }).then((_) {
      return getUser(user.id);
    });
  }

  Future<LocalUser> getUser(String userId) async {
    var result = await _firestore
        .collection('users')
        .where('id', isEqualTo: userId)
        .get();

    List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      return LocalUser(
          id: documents[0]['id'],
          name: documents[0]['name'],
          avatar: documents[0]['avatar'],
          aboutMe: documents[0]['aboutMe'],
          oppositeUserId: [documents[0]['oppositeUserId']]);
    }

    return null;
  }

  Stream<QuerySnapshot> getChatList() {
    // TODO: Should be implemented to support multiple chatting rooms
  }

  Stream<QuerySnapshot> getChatHistory(ChatInfo chatInfo, int messageLength) {
    return _firestore
        .collection('messages')
        .doc(chatInfo?.getGroupChatId())
        .collection(chatInfo?.getGroupChatId())
        .orderBy('timestamp', descending: true)
        .limit(messageLength)
        .snapshots();
  }

  Future<void> sendChatMsg(
      ChatInfo chatInfo, String content, MessageType type) async {
    var chatReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(chatInfo?.getGroupChatId())
        .collection(chatInfo?.getGroupChatId())
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    return _firestore.runTransaction((transaction) async {
      await transaction.set(chatReference, {
        'idFrom': chatInfo.fromUser.id,
        'idTo': chatInfo.toUser.id,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'content': content,
        'type': type.index
      });
    });
  }

  Future<void> setChatLastMsg(ChatInfo chatInfo, String lastContent) async {
    var chatReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(chatInfo?.getGroupChatId());

    return _firestore.runTransaction((transaction) async {
      await transaction.set(chatReference, {
        'lastMessage': lastContent,
      });
    });
  }
}
