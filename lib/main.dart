import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'config/app_config.dart';
import 'di/injection.dart' as di;

void main() async {
  ConfigEnvironment.setEnvironment(Environment.trial);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); */
  di.init();
  runApp(const MyApp());

  // Remove splash screen when bootstrap is complete
  FlutterNativeSplash.remove();
}
