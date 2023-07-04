import 'dart:convert';
import 'dart:io';

import 'package:bitirme2/Screens/WelcomeDoctorUser/asi_takvimi.dart';
import 'package:bitirme2/Screens/WelcomeDoctorUser/doctor_query_screen.dart';
import 'package:bitirme2/Screens/WelcomeDoctorUser/doctor_screen_baby_values.dart';
import 'package:bitirme2/Screens/WelcomeDoctorUser/doctor_screen_percentil_values.dart';
import 'package:bitirme2/components/backIconButton.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/AnneUser.dart';

//Bebeğin fotoğrafının gözüktüğü ve (değerleri/aylık persentil/aşı takvimi) butonlarının
//görüntülendiği sayfa

// buradaki back iconu geri giderken geçmiş sayfadaki contex degeri temizlemeli

class DoctorValues extends StatefulWidget {
  final Bebek bebek; // Add this line to define the parameter

  const DoctorValues({Key? key, required this.bebek}) : super(key: key);

  @override
  State<DoctorValues> createState() => _DoctorValuesState();
}

class _DoctorValuesState extends State<DoctorValues> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //String? user= widget.bebek.ad_soyad;
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              buildBabyValueText(),
              SizedBox(height: 12.0),
              buildPhotoContainer(),
              SizedBox(height: 50.0),
              buildTopArea(),
              buildBottomNavigationBar(),
            ]
          ),
          ),
        ),
      ),
     // bottomNavigationBar: buildBottomNavigationBar(),
    );
  }


  Widget buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.only(top: 150.0),
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildIBackButton(context),
            buildLogout(),
          ],
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

  Widget buildIBackButton(BuildContext context) {
    return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorQueryScreen()),
                );
              },
            );
  }

  Widget buildPhotoContainer() {
    bool fileExists = widget.bebek.foto != null && File(widget.bebek.foto!).existsSync();

    if (fileExists) {
      // Fotoğraf dosyası cihazda bulunuyorsa fotoğrafı gösterir.
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          child: Image.file(
            File(widget.bebek.foto!),
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      // Fotoğraf dosyası yoksa
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: 180,
          height: 180,
          color: Colors.grey, // veya başka bir gösterge
          child: Center(
            child: Text(
              'Fotoğraf Bulunamadı.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget buildVaccineButton() {
    return RoundedButton(
              text:  'Aşı Takvimi',
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AsiTakvimi()),
                );
              }
          );
  }

  Widget buildAddPercentilButton() {
    return RoundedButton(
              text:  'Aylık Persentil Değerleri',
              color: Colors.deepPurple,
              textColor: Colors.white,
      onPressed:(){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DoctorPercentilValues(bebek : widget.bebek,)),
        );
      },
          );
  }
  Widget buildTopArea() {
    return Padding(
      padding: EdgeInsets.only(left: 1.w,top: 2.h,right:32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildValueButton(),
          SizedBox(height: 13.0),
          buildAddPercentilButton(),
          SizedBox(height: 13.0),
          buildVaccineButton(),

        ],
      ),
    );
  }

  Widget buildValueButton() {
    return RoundedButton(
                text: 'Değerleri',
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BabyValues( bebek: widget.bebek,)),
                  );
                }
            );
  }

  Padding buildBabyValueText() {
    return Padding(
            padding: EdgeInsets.only(left: 9.w,top: 8.h),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Text(
                  '${widget.bebek.ad_soyad} Bebeğin;',
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
}
