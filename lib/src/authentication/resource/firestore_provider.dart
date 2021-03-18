import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/local_user.dart';

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
      'aboutMe': user.aboutMe
    });
  }

  Future<LocalUser> updateUser(LocalUser user) async {
    return _firestore.collection("users").doc(user.id).update({
      'name': user.name,
      'avatar': user.avatar,
      'aboutMe': user.aboutMe
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
          aboutMe: documents[0]['aboutMe']);
    }

    return null;
  }
}
