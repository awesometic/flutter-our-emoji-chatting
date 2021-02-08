import 'package:flutter/material.dart';

enum ChatDirection { send, receive }

class ChattingMessage extends StatelessWidget {
  ChattingMessage({this.by, this.text, this.direction});

  final _name = '';

  final String by;
  final String text;
  final ChatDirection direction;

  @override
  Widget build(BuildContext context) {
    Widget results;
    switch (direction) {
      case ChatDirection.send:
        results = Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(child: Text(by))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name, style: Theme.of(context).textTheme.headline4),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
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
                child: CircleAvatar(child: Text(by))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name, style: Theme.of(context).textTheme.headline4),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
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
