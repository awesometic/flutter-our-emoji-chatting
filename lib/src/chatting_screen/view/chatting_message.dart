import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_our_emoji_chatting/src/full_photo_screen/full_photo_screen.dart';
import 'package:flutter_our_emoji_chatting/src/utility/nav_util.dart';
import 'package:flutter_our_emoji_chatting/src/utility/string_const.dart';

import '../../authentication/model/local_user.dart';
import '../../utility/auth_const.dart';

enum ChatDirection { send, receive }

// TODO: For now, the content must be a text
class ChattingMessage extends StatelessWidget {
  const ChattingMessage(
      {Key? key,
      required this.user,
      required this.content,
      required this.type,
      required this.timestamp,
      required this.direction})
      : super(key: key);

  final LocalUser user;
  final String content;
  final MessageType type;
  final String timestamp;
  final ChatDirection direction;

  @override
  Widget build(BuildContext context) {
    Widget chatWidget;

    switch (direction) {
      case ChatDirection.send:
        chatWidget = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                ChatBubble(
                  clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 20),
                  backGroundColor: Colors.blue,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: buildItemContent(context),
                  ),
                ),
              ],
            ),
          ],
        );
        break;
      case ChatDirection.receive:
        chatWidget = Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    child: user.avatar != null
                        ? CachedNetworkImage(imageUrl: user.avatar ?? '')
                        : null),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(user.name!,
                        style: Theme.of(context).textTheme.subtitle2),
                  ),
                  ChatBubble(
                    clipper:
                        ChatBubbleClipper1(type: BubbleType.receiverBubble),
                    alignment: Alignment.topLeft,
                    backGroundColor: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: buildItemContent(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;
    }

    return chatWidget;
  }

  Widget buildItemContent(BuildContext context) {
    switch (type) {
      case MessageType.text:
        return Text(content,
            style: TextStyle(
                color: direction == ChatDirection.send
                    ? Colors.white
                    : Colors.black));
      case MessageType.image:
        // TODO: Use cache
        return TextButton(
            onPressed: () {
              navigateTo(context, StringConstant.routeShowFullPhoto,
                  FullPhotoArgument(imageUrl: content));
            },
            child: Image.network(
              content,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ));
      // return Image.network(content);
      case MessageType.sticker:
        // TODO: Implement showing a sticker
        return Container();
      default:
        return Container();
    }
  }
}
