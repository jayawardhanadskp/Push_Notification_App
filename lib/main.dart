import 'package:authentication_app/services/firebase_helper.dart';
import 'package:authentication_app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/sign_up.dart';


late final Widget screen;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseHelper.setupFirebase();
  await NotificationService.initializeNotification();


  screen = FirebaseHelper.homeScreen;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: screen,
    );
  }
}
