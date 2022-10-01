import 'package:cloud_firestore/cloud_firestore.dart';
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
  Widget build(BuildContext context) {
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leadingWidth: 300,
          leading: Row(
            children: [
              const SizedBox(width: 10),
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
                const SizedBox(width: 5),
                Text(
                  user!.displayName!,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(width: 10),
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
                const SizedBox(width: 10),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("docs").snapshots(),
              builder: (context, snapshot) {
                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 24),
                        child: const Text(
                          "Create New Document",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator()),
                      ),
                    if (snapshot.data != null)
                      ...List.generate(
                        snapshot.data!.docs.length,
                        (index) => InkWell(
                          onTap: () {
                            Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .doc = snapshot.data!.docs[index].data();
                            context.go("/document");
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Container(
                              width: 220,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 24),
                              child: Text(
                                snapshot.data!.docs[index].data()["doc_name"],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                );
              }),
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

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if (firebaseUser != null) {
        setState(() {
          user = firebaseUser;
        });
      } else {
        context.go("/");
      }
    });
    super.initState();
  }
}
