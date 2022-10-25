// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meshr_app/firebase_options.dart';
import 'package:meshr_app/provider/google_sign_in.dart';
import 'package:meshr_app/screens/bottom_navigation.dart';
import 'package:meshr_app/screens/drawing_page.dart';
import 'package:meshr_app/screens/gallery_3d.dart';
import 'package:meshr_app/screens/home_page.dart';
import 'package:meshr_app/screens/login_screen.dart';
import 'package:meshr_app/screens/main_menu.dart';
import 'package:meshr_app/screens/notification_screen.dart';
import 'package:meshr_app/screens/settings.dart';
import 'package:meshr_app/screens/step-one-img.dart';
import 'package:meshr_app/screens/step-two-img.dart';
import 'package:meshr_app/screens/step-two.dart';
import 'package:meshr_app/screens/test.dart';
import 'package:meshr_app/screens/view-gallery-3d.dart';
import 'package:meshr_app/screens/view-output-img.dart';
import 'package:provider/provider.dart';


final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init hive
  await Hive.initFlutter();

  // open hive box
  var box = await Hive.openBox('FilesCollection');

  runApp(ChangeNotifierProvider(
    create:(context) => GoogleSignInProvider(),
    child: MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
      ),
      home: HomePage(),
    ),
  ));
}




