import 'package:google_sign_in/google_sign_in.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/src/utils/routeGenerator.dart';
import 'package:risk/src/utils/serviceProviders.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: [
    'email',
  ],
);

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
  await _googleSignIn.signIn();
}
