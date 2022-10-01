import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePopup extends StatefulWidget {
  const CreatePopup({super.key});

  @override
  State<CreatePopup> createState() => _CreatePopupState();
}

class _CreatePopupState extends State<CreatePopup> {
  User? user;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();
  Map<String, dynamic> emailAddresses = {};
  String _permissionValue = "Read Mode";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 35,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    //title of the popup
                    "Create a new Document",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  //will close the popup
                  IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.maybePop(context);
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //body of the popup
            Container(
              width: 600,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      // initialValue: R"pistol",
                      key: const Key('titleField'),
                      cursorColor: Theme.of(context).textTheme.headline1!.color,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.article,
                          size: 28,
                        ),
                      ),
                      obscureText: false,
                      controller: _titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title is required.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: const Key('emailField'),
                            cursorColor:
                                Theme.of(context).textTheme.headline1!.color,
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                              isDense: true,
                              prefixIcon: Icon(
                                Icons.email,
                                size: 28,
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
                        ),
                        Container(
                          width: 110,
                          margin: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                          child: DropdownButton<String>(
                            items: <String>['Read Mode', 'Edit Mode']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _permissionValue,
                            onChanged: (String? val) {
                              setState(() {
                                _permissionValue = val!;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 10,
                          margin: const EdgeInsets.fromLTRB(0, 15, 40, 0),
                          child: IconButton(
                            onPressed: () {
                              emailAddresses[_emailController.text] =
                                  _permissionValue == "Read Mode";
                              setState(() {
                                _emailController.text = "";
                              });
                              print(
                                  "Email addresses --->   ${emailAddresses.length}");
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text("Shared With : "),
                    ...List.generate(emailAddresses.length, (index) {
                      dynamic list = emailAddresses.keys.toList();

                      return Container(
                          child: Text(
                              "${list[index]}    ${emailAddresses[list[index]] == true ? "Read Mode" : "Edit Mode"}"));
                    }).toList(),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      key: const Key('createButton'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        emailAddresses[
                            FirebaseAuth.instance.currentUser!.email!] = true;
                        DocumentReference<Map<String, dynamic>> doc =
                            await FirebaseFirestore.instance
                                .collection("docs")
                                .add({
                          'doc_name': _titleController.text,
                          'owner': user!.email,
                          'shared': emailAddresses
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Create',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
