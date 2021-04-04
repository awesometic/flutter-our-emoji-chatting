import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../authentication/model/local_user.dart';

enum ChatDirection { send, receive }

// TODO: For now, the content must be a text
class ChattingMessage extends StatelessWidget {
  ChattingMessage(this.user, this.content, this.direction);

  final LocalUser user;
  final String content;
  final ChatDirection direction;

  @override
  Widget build(BuildContext context) {
    Widget results;

    var avatar = user.avatar;
    var by = user.name;
    var text = content;

    switch (direction) {
      case ChatDirection.send:
        results = Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(child: CachedNetworkImage(imageUrl: avatar)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child:
                        Text(by, style: Theme.of(context).textTheme.subtitle1)),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(text),
                ),
              ],
            )
          ],
        ));
        break;
      case ChatDirection.receive:
        results = Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(child: CachedNetworkImage(imageUrl: avatar)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child:
                        Text(by, style: Theme.of(context).textTheme.subtitle1)),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(text),
                ),
              ],
            )
          ],
        ));
        break;
    }

    return results;
  }
}
