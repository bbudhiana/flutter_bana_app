import 'package:flutter/material.dart';
import 'package:flutter_bana_app/feature/user/data/models/user_model.dart';
import 'package:flutter_bana_app/util/datasource/query/user_query.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'app.dart';
import 'config/app_config.dart';
import 'di/injection.dart' as di;
import 'feature/user/domain/entities/user.dart';
import 'util/datasource/db_helper.dart';

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
  runApp(const MyApp());

  // Remove splash screen when bootstrap is complete
  FlutterNativeSplash.remove();
}
