import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';

import '../../authentication/model/local_user.dart';

enum ChatDirection { send, receive }

// TODO: For now, the content must be a text
class ChattingMessage extends StatelessWidget {
  const ChattingMessage(
      {Key? key,
      required this.user,
      required this.content,
      required this.timestamp,
      required this.direction})
      : super(key: key);

  final LocalUser user;
  final String content;
  final String timestamp;
  final ChatDirection direction;

  @override
  Widget build(BuildContext context) {
    Widget chatWidget;

    String? avatar = user.avatar;
    String? by = user.name;
    String text = content;

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
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    ),
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
                    child: avatar != null
                        ? CachedNetworkImage(imageUrl: avatar)
                        : null),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child:
                        Text(by!, style: Theme.of(context).textTheme.subtitle2),
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
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.black),
                      ),
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
}
