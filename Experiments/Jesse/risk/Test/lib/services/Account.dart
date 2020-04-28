import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class UserAccount {
  Future<bool> signedIn = Future.value(false);
  GoogleSignInAccount googleUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  UserAccount() {
    ///Checks for login changes to google account, sets logged in to true
    ///also attempts to log user in if they have signed in with google previously
    _googleSignIn.onCurrentUserChanged.listen((
        GoogleSignInAccount account) async {
      if (account != null) {
        signedIn = Future.value(true);
        googleUser = _googleSignIn.currentUser;
      } else {
        signedIn = Future.value(false);
        googleUser = null;
      }
    });

    _googleSignIn.signInSilently();

    ///facebook login
    ///
    ///

  }

  Future<bool> createAccount(String email, String username) async{
    var uid = Uuid().v5(email, "userdata");
    String _username = username;


  }

   String getEmail(){
      if(googleUser != null){
        return googleUser.email;
      }else{
        return _googleSignIn.currentUser.email;
      }
   }

  ///Returns true on a successful sign in attempt
  ///[Method] 0 for google, 1 for facebook
  Future<void> SignIn(int method) async {
    switch (method) {
      case 0:
        {
          try {
            await _googleSignIn.signIn();
          } catch (e) {
            log(e.toString());
          }
        }
        break;

      case 1:
        {

        }
        break;

      case 2:
        {
          try {
            _googleSignIn.signOut();
          }
          catch (e) {
            log(e.toString());
          }
        }
        break;
    }
  }

  Future<void> SignOut(int method) async {
    switch (method) {
      case 0:
        {
          try {
            _googleSignIn.signOut();
          }
          catch (e) {
            log(e.toString());
          }
        }
        break;
      case 1:
        {

        }
        break;
    }
  }
}