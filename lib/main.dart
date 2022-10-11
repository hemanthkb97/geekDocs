import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // TODO: use your config here
    options: const FirebaseOptions(
        apiKey: "",
        appId: "",
        messagingSenderId: "",
        projectId: "",
        authDomain: "",
        databaseURL: "",
        storageBucket: ""),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
      ],
      child: const App(),
    ),
  );
}
