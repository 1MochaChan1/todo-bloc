part of 'theme_bloc.dart';

/// Has only one event
/// i.e. The state being changed.

abstract class ThemeEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ThemeChanged extends ThemeEvent{
  final AppTheme theme;

  ThemeChanged({required this.theme});
  List<Object?> get props => [theme];
}