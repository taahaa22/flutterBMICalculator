import 'package:flutter/material.dart';
import 'homeScreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final title = 'BMI CALCULATOR';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$title',
      color: Colors.grey,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '$title',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.grey.shade700,
          leading: Icon(Icons.man),
        ),
        body: screen(), //screen is class in homescreen.dart
      ),
    );
  }
}
