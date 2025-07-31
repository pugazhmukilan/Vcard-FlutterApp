part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {}
