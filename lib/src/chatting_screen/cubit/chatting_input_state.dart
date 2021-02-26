import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../model/user_text.dart';

class ChattingInputState extends Equatable {
  const ChattingInputState({
    this.userText = const UserText.pure(),
    this.status = FormzStatus.pure,
  });

  final UserText userText;
  final FormzStatus status;

  @override
  List<Object> get props => [userText, status];

  ChattingInputState copyWith({UserText userText, FormzStatus status}) =>
      ChattingInputState(
          userText: userText ?? this.userText, status: status ?? this.status);
}
