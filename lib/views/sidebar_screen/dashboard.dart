import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  static const String id = 'expense-home';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HOME')),
      body: Center(
        child: Text('Welcome to Home Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
