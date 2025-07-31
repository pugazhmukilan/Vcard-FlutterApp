import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDarkMode: false)) {
    on<LoadTheme>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool('isDarkMode') ?? false;
      emit(ThemeState(isDarkMode: isDarkMode));
    });

    on<ToggleTheme>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final newThemeMode = !state.isDarkMode;
      await prefs.setBool('isDarkMode', newThemeMode);
      emit(ThemeState(isDarkMode: newThemeMode));
    });
  }
}
