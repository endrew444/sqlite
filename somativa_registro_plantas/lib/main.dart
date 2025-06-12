import 'package:flutter/material.dart';
import 'package:somativa_registro_plantas/view/home_screen.dart';

void main() {
  runApp(const JardimVirtualApp());
}

class JardimVirtualApp extends StatelessWidget {
  const JardimVirtualApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jardim Virtual',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
