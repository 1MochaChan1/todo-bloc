import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/models/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// Emit(output) a state of type
/// ThemeData.

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: appThemeData[AppTheme.LightTheme])) {
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) async
  {
    emit (ThemeState(themeData: appThemeData[event.theme]));
  }
}
