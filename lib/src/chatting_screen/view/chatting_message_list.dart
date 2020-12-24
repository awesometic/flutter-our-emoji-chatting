import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/chatting_screen/cubit/chatting_list_cubit.dart';
import 'package:our_emoji_chatting/src/chatting_screen/cubit/chatting_list_state.dart';

import 'dart:developer' as developer;

import 'package:our_emoji_chatting/src/chatting_screen/view/chatting_message.dart';

class ChattingMessageList extends StatefulWidget {
  ChattingMessageList({Key key}) : super(key: key);

  @override
  _ChattingMessageListState createState() => _ChattingMessageListState();
}

class _ChattingMessageListState extends State<ChattingMessageList> {
  List<ChattingMessage> messages = List();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocConsumer<ChattingListCubit, ChattingListState>(
      builder: (context, state) => {},
      listener: (context, state) => {},
    ));
  }
}
