import 'package:firebase_auth/firebase_auth.dart';

import '../geek_docs.dart';

class AuthenticationProvider extends BaseProvider {
  String userSignupStatus = "user_signup_status";
  String signInWithGoogleStatus = "sign_in_with_google_status";
  String userLogoutStatus = "user_logout_status";
  String fetchUserDataStatus = "fetch_user_data_status";

  String? docId = "";
  bool readOnly = false;

  late UserCredential? userCred;
  void getUserData() async {}

  Future<UserCredential> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      userCred = await FirebaseAuth.instance.signInWithPopup(googleProvider);

      return userCred!;
    } catch (e) {
      throw Error();
    }
  }

  Future<void> userLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  void userSignup(String email, String password) async {}
}
