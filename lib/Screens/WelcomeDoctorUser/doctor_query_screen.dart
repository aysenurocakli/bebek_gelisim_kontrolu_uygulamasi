import 'package:bitirme2/Screens/WelcomeDoctorUser/baby_doctor_values.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/customTextField.dart';
import 'package:bitirme2/components/inputBox.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:bitirme2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/AnneUser.dart';

class DoctorQueryScreen extends StatefulWidget {
  const DoctorQueryScreen({Key? key}) : super(key: key);

  @override
  State<DoctorQueryScreen> createState() => _DoctorQueryScreenState();
}

class _DoctorQueryScreenState extends State<DoctorQueryScreen> {

  String? user = currentDoctor?.isim; // burda girilen doktor'un adı firestoredan çekilmeli

  final TextEditingController _tcNumberController = TextEditingController();


  /*Future<Bebek?> queryFirestore(String tcKimlikNumber) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot snapshot = await firestore.collection('anneler').get();

    final List<DocumentSnapshot> documents = snapshot.docs;

    for (final DocumentSnapshot document in documents) {
      final Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null) {
        final List<dynamic> bebeklerData = data['bebekler'] ?? [];
        final List<Bebek> bebekler = bebeklerData.map((bebekData) {
          return Bebek.fromJson(bebekData);
        }).toList();

        for (final Bebek bebek in bebekler) {
          if (bebek.tc_kimlik == tcKimlikNumber) {
            print(bebek.ad_soyad);
            print(bebek.dogum_tarihi);
            return bebek; // Match found
          }
        }
      }
    }

    return null; // No match found
  }
  */

  Future<dynamic> queryFirestore(String tcKimlikNumber) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot snapshot = await firestore.collection('anneler').get();

    final List<DocumentSnapshot> documents = snapshot.docs;

    for (final DocumentSnapshot document in documents) {
      final Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null) {
        final List<dynamic> bebeklerData = data['bebekler'] ?? [];
        final List<Bebek> bebekler = bebeklerData.map((bebekData) {
          return Bebek.fromJson(bebekData);
        }).toList();

        for (final Bebek bebek in bebekler) {
          if (bebek.tc_kimlik == tcKimlikNumber) {
            print(bebek.ad_soyad);
            print(bebek.dogum_tarihi);
            return bebek; // Match found
          }
        }
      }
    }

    return null; // No match found
  }

  // bebeği return etsin , return ettiği değer bebek olsun

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildUserWelcomeText(),
                buildDoctorQueryText(),
                buildTcNumberInputBox(),
                buildCheckButton(),
                buildLogout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogout() {
    return IconButton(
      icon: const Icon(Icons.exit_to_app_rounded),
      tooltip: 'Logout',
      onPressed: () {
        // Perform logout operation
        // Clear the current doctor user session

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login', // Replace with the route name of your LoginScreen
              (route) => false, // Remove all the routes above LoginScreen
        );
      },
    );
  }

  Padding buildCheckButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Column(
        children: [
          RoundedButton(
            text: 'Kontrol Et',
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: () async {
              Bebek? foundedBaby = await queryFirestore(_tcNumberController.text);

              if (foundedBaby != null) { /// bebek != null
                // Match found, perform the desired action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorValues (bebek : foundedBaby)),
                );
              } else { //
                print("eşleşen tc bulunamadı");
              }
            },
          ),
        ],
      ),
    );
  }

  Padding buildTcNumberInputBox() {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, top: 2.h, right: 22),
      child: TextField(
        controller: _tcNumberController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 7, horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }

  Widget buildDoctorQueryText() {
    return Padding(
      padding: EdgeInsets.only(left: 7.w, top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Bakmak İstediğiniz Hastanın\n TC Kimlik Numarası:',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildUserWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 130),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: 'Hoş Geldin\nDoktor ${currentDoctor?.isim}',
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

}