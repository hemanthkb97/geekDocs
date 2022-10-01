import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geekydocs/geek_docs.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // print("User --->    ${FirebaseAuth.instance.currentUser}");
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leadingWidth: 300,
        leading: Row(
          children: [
            Icon(
              Icons.article,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
            Text(
              "Geek Docs",
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      FirebaseAuth.instance.currentUser!.displayName!
                          .substring(0, 1),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  )),
              Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          )
        ],
      ),
      body: Container(
        child: TextButton(
            onPressed: () async {
              await context.read<AuthenticationProvider>().userLogout();
              context.go('/');
            },
            child: Text("Logout")),
      ),
    );
  }
}
