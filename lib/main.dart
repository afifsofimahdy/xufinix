import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:ufinix/screens/loginpage.dart';
import 'package:ufinix/screens/mainpage.dart';

import 'dataprovider/appdata.dart';
//import 'package:ufinix/screens/mainpage.dart';
//import 'package:ufinix/screens/registrationpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:297855924061:ios:c6de2b69b03a5be8',
            apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
            projectId: 'flutter-firebase-plugins',
            messagingSenderId: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:541716887289:android:d3a310afdb28fa96bc1428',
            apiKey: 'AIzaSyCw_25fZcdS4hyvJWr8L28nwa6vDmxlqTM',
            messagingSenderId: '297855924061',
            projectId: 'flutter-firebase-plugins',
            databaseURL: 'https://geetaxi-931c7.firebaseio.com',
          ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Brand-Regular',
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
