import 'package:flutter/material.dart';
import 'package:gobuyme/src/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buyme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
      ),
      initialRoute: Login.id,
      routes:{
        Login.id : (context) => Login(),
      }
    );
  }
}