import 'package:application/screens/welcome_screen.dart';
import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: lightMode,
      home: const WelcomeScreen(),
    );
  }
}



