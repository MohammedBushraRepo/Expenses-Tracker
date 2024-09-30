import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

//Main Color Scheme 
var KColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
// Dark Mode Color 
var KDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 6, 99, 125),
);

void main() {
  runApp(
    MaterialApp( //Dark Mode Configuration
      darkTheme: ThemeData.dark().copyWith(
       
        colorScheme: KDarkColorScheme,
        cardTheme:  const CardTheme().copyWith(
          color: KDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
         elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: KDarkColorScheme.primaryContainer,
            foregroundColor:  KDarkColorScheme.onPrimaryContainer,
          ),
         ),
      ),
      //Main Mode Configuration
      theme: ThemeData().copyWith(
        // scaffoldBackgroundColor: Color.fromARGB(255, 149, 124, 218),
        colorScheme: KColorScheme, //recommanded ,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: KColorScheme.onPrimaryContainer,
          foregroundColor: KColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: KColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: KColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: KColorScheme.onSecondaryContainer,
                  fontSize: 14),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
