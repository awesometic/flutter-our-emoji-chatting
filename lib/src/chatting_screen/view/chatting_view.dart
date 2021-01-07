import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/chatting_screen/chatting_screen.dart';

import 'dart:developer' as developer;

class ChattingScreen extends StatelessWidget {
  ChattingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChattingInputCubit>(
          create: (_) => ChattingInputCubit(),
        ),
        BlocProvider<ChattingListCubit>(
          create: (_) => ChattingListCubit(),
        )
      ],
      child: Column(children: [
        Flexible(
          child: ChattingMessageList(),
        ),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: ChattingInput(),
        ),
      ]),
    );
  }
}
