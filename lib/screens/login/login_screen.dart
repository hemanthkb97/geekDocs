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
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
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
                  children: [
                    Text("Sign in to Geek Docs",
                        style: Theme.of(context).textTheme.headline1!),
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
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 50.toResponsiveWidth,
                        height: 40.toResponsiveHeight,
                        child: Image.asset(
                          'assets/images/google.png',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 60.toResponsiveWidth),
                      child: Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              // initialValue: "eve.holt@reqres.in",
                              key: const Key('emailField'),
                              cursorColor:
                                  Theme.of(context).textTheme.headline1!.color,
                              decoration: InputDecoration(
                                labelText: 'Email address',
                                isDense: true,
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 28.toResponsiveFont,
                                ),
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15.toResponsiveHeight),
                            TextFormField(
                              // initialValue: R"pistol",
                              key: const Key('passwordField'),
                              cursorColor:
                                  Theme.of(context).textTheme.headline1!.color,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  isDense: true,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 28.toResponsiveFont,
                                  )),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 18.toResponsiveHeight),
                            ElevatedButton(
                              key: const Key('loginButton'),
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {},
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15.toResponsiveFont),
                              ),
                            )
                          ],
                        ),
                      ),
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
