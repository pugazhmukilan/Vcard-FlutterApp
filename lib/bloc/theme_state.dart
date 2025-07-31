part of 'theme_bloc.dart';



@immutable
class ThemeState {
  final bool isDarkMode;

  const ThemeState({required this.isDarkMode});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeState &&
          runtimeType == other.runtimeType &&
          isDarkMode == other.isDarkMode;

  @override
  int get hashCode => isDarkMode.hashCode;
}
