import '../../authentication/model/local_user.dart';

class ChatInfo {
  const ChatInfo(this.fromUser, this.toUser);

  final LocalUser fromUser;
  final LocalUser toUser;

  String getGroupChatId() {
    if (fromUser.id.hashCode <= toUser.id.hashCode) {
      return '${fromUser.id} - ${toUser.id}';
    } else {
      return '${toUser.id} - ${fromUser.id}';
    }
  }
}
