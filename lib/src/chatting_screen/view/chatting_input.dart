import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_emoji_chatting/src/utility/string_const.dart';

import '../../authentication/constant/constants.dart' show MessageType;
import '../chatting_screen.dart';

class ChattingInput extends StatelessWidget {
  ChattingInput({Key key}) : super(key: key);

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: (_) => _aboutToTextSubmitted(
                context,
                _textController,
              ),
              decoration: InputDecoration.collapsed(hintText: StringConstant.chatScreen.sendMessageHint),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: IconButton(
                icon: const Icon(Icons.send),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () =>
                    _aboutToTextSubmitted(context, _textController)),
          ),
        ],
      ),
    );
  }

  void _aboutToTextSubmitted(
      BuildContext context, TextEditingController controller) {
    var chatInputCubit = context.read<ChattingInputCubit>();
    var chatListCubit = context.read<ChattingListCubit>();

    chatInputCubit.onTyping(_textController.text);

    if (chatInputCubit.state.userText.invalid) {
      developer.log('Invalid text');
    } else {
      chatListCubit.sendChatToTheRemote(
          chatInputCubit.state.userText.value, MessageType.text);
    }

    controller.clear();
    _focusNode.requestFocus();
  }
}
