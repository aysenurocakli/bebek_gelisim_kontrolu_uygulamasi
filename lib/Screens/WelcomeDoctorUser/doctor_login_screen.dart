import 'package:bitirme2/Screens/WelcomeDoctorUser/doctor_query_screen.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/customTextField.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:bitirme2/components/textFieldContainer.dart';
import 'package:bitirme2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../components/textButtonUnderline.dart';
import '../../constants.dart';
import '../../model/DoktorUser.dart';
import 'doctor_signup_screen.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({Key? key}) : super(key: key);

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();

}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {

      final DocumentSnapshot userSnapshot = await _firestore.collection('doktorlar').doc(email).get();
      //("login screen login function data");
      // print(userSnapshot.data());
      if (userSnapshot.exists) {
        final userData = userSnapshot.data();
        if ((userData as Map<String, dynamic>)['sifre'] == password) {
          return true;
        } else {
          Fluttertoast.showToast(
            msg: 'Geçersiz şifre',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 16.0,
          );

          return false;
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Geçersiz email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black.withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    } catch (e) {
      print('Error occurred during login: $e');
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTopArea(),
                buildDoctorLoginText(),
                buildEmailFormField(),
                buildPasswordFormField(),
                buildSignUp(),
                buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildSignUp() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5.0),
            child: const Text(
              'Hesabınız yok mu?',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat-Extraligth',
                color: kPrimaryColor,
              ),
            ),
          ),
          MyTextButton(
            color: Colors.deepPurple,
            text: 'Kayıt Ol',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Doctor_Signup_Screen()),
              );
            },
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.black,
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildLoginButton() {
    return Padding(
      padding:  EdgeInsets.only(left: 4.w,top: 5.h ),
      child: RoundedButton(
                    text: 'Giriş',
                    color: Colors.deepPurple,
                    textColor: Colors.white,
        onPressed: () async {

          final email = _emailController.text;
          final password = _passwordController.text;

          final isValidCredentials = await login(email, password);

          if (isValidCredentials) {
            // Navigate to the home screen or the desired screen
            print("isValidCredentials");
            var data = await _firestore.collection('doktorlar').doc(email).get();
            if (data.exists) {
              print("data exists");
              Map<String, dynamic>? firebaseData = data.data();
              if (firebaseData != null) {
                print("firebase not null");
                print(firebaseData);
                DoktorUser doktor = DoktorUser.fromJson(firebaseData);
                currentDoctor = doktor;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorQueryScreen()),
                );
              } else {
                // Handle null firebaseData case
              }
            } else {
              print("email does not exists");
            }

          } else {
            // Navigate to the signup screen

          }
        },
      ),
    );
  }

  Widget buildPasswordFormField() {
    return TextFieldContainer(
                hintText: 'Şifre',
                icon: Icons.lock,
                icon2: Icons.visibility,
                isObsecure: true,
                keyboardType: TextInputType.none,
                controller: _passwordController,
                onChanged: (value) {
                  // E-posta değeri değiştiğinde yapılacak işlemler
                },
              );
  }

  Widget buildEmailFormField() {
    return TextFieldContainer(
                hintText: 'E-posta',
                icon: Icons.email,
                isObsecure: false,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                onChanged: (value) {
                  // E-posta değeri değiştiğinde yapılacak işlemler
                },
              );
  }
  Widget buildTopArea() {
    return Padding(
      padding: const EdgeInsets.only(top:15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           buildWelcome(),
           buildLogo(),

        ],
      ),
    );
  }
  Image buildLogo() => Image.asset('assets/images/Medical team.png');

  Widget buildDoctorLoginText() {
    return Padding(
        padding: EdgeInsets.only(left: 10.w,top: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
                'Giriş Yap',
                style:TextStyle(
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                  color:Colors.white,
                )
            ),
          ],
        ),
      );
  }


  Widget buildWelcome() {
    return Padding(
                padding: EdgeInsets.only(left: 10.w,top: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    CustomText(
                        text: 'Hoş\nGeldiniz ',
                        textAlign: TextAlign.start,

                    ),

                  ],

          ),
              );
  }
}
//33589099780