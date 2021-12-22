import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    Widget results;

    var avatar = user.avatar;
    var by = user.name;
    var text = content;

    switch (direction) {
      case ChatDirection.send:
        results = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
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
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(by!,
                        style: Theme.of(context).textTheme.subtitle1)),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Text(text),
                ),
              ],
            )
          ],
        );
        break;
      case ChatDirection.receive:
        results = Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
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
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(by!,
                        style: Theme.of(context).textTheme.subtitle1)),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Text(text),
                ),
              ],
            )
          ],
        );
        break;
    }

    return results;
  }
}
