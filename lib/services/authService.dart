import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //FirebaseAuth instance-------------------
  FirebaseAuth _auth = FirebaseAuth.instance;

  //---------FirebaseUser Stream----------
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  //---------GoogleSignIn instance-------------
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  //-------sign in with googleSignIn-----------
  Future signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken,
    );
    try {
      AuthResult authResult = await _auth.signInWithCredential(credential);
      FirebaseUser user = authResult.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  //----google Sign out---------
  Future signOutFromGoogle() async {
    try {
      googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //----Register With e-mail-------------
  Future registerWithEmailAndPassword(String email,String password) async{
   try{
     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser user = result.user;
     return user;
   }catch(e){
     print(e.toString());
     return null;
   }
  }

  // ----Sign in with email & password-------
  Future signInWithEmailAndPassword(String email,String password) async {
    try{
       AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       FirebaseUser user = result.user;
       return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
