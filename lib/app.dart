import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "Geek Docs",
          routerConfig: mainRouter,
          themeMode: provider.appTheme == AppTheme.light
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
        );
      },
    );
  }
}
