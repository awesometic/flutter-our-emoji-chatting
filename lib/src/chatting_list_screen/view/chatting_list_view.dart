import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chatting_list_screen.dart';

class ChattingList extends StatefulWidget {
  const ChattingList({Key key}) : super(key: key);

  @override
  _ChattingListState createState() => _ChattingListState();
}

class _ChattingListState extends State<ChattingList> {
  ChattingListCubit _chattingListCubit;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(
        keepScrollOffset: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _chattingListCubit,
      child: BlocConsumer<ChattingListCubit, ChattingListState>(
        bloc: _chattingListCubit,
        builder: (context, state) => ListView.builder(
          itemBuilder: (context, index) => ChattingListChatroom(),
          itemCount: 10, // TODO: Have to be changed to a real number from database
          controller: _scrollController,
        ),
        listener: (context, state) {
          switch (state.runtimeType) {
            case Init:
              break;
            case Loaded:
              break;
            case Notify:
              break;
          }
        },
      ),
    );
  }
}
