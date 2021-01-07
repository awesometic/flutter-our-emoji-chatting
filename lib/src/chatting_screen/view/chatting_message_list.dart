import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/chatting_screen/chatting_screen.dart';

import 'dart:developer' as developer;

class ChattingMessageList extends StatefulWidget {
  ChattingMessageList({Key key}) : super(key: key);

  @override
  _ChattingMessageListState createState() => _ChattingMessageListState();
}

class _ChattingMessageListState extends State<ChattingMessageList> {
  List<ChattingMessage> _messages = List<ChattingMessage>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocConsumer<ChattingListCubit, ChattingListState>(
      builder: (context, state) {
        // TODO: Need to add loading state and its reactor
        return ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length);
      },
      listener: (context, state) {
        developer.log(state.toString());
        if (state is ChattingListUpdateOdd || state is ChattingListUpdateEven) {
          _messages = context.bloc<ChattingListCubit>().chattingMessages;
        }

        // Update the ListView
        setState(() {});
      },
      buildWhen: (_, state) => state is ChattingListCreated,
      listenWhen: (_, state) =>
          state is ChattingListUpdateOdd || state is ChattingListUpdateEven,
    ));
  }
}
