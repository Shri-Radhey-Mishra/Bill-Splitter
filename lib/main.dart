import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'pages/expense_input_page.dart';

void main() => runApp(ExpenseSplitterApp());

class ExpenseSplitterApp extends StatelessWidget {
  const ExpenseSplitterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Splitter',
      theme: ThemeData(
        scaffoldBackgroundColor: light90,
        primaryColor: purple100,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: dark100, fontSize: 16),
          bodyMedium: TextStyle(color: purple200),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: purple10,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: purple100,
            foregroundColor: light100,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: ExpenseInputPage(),
    );
  }
}
