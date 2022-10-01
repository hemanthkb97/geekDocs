import 'package:geekydocs/screens/document_edit.dart';
import 'package:geekydocs/screens/home_screen.dart';
import 'package:geekydocs/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter mainRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/documents',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => const DocumentEditPage(),
    ),
  ],
);
