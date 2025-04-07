import 'package:flutter/material.dart';
import 'package:quiz_app/home_screen.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF6C63FF)
      ),
      home: HomeScreen(),
    );
  }
}
