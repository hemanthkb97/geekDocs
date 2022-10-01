import 'dart:convert';
import 'dart:html' as html;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:geekydocs/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class DocumentEditPage extends StatefulWidget {
  const DocumentEditPage({Key? key}) : super(key: key);

  @override
  State<DocumentEditPage> createState() => _DocumentEditPageState();
}

class _DocumentEditPageState extends State<DocumentEditPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerVertical = ScrollController();
  final ScrollController _editorScroll = ScrollController();
  TextSelection _selection =
      const TextSelection(baseOffset: 0, extentOffset: 0);
  late quill.QuillController _controller;
  FocusNode focusNode = FocusNode();
  String? _streamedValues = "";
  late FirebaseDatabase firebaseDatabaseference;
  dynamic json;
  bool viewMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      endDrawer: Drawer(
        width: 300,
        child: Column(
          children: [
            Container(
              width: 300,
              color: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Center(
                child: Text(
                  "Comments",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
                },
                title: const Text(
                  "Hemanth Kumar b",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: const Text("hell comments"),
              ),
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) => Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  right: 24, left: 24, top: 16, bottom: 8),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5))),
              child: Flex(
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Geek Docs - Text Document",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PopupMenuButton<String>(
                            child: const Text(
                              "File",
                              style: TextStyle(fontSize: 14),
                            ),
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                    value: "new",
                                    child: Text(
                                      "New File",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    )),
                                const PopupMenuItem(
                                    value: "rename",
                                    child: Text(
                                      "Rename",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ))
                              ];
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              viewMode = !viewMode;
                              setState(() {});
                            },
                            child: Text(
                              viewMode ? "Edit Mode" : "View",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  if (Responsive.isMobile(context))
                    const SizedBox(
                      height: 12,
                    )
                  else
                    const Spacer(),
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: const Text(
                        "Comments",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!viewMode)
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5))),
                child: quill.QuillToolbar.basic(
                  controller: _controller,
                  showAlignmentButtons: false,
                  showDividers: false,
                  showStrikeThrough: false,
                  showInlineCode: false,
                  showDirection: false,
                  showListCheck: false,
                  showClearFormat: false,
                  toolbarIconSize: 16,
                  showListNumbers: false,
                  showIndent: false,
                  showUndo: false,
                  showRedo: false,
                  showBackgroundColorButton: false,
                  showQuote: false,
                  showCodeBlock: false,
                  showHeaderStyle: false,
                  showListBullets: false,
                  iconTheme: const quill.QuillIconTheme(
                      iconUnselectedColor: Colors.black),
                ),
              ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  controller: _scrollControllerVertical,
                  child: Center(
                    child: RawScrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness: 8,
                      thumbColor: Colors.red,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Listener(
                          onPointerDown: _onPointerDown,
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 800, maxWidth: 800, minHeight: 1000),
                            margin: const EdgeInsets.only(
                                top: 24, right: 24, left: 24),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: kElevationToShadow[2]),
                            child: DefaultTextStyle(
                              style: const TextStyle(color: Colors.black),
                              child: quill.QuillEditor(
                                expands: false,
                                padding: const EdgeInsets.all(24),
                                controller: _controller,
                                scrollController: _editorScroll,
                                autoFocus: true,
                                focusNode: focusNode,
                                scrollable: false,
                                readOnly: viewMode,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        context.go("/");
      }
    });
    firebaseDatabaseference = FirebaseDatabase.instance;
    DatabaseReference ref = firebaseDatabaseference.ref("value");

    _controller = quill.QuillController(
      document: json != null ? quill.Document.fromJson(json) : quill.Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );

    _controller.addListener(() {
      setState(() {
        _streamedValues = jsonEncode(_controller.document.toDelta().toJson());

        Future.delayed(const Duration(milliseconds: 1), () {
          firebaseDatabaseference.ref('value').set(_streamedValues);
        });
      });
    });

    ref.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      _selection = _controller.selection;
      _controller.dispose();
      setState(() {
        _streamedValues = dataSnapshot.value.toString();
        json = jsonDecode(_streamedValues ?? "");
        _controller = quill.QuillController(
          document:
              json != null ? quill.Document.fromJson(json) : quill.Document(),
          selection: _selection,
        );

        _controller.addListener(() {
          setState(() {
            _streamedValues =
                jsonEncode(_controller.document.toDelta().toJson());
            Future.delayed(const Duration(milliseconds: 1), () {
              firebaseDatabaseference.ref('value').set(_streamedValues);
            });
          });
        });
        focusNode.requestFocus();
      });
    });
  }

  Future<void> _onPointerDown(PointerDownEvent event) async {
    html.window.document.onContextMenu.listen((evt) => evt.preventDefault());
    if (_controller.selection.isCollapsed) {
      return;
    }
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      final overlay =
          Overlay.of(context)!.context.findRenderObject() as RenderBox;
      final menuItem = await showMenu<int>(
          context: context,
          items: [
            const PopupMenuItem(
                value: 1,
                child: Text(
                  'Add Comment',
                  style: TextStyle(fontWeight: FontWeight.normal),
                )),
          ],
          position: RelativeRect.fromSize(
              event.position & const Size(48.0, 48.0), overlay.size));

      if (menuItem != null) {
        String text = "";
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actionsPadding: const EdgeInsets.only(right: 20, bottom: 20),
              actions: [
                InkWell(
                  onTap: () {
                    print(_controller.selection);
                  },
                  child: Container(
                    color: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Comment",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      text = value;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }
}
