import '../../authentication/model/local_user.dart';
import '../chatting_screen.dart';

class ChatInfo {
  ChatInfo(this.fromUser, this.toUser);

  final LocalUser fromUser;
  final LocalUser toUser;
  ChattingMessage? _lastMessageByLoaded;

  void setLastMessage(ChattingMessage message) =>
      _lastMessageByLoaded = message;

  String getGroupChatId() {
    if (fromUser.id.hashCode <= toUser.id.hashCode) {
      return '${fromUser.id} - ${toUser.id}';
    } else {
      return '${toUser.id} - ${fromUser.id}';
    }
  }

  // If there's no loaded message, return '0'
  String getLastMsgTimeStamp() => _lastMessageByLoaded?.timestamp ?? '0';
}
