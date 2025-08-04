import 'package:flutter/material.dart';

ThemeData lightthemedata = ThemeData(
              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 30, 54)),
                trackColor: WidgetStateProperty.all(const Color.fromARGB(255, 232, 232, 232)),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              
              
              scaffoldBackgroundColor:  const Color.fromARGB(255, 255, 252, 252),
              
              colorScheme: ColorScheme.fromSwatch().copyWith(
                
                primary: const Color.fromARGB(255, 242, 242, 242),
                secondary: const Color.fromARGB(255, 41, 41, 41),
                onSecondary: const Color.fromARGB(255, 41, 41, 41),
              
              ),
            );