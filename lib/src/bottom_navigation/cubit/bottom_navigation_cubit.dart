import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit(initialState) : super(initialState);

  void setState(index) => emit(index);
}
