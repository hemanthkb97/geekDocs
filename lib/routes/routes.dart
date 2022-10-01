import 'package:geekydocs/screens/edit/document_edit.dart';
import 'package:geekydocs/screens/home/home_screen.dart';
import 'package:geekydocs/screens/login/login_screen.dart';
import 'package:geekydocs/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter mainRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/document',
      builder: (context, state) => const DocumentEditPage(),
    ),
  ],
);
