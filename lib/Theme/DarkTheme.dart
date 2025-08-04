import 'package:flutter/material.dart';

ThemeData darkthemedata =  ThemeData(
              
              //DONT CHANGE THIS
              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 30, 54)),
                trackColor: WidgetStateProperty.all(const Color.fromARGB(255, 232, 232, 232)),
              ),


              //DONT CHANGE THIS
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              scaffoldBackgroundColor:  Color.fromARGB(255, 11, 11, 11),
              //primaryColor: const Color.fromARGB(255, 20, 103, 145),


              
              colorScheme: ColorScheme.fromSwatch().copyWith(
                
                primary: const Color.fromARGB(255, 36, 36, 36),
                secondary: Color.fromRGBO(224, 224, 224, 1),
                onSecondary: const Color.fromARGB(255, 119, 119, 119),
                tertiary:const Color.fromARGB(255, 178, 178, 178),
                
              ));