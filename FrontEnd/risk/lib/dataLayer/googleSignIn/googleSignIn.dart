
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/src/utils/routeGenerator.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import '../fileSystem.dart';
import '../riskHttp.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: [
    'email', "profile"
  ],
);

signOut() async {
  _googleSignIn.disconnect();
  deleteFile("user.json");
  locator<RouteGenerator>().generateRouteNamed("/login");
}

initLogin() {
  _googleSignIn.onCurrentUserChanged
      .listen((GoogleSignInAccount account) async {
    if (account != null) {
      locator<User>().googleID = account.id;
      Response sign_in_response = await RiskHttp.makePostRequest("/users/goog/${account.id}/");
      print("sing in response: $sign_in_response");
        locator<User>().fromRiskSignIn(sign_in_response);
        locator<RouteGenerator>().generateRouteNamed("/home");
      return true;
    } else {
      locator<RouteGenerator>().generateRouteNamed("/login");
      return false;
    }
  });
  _googleSignIn.signInSilently();
}

doLogin() async {
  GoogleSignInAccount account = await _googleSignIn.signIn();
  Response sign_in_response = await RiskHttp.makePostRequest("/users/goog/${account.id}/");
  print(account.id);
  print(sign_in_response.headers);
  locator<User>().googleID = account.id;
  if(sign_in_response.data.toString().length>0){
    locator<User>().fromUser(User.fromJson(sign_in_response.data));
    locator<RouteGenerator>().generateRouteNamed("/home");
  }else{
    locator<RouteGenerator>().generateRouteNamed("/register");
  }
  //locator<User>().fromGoogleSignIn(account);
  //locator<RouteGenerator>().generateRouteNamed("/home");
}
