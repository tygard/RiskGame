
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/src/utils/routeGenerator.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import '../riskHttp.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: [
    'email', "profile"
  ],
);

signOut() {
  _googleSignIn.disconnect();
}

initLogin() {
  _googleSignIn.onCurrentUserChanged
      .listen((GoogleSignInAccount account) async {
    if (account != null) {
      locator<User>().googleID = account.id;
      locator<RouteGenerator>().generateRouteNamed("/home");
    } else {
      locator<RouteGenerator>().generateRouteNamed("/login");
    }
  });
  _googleSignIn.signInSilently();
}

doLogin() async {
  GoogleSignInAccount account = await _googleSignIn.signIn();
  Response sign_in_response = await RiskHttp.makePostRequest("/users/goog/${account.id}/");
  print(account.id);
  print(sign_in_response.headers);
  //Map<String, dynamic> user_model = sign_in_response.data as Map<String, dynamic>;
  //locator<User>().uuid = user_model["id"];
  //locator<User>().name = user_model["username"];
  locator<User>().fromGoogleSignIn(account);
  locator<RouteGenerator>().generateRouteNamed("/home");
}
