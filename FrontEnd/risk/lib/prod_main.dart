import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerServices(production: true);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(new Risk());
  });
}