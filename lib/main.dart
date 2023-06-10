import 'package:flutter/material.dart';
import 'package:got/gotpage.dart';


void main(){
  return runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.black,
        fontFamily: "Pacifico",
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: GotPage(),
    );
  }
}