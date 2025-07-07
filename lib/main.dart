// main.dart
import 'package:expense_dashboard/views/main_sreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MainScreen(), // Call MainScreen from main_screen.dart
    );
  }
}
