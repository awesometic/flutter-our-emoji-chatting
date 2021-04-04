import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chatting_screen.dart';

class ChattingMessageList extends StatefulWidget {
  ChattingMessageList({Key key}) : super(key: key);

  @override
  _ChattingMessageListState createState() => _ChattingMessageListState();
}

class _ChattingMessageListState extends State<ChattingMessageList> {
  List<ChattingMessage> _messages = <ChattingMessage>[];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocConsumer<ChattingListCubit, ChattingListState>(
      builder: (context, state) {
        var chatInfo = context.read<ChattingListCubit>().chatInfo;

        if (chatInfo == null) {
          context.read<ChattingListCubit>().setChatInfo();
        }

        return ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, index) => _messages[index],
            itemCount: _messages.length);
      },
      listener: (context, state) {
        switch (state.runtimeType) {
          case ChattingListLoading:
            developer.log("ChattingList screen in loading...");
            return;
          case ChattingListChatInfoSet:
            developer.log("Chatting ChatInfo object set");
            context.read<ChattingListCubit>().getChatHistory();
            return;
          case ChattingListNoHistory:
            developer.log("Chatting history has nothing");
            break;
          case ChattingListRoomReady:
            developer.log("Chatting history loaded in logic");
            break;
        }

        if (state is ChattingListUpdateOdd || state is ChattingListUpdateEven) {
          _messages = context.read<ChattingListCubit>().chattingMessages;
        }

        setState(() {});
      },
    ));
  }
}
