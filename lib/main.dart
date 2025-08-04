import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visiting_card/Home.dart';
import 'package:visiting_card/Theme/DarkTheme.dart';
import 'package:visiting_card/Theme/LightTheme.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'bloc/info_bloc.dart';
import 'bloc/theme_bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DbBloc()),
        BlocProvider(create: (context) => InfoBloc()),
        BlocProvider(create: (context) => ThemeBloc()..add(LoadTheme())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Theme Switcher',
            theme: lightthemedata,
            darkTheme: darkthemedata,
              
            
            themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: Home(),
          );
        },
      ),
    );
  }
}
