import 'package:bitcoin_tracker/constants.dart';
import 'package:bitcoin_tracker/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'screens/price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: LoadingScreen(),
      //PriceScreen(),
    );
  }
}
