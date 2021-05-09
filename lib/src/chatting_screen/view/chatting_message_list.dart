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
  ChattingListCubit chattingListCubit;

  final scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (chattingListCubit == null) {
      chattingListCubit = context.read<ChattingListCubit>();
      chattingListCubit.initChatRoom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocConsumer<ChattingListCubit, ChattingListState>(
      builder: (_, state) {
        switch (state.runtimeType) {
          case ChattingListInit:
          case ChattingListLoaded:
            return buildListMessage();
          case ChattingListLoading:
          default:
            return buildLoadingScreen();
        }
      },
      listener: (_, state) {
        switch (state.runtimeType) {
          case ChattingListInit:
            developer.log("Chatting room initilized");
            return;
          case ChattingListLoaded:
            developer.log("Chatting list loaded");
            return;
          case ChattingListNoHistory:
            developer.log("Chatting history has nothing");
            break;
        }
      },
    ));
  }

  Widget buildListMessage() {
    var chatInfo = chattingListCubit.chatInfo;
    var user = chattingListCubit.user;

    // If the scroll is at the top, load 20 more chats from the server
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        // Set condition as pixels is not 0 because this ListView is reversed
        chattingListCubit.loadMoreChats();
      }
    });

    return StreamBuilder(
        stream: chattingListCubit.chatHistory,
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.hasError) {
                return buildErrorScreen();
              } else if (!snapshot.hasData) {
                chattingListCubit.thereIsNoHistory();
                return buildNoHistoryScreen();
              } else {
                return ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, index) {
                      var message = snapshot.data.docs[index];
                      var chatDirection = message["idFrom"] == user.id
                          ? ChatDirection.send
                          : ChatDirection.receive;

                      return ChattingMessage(
                          chatDirection == ChatDirection.send
                              ? chatInfo.fromUser
                              : chatInfo.toUser,
                          message["content"],
                          chatDirection);
                    },
                    itemCount: snapshot.data.docs.length,
                    controller: scrollController);
              }
              break;
            case ConnectionState.waiting:
              return buildLoadingScreen();
            case ConnectionState.none:
            default:
              return buildErrorScreen();
          }
        });
  }

  Widget buildNoHistoryScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoadingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorScreen() {
    return Center(
      child: Text("Server connection error"),
    );
  }
}
