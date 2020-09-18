import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer' as developer;

import 'package:our_emoji_chatting/src/chatting_screen/cubit/chatting_list_cubit.dart';
import 'package:our_emoji_chatting/src/chatting_screen/cubit/chatting_list_state.dart';

class ChattingMessageList extends StatelessWidget {
  ChattingMessageList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChattingListCubit, ChattingListState>(
      listener: (context, state) {
        developer.log('ChattingView updated with state: ' +
            state.toString().split('.').last);
      },
      builder: (context, state) {
        developer.log('ChattingView created with state: ' +
            state.toString().split('.').last);

        // Emit a state to load messages initially, this is a temporary work around
        context.bloc<ChattingListCubit>().init();

        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          key: UniqueKey(),
          itemBuilder: (_, int index) =>
              context.bloc<ChattingListCubit>().chattingMessages[index],
          itemCount: context.bloc<ChattingListCubit>().chattingMessages.length,
        );
      },
      buildWhen: (_, state) => state == ChattingListState.Created,
      listenWhen: (_, state) => state == ChattingListState.MessageUpdated,
    );
  }
}
