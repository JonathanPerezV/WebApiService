import 'package:flutter/material.dart';
import 'package:web_api_revista/view/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WEB API',
      initialRoute: 'home',
      routes: {'home': (_) => HomePage()},
    );
  }
}
