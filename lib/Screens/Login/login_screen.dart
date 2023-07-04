import 'package:bitirme2/Screens/SignUp/signup_screen.dart';
import 'package:bitirme2/Screens/WelcomeDoctorUser/doctor_login_screen.dart';
import 'package:bitirme2/Screens/WelcomeUser/user_screen.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/customTextField.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:bitirme2/components/textButtonUnderline.dart';
import 'package:bitirme2/components/textFieldContainer.dart';
import 'package:bitirme2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';
import '../../model/AnneUser.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {

      final DocumentSnapshot userSnapshot = await _firestore.collection('anneler').doc(email).get();
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTopArea(),
                buildWelcome(context),
                buildLoginForm(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          buildLoginTitle(size),
          buildEmailFormField(),
          buildPasswordFormField(),
          buildSignUp(size),
          buildLoginButton(),
        ],
      ),
    );
  }

  Row buildTopArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: buildDoctorLogin()),
        Expanded(child: buildLogo()),
      ],
    );
  }

  Image buildLogo() => Image.asset('assets/images/Mother.png');

  Widget buildLoginButton() {
    return RoundedButton(
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
          var data = await _firestore.collection('anneler').doc(email).get();
          if (data.exists) {
            print("data exists");
            Map<String, dynamic>? firebaseData = data.data();
            if (firebaseData != null) {
              print("firebase not null");
              print(firebaseData);
              AnneUser anne = AnneUser.fromJson(firebaseData);
              currentAnne = anne;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserScreen()),
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
    );
  }

  Widget buildSignUp(Size size) {
    return Column(
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
              MaterialPageRoute(builder: (context) => SignUp_Screen()),
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

  Widget buildDoctorLogin() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 0.0),
      child: MyTextButton(
        color: Colors.deepPurple,
        text: 'Doktor Girişi',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoctorLoginScreen()),
          );
        },
        child: Container(),
      ),
    );
  }

  Widget buildLoginTitle(Size size) {
    return const Text(
      'Giriş Yap',
      style: TextStyle(
        fontSize: 25,
        fontFamily: 'Montserrat-Extraligth',
        color: kPrimaryColor,
      ),
    );
  }

  Widget buildWelcome(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 10.0),
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
