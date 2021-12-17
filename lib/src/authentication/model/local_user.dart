import 'package:flutter/material.dart';

class LocalUser {
  LocalUser(
      {@required this.id,
      this.name,
      this.avatar,
      this.aboutMe,
      this.oppositeUserId});
  String? id;
  String? name;
  String? avatar;
  String? aboutMe;
  List<String>? oppositeUserId;
}
