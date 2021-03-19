import 'package:equatable/equatable.dart';

abstract class LoginSocialState extends Equatable {}

class LogOutState extends LoginSocialState {
  @override
  List<Object> get props => [];
}

class LogInState extends LoginSocialState {
  @override
  List<Object> get props => [];
}

class InitialState extends LoginSocialState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginSocialState {
  @override
  List<Object> get props => [];
}

class LoadedState extends LoginSocialState {
  @override
  List<Object> get props => [];
}

class ErrorState extends LoginSocialState {
  @override
  List<Object> get props => [];
}
