import 'package:bitirme2/Screens/WelcomeDoctorUser/asi_takvimi.dart';
import 'package:bitirme2/Screens/WelcomeUser/add_percentile_screen.dart';
import 'package:bitirme2/Screens/WelcomeUser/get_baby_values.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../components/backIconButton.dart';
import '../../main.dart';
import '../../model/AnneUser.dart';

class BabyValue extends StatefulWidget {
  final int index; // Add the bebek parameter to the constructor

  const BabyValue({Key? key, required this.index}) : super(key: key);

  @override
  State<BabyValue> createState() => _BabyValueState();
}
// bu sayfada currentAnne'den ilgili bebeğin değerlerini çekeceğiz ve
// context olarak göndereceğiz ?????


class _BabyValueState extends State<BabyValue> {


  Bebek bebek = Bebek();

  void printBebekValues(Bebek? bebek) {
    if (bebek != null) {
      print("....... baby value in welcomeUser ......");
      print('Bebek ad soyad: ${bebek.ad_soyad}');
      print('Bebek foto: ${bebek.foto}');
      print('dogum_sekli: ${bebek.dogum_sekli}');
      print('dogustan gelen hastalik: ${bebek.dogustan_gelen_hastalik}');
      print('dogum yeri: ${bebek.dogum_yeri}');
      print('Persentil Values: ${bebek.persentil}');
    }
  }

  Future<AnneUser?> getUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('anneler')
        .doc(currentAnne?.mail) // Replace with the actual user ID
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      currentAnne =AnneUser.fromJson(data);
      return currentAnne;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    setState(() {
      bebek = currentAnne!.bebekler[widget.index];
    });
  }

  @override
  Widget build(BuildContext context) {

    //final Bebek? bebek = currentAnne.bebekler[widget.index];
    print("xxxxxxxx------xxxxxxxx");
    print(widget.index);
    //int indexOfBaby = widget.index;
    //Bebek bebek = currentAnne!.bebekler[indexOfBaby];
    print("babay values screen'de tıkladığımızda dönen bebeklerin değerleri");
    printBebekValues(bebek);

    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  buildBabyNameText(),
                  buildValueButtons(),
                  Padding(
                    padding: const EdgeInsets.only(top: 230.0),
                    child: BackIconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
        ],
      ),
    ),
    ),
    ),
    );
  }

  Padding buildBabyNameText() {
    return Padding(
                  padding: EdgeInsets.only(left: 5.w,top: 20.h),
                  child: Text(
                            '${bebek.ad_soyad} Bebeğin;', //${widget.bebek.ad_soyad}
                            style:TextStyle(
                            fontSize: 25,
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                           ),
                  ),
                );
  }

  Padding buildValueButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: Column(
        children: [
          buildValueButton(),
          SizedBox(height: 16.0), // 16 birimlik bir boşluk ekleyelim
          buildAddPercentilButton(),
          SizedBox(height: 16.0), // 16 birimlik bir boşluk daha ekleyelim
          buildVaccineButton(),
        ],
      ),
    );
  }

  RoundedButton buildVaccineButton() {
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

  RoundedButton buildAddPercentilButton() {
    return RoundedButton(
        text:  'Percentil Ekle',
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: (){
          final int indexOfBaby = widget.index;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPercentilScreen(index : indexOfBaby)),
          );
        }
    );
  }

  RoundedButton buildValueButton() {
    return RoundedButton(
      text: 'Değerleri',
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {
        if(bebek!= null){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetBabyValuesScreen(bebek: bebek ),
            ),
          );
        }
        else{

        }
      }
    );
  }
}