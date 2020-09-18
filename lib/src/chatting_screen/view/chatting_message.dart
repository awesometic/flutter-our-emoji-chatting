import 'package:flutter/material.dart';

class ChattingMessage extends StatelessWidget {
  ChattingMessage({this.text});

  final _name = '';
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
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
  }
}
