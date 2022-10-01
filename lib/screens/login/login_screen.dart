import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UiSizeConfig().init(context);
    return Center(
      child: Card(
        elevation: 15,
        child: SizedBox(
          width: 1000.toResponsiveWidth,
          height: 650.toResponsiveHeight,
          child: Row(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/login.png',
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign in to Geek Docs",
                        style: Theme.of(context).textTheme.headline1!),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        try {
                          UserCredential userCred = await context
                              .read<AuthenticationProvider>()
                              .signInWithGoogle();
                          context.go('/home');
                        } catch (e) {
                          context.go('/login');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 100.toResponsiveWidth,
                        height: 50.toResponsiveHeight,
                        child: Image.asset(
                          'assets/images/google.png',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 60.toResponsiveWidth),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
