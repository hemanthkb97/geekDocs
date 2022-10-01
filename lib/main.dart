import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyACi1B8eK__w6W-8RqXREtBOgnIFfFZ9I4",
        appId: "1:840479392416:web:d736e102028adfddf13fc5",
        messagingSenderId: "840479392416",
        projectId: "collaborative-tool",
        authDomain: "collaborative-tool.firebaseapp.com",
        databaseURL: "https://collaborative-tool-default-rtdb.firebaseio.com",
        storageBucket: "collaborative-tool.appspot.com"),
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
