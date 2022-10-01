import 'package:geekydocs/screens/edit/document_edit.dart';
import 'package:geekydocs/screens/home/home_screen.dart';
import 'package:geekydocs/screens/login/login_screen.dart';
import 'package:geekydocs/screens/splash/splash_screen.dart';
import 'package:geekydocs/shared/authentication_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      redirect: (context, state) {
        final provider =
            Provider.of<AuthenticationProvider>(context, listen: false);
        if (provider.doc == null) {
          return "/home";
        }
        return null;
      },
      builder: (context, state) => const DocumentEditPage(),
    ),
  ],
);
