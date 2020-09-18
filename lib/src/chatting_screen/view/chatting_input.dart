import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/chatting_screen/chatting_screen.dart';

import 'dart:developer' as developer;

class ChattingInput extends StatelessWidget {
  ChattingInput({Key key}) : super(key: key);

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ChattingInputCubit, ChattingInputState>(
            listener: (context, state) => {},
          ),
          BlocListener<ChattingListCubit, ChattingListState>(
            listener: (context, state) => {},
          )
        ],
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (_) => _aboutToTextSubmitted(
                  context,
                  _textController,
                ),
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).accentColor,
                  onPressed: () =>
                      _aboutToTextSubmitted(context, _textController)),
            ),
          ],
        ),
      ),
    );
  }

  void _aboutToTextSubmitted(
      BuildContext context, TextEditingController controller) {
    var chatInputCubit = context.bloc<ChattingInputCubit>();
    var chatListCubit = context.bloc<ChattingListCubit>();

    chatInputCubit.onTyping(_textController.text);

    if (chatInputCubit.state.userText.invalid) {
      developer.log('Invalid text');
    } else {
      chatListCubit.newMessage(chatInputCubit.state.userText.value);
    }

    controller.clear();
    _focusNode.requestFocus();
  }
}
