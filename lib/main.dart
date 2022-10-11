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

class Configurations {
  static const _apiKey = "AIzaSyACi1B8eK__w6W-8RqXREtBOgnIFfFZ9I4";
  static const _authDomain = "collaborative-tool.firebaseapp.com";
  static const _projectId = "collaborative-tool";
  static const _databaseURL =
      "https://collaborative-tool-default-rtdb.firebaseio.com";
  static const _storageBucket = "collaborative-tool.appspot.com";
  static const _messagingSenderId = "840479392416";
  static const _appId = "1:840479392416:web:d736e102028adfddf13fc5";

  String get apiKey => _apiKey;
  String get appId => _appId;
  String get authDomain => _authDomain;
  String get databaseURL => _databaseURL;
  String get messagingSenderId => _messagingSenderId;
  String get projectId => _projectId;
  String get storageBucket => _storageBucket;
}
