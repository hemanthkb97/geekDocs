import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UiSizeConfig().init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
