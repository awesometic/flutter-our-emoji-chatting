import 'package:equatable/equatable.dart';

abstract class ChattingListState extends Equatable {}

class ChattingListInit extends ChattingListState {
  @override
  List<Object> get props => [];
}

class ChattingListLoading extends ChattingListState {
  @override
  List<Object> get props => [];
}

class ChattingListChatInfoSet extends ChattingListState {
  @override
  List<Object> get props => [];
}

class ChattingListNoHistory extends ChattingListState {
  @override
  List<Object> get props => [];
}

class ChattingListRoomReady extends ChattingListState {
  @override
  List<Object> get props => [];
}

class ChattingListReceivingChat extends ChattingListState {
  @override
  List<Object> get props => [];
}

class ChattingListUpdateOdd extends ChattingListState {
  @override
  List<Object> get props => [];
}

class ChattingListUpdateEven extends ChattingListState {
  @override
  List<Object> get props => [];
}
