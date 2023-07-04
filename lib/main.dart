import 'package:bitirme2/Screens/Login/login_screen.dart';
import 'package:bitirme2/constants.dart';
import 'package:bitirme2/model/AnneUser.dart';
import 'package:bitirme2/model/DoktorUser.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/WelcomeUser/user_screen.dart';
//görüntünün düzenlenmesi ve ekranın içine biraz daha gelmeleri

AnneUser? currentAnne;
DoktorUser? currentDoctor;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'bitirme2',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kPrimaryLightColor,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(), // Register the LoginScreen route
          '/login': (context) => LoginScreen(),
          '/user': (context) => UserScreen(),
          // Add other routes if necessary
        },
      );

      /* return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'bitirme2',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kPrimaryLightColor,
        ),
        home: LoginScreen(),
      );*/
      });
    }
  }
