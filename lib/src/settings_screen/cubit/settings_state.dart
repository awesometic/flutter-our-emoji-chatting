import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {}

class Init extends SettingsState {
  @override
  List<Object> get props => [];
}

class Loaded extends SettingsState {
  @override
  List<Object> get props => [];
}
