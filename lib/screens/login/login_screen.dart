import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    UiSizeConfig().init(context);
    return Center(
      child: Card(
        elevation: 15,
        child: SizedBox(
          width: 500.toResponsiveWidth,
          height: 650.toResponsiveHeight,
          child: Text(
            "Geek Docs",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
