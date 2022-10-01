import 'package:flutter/material.dart';
import 'package:geekydocs/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Geeky Docs",
      routerConfig: mainRouter,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
