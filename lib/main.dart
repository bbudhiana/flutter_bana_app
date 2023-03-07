import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'config/app_config.dart';
import 'di/injection.dart' as di;
import 'utils/datasource/prefs.dart';

void main() async {
  ConfigEnvironment.setEnvironment(Environment.trial);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //TEST
  //final DbHelper helper = DbHelper();

  //CEK DATA
  /* helper.getData(UserQuery.tableName).then((value) {
    for (var element in value) {
      UserModel user = UserModel.fromJson(element);
      print(user.toJson());
    }
  }); */

  /* helper.getDataUserByNameAndPassword('alice', 'alice123').then((value) {
    print(value.isEmpty);

    var user = value.isNotEmpty ? UserModel.fromJson(value) : '';
    //UserModel user = UserModel.fromJson(value);
    print(user);
  }); */

  //DROP DATABASE IF SOMETHING WRONG
  /* helper.dropDatabase().then((value) {
    print('berhasil drop database');
  }).catchError((err) {
    print("errornya ${err.toString()}");
  }); */

  /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); */
  di.init();
  await Prefs().initialize();
  runApp(const App());

  // Remove splash screen when bootstrap is complete
  FlutterNativeSplash.remove();
}
