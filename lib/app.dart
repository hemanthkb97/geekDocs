import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "Geek Docs",
          builder: (context, child) => ResponsiveWrapper.builder(child,
              minWidth: 1000,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
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
