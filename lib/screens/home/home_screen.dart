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
  User? user;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if (firebaseUser != null) {
        setState(() {
          user = firebaseUser;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leadingWidth: 300,
          leading: Row(
            children: [
              SizedBox(width: 10),
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
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user!.displayName!.substring(0, 1),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  user!.displayName!,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(width: 10),
                IconButton(
                    key: const Key('logoutButton'),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 22,
                    ),
                    onPressed: () async {
                      await context.read<AuthenticationProvider>().userLogout();
                      context.go('/');
                    }),
                SizedBox(width: 10),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Start a new document",
                style: Theme.of(context).textTheme.headline4,
              ),
              InkWell(
                onTap: () {
                  context.go('/document');
                },
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: 250,
                    height: 380,
                    child: Center(
                      child: Icon(
                        Icons.create,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "Recent Documents",
                style: Theme.of(context).textTheme.headline4,
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  elevation: 5,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      width: 250,
                      height: 380,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                          Divider(
                            color: Colors.grey[200]!,
                            thickness: 1,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.article,
                                    color: Theme.of(context).primaryColor,
                                    size: 27,
                                  ),
                                  Text("Name of doc"),
                                  Spacer(),
                                  Icon(
                                    Icons.info,
                                    color: Theme.of(context).primaryColor,
                                    size: 27,
                                  ),
                                  SizedBox(width: 7)
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
        body: Container(
            child: Center(
                child: CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
    ))));
  }
}
