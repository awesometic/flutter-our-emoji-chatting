import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utility/auth_const.dart' show MessageType;
import '../../utility/string_const.dart';
import '../../utility/theme_const.dart';
import '../chatting_screen.dart';

class ChattingInput extends StatefulWidget {
  const ChattingInput({Key? key}) : super(key: key);

  @override
  State<ChattingInput> createState() => _ChattingInputState();
}

class _ChattingInputState extends State<ChattingInput> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  ChattingInputCubit? _chatInputCubit;
  ChattingListCubit? _chatListCubit;

  bool _isShowEmoji = false;

  @override
  Widget build(BuildContext context) {
    _chatInputCubit = context.read<ChattingInputCubit>();
    _chatListCubit = context.read<ChattingListCubit>();

    return WillPopScope(
      child: Container(
        child: Column(
          children: <Widget>[
            // Emoji
            _isShowEmoji ? _buildEmojiBox() : const SizedBox.shrink(),

            // Buttons and text box
            Row(
              children: [
                // Image button
                Material(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () => _onMessageSend(type: MessageType.image),
                      color: ThemeConstant.primaryGreyColor,
                    ),
                  ),
                  color: Colors.white,
                ),

                // Emoji button
                Material(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: IconButton(
                      icon: const Icon(Icons.face),
                      onPressed: () {
                        _focusNode.unfocus();
                        setState(() => _isShowEmoji = !_isShowEmoji);
                      },
                      color: ThemeConstant.primaryGreyColor,
                    ),
                  ),
                  color: Colors.white,
                ),

                // Message text box
                Flexible(
                  child: TextField(
                    onSubmitted: (_) => _onMessageSend(type: MessageType.text),
                    style: const TextStyle(fontSize: 15),
                    controller: _textController,
                    decoration: InputDecoration.collapsed(
                      hintText: StringConstant.chatScreen.sendMessageHint,
                      hintStyle: const TextStyle(
                          color: ThemeConstant.primaryGreyColor),
                    ),
                    focusNode: _focusNode,
                  ),
                ),

                // Send button
                Material(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () => _onMessageSend(type: MessageType.text),
                        color: ThemeConstant.primaryColor),
                  ),
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
      ),
      onWillPop: _onBackPress,
    );
  }

  Future<bool> _onBackPress() {
    if (_isShowEmoji) {
      setState(() {
        _isShowEmoji = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  Widget _buildEmojiBox() {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ]),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () => _onMessageSend(type: MessageType.sticker),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                        child: Text(":)", style: TextStyle(fontSize: 35))),
                  ),
                ),
                TextButton(
                  onPressed: () => _onMessageSend(type: MessageType.sticker),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                        child: Text(":p", style: TextStyle(fontSize: 35))),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void _onMessageSend({required MessageType type}) async {
    switch (type) {
      case MessageType.text:
        {
          _chatInputCubit!.validate(_textController.text);

          if (_chatInputCubit!.state.userText.invalid) {
            developer.log(
                'Invalid text: ${_textController.text.isEmpty ? "EMPTY STRING" : _textController.text}',
                name: 'ChattingInput');

            return;
          }

          _chatListCubit!
              .sendChatToTheRemote(_chatInputCubit!.state.userText.value, type);

          _textController.clear();
          _focusNode.requestFocus();
          break;
        }
      case MessageType.image:
        {
          File imageFile = await _setImageFromPicker();

          if (imageFile.path.isNotEmpty) {
            _chatListCubit!.sendFileToRemote(imageFile);
          } else {
            developer.log('Image path is not set', name: 'ChattingInput');
          }
          break;
        }
      case MessageType.sticker:
        {
          break;
        }
      default:
        break;
    }

    return;
  }

  Future<File> _setImageFromPicker() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
    } on PlatformException catch (e) {
      developer.log('Failed to pick image: ${e.message}');
    }

    if (pickedFile == null) {
      developer.log('No image selected or failed to pick image');

      pickedFile = XFile('');
    }

    return File(pickedFile.path);
  }
}
