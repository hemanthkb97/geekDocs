import 'package:firebase_auth/firebase_auth.dart';

class DocumentModal {
  final User currentUser;
  final String docData;
  final String docId;

  DocumentModal({
    required this.currentUser,
    required this.docData,
    required this.docId,
  });
}
