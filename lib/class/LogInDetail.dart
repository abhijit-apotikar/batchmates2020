import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LogInDetail {
  final GoogleSignIn googleSignIn;
  final FirebaseUser user;
  LogInDetail(this.googleSignIn,this.user);
}
