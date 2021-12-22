import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utility/auth_const.dart' show MessageType;
import '../../utility/string_const.dart';
import '../../utility/theme_const.dart';
import '../chatting_screen.dart';

class ChattingInput extends StatelessWidget {
  ChattingInput({Key? key}) : super(key: key);

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.image),
                onPressed: () async {
                  var isSetImageSuccessfully = await _setImageFromPicker();

                  if (isSetImageSuccessfully) {
                    developer.log('Image is set successfully');
                  } else {
                    developer.log('Image is not set');
                  }
                },
                color: ThemeConstant.primaryGreyColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.face),
                onPressed: () {},
                color: ThemeConstant.primaryGreyColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (_) => _aboutToTextSubmitted(
                context,
                _textController,
              ),
              style: const TextStyle(fontSize: 15),
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: StringConstant.chatScreen.sendMessageHint,
                hintStyle:
                    const TextStyle(color: ThemeConstant.primaryGreyColor),
              ),
              focusNode: _focusNode,
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _aboutToTextSubmitted(
                        context,
                        _textController,
                      ),
                  color: ThemeConstant.primaryColor),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(color: Colors.white),
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

  Future<bool> _setImageFromPicker() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);

      if (_imageFile != null) {
        return true;
      }
    }

    return false;
  }
}
