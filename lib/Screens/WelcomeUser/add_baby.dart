import 'package:bitirme2/Screens/WelcomeUser/user_screen.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/fotoIslem.dart';
import 'package:bitirme2/components/iconButton.dart';
import 'package:bitirme2/components/inputBox.dart';
import 'package:bitirme2/components/inputBoxWithoutLabel.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:bitirme2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../components/backIconButton.dart';
import '../../model/AnneUser.dart';


class AddBabyScreen extends StatefulWidget {
  const AddBabyScreen({Key? key}) : super(key: key);

  @override
  State<AddBabyScreen> createState() => _AddBabyScreenState();
}


class _AddBabyScreenState extends State<AddBabyScreen> {
  final TextEditingController _nameSurname=TextEditingController();
  final TextEditingController _tcNumber=TextEditingController();
  final TextEditingController _sickness=TextEditingController();
  final TextEditingController _birthDate=TextEditingController();
  final TextEditingController _birthPlace=TextEditingController();
  final TextEditingController _pregnancyProblem=TextEditingController();
  final TextEditingController _chronicDisease=TextEditingController();
  final TextEditingController _birthNumber=TextEditingController();
  final TextEditingController _basOlcusu=TextEditingController();
  final TextEditingController _kilo=TextEditingController();
  final TextEditingController _boy=TextEditingController();
  final TextEditingController _yapilanAsi=TextEditingController();
  final TextEditingController _duymaTestiYapidiMi = TextEditingController();
  final TextEditingController _kalcaCikigiTaramasi = TextEditingController();
  final TextEditingController _topukKaniProblem = TextEditingController();
  final TextEditingController _cinsiyet = TextEditingController();
  final TextEditingController _dogumSekli = TextEditingController();
  String? secilenFotoUrl;


  FirebaseFirestore _firestore = FirebaseFirestore.instance;



  void onPhotoSelected(String photoUrl) async {
    print('Photo selected: $photoUrl');
    setState(() {
      secilenFotoUrl = photoUrl;
    });
    print("onPhotoSelected :::::::  ");
    print(secilenFotoUrl);
    await Future.delayed(Duration.zero); // Await the next event loop
  }


  double calculatePercentile(double basCevresi, double boy, double kilo){
    double percentile=0;
    double minPercentile=26.65;
    double maksPercentile=47.8;
    double gap = maksPercentile-minPercentile;
    double ratio = (basCevresi*0.33 + boy*0.33 + kilo*0.33)/ (3.0);
    double distanceToMinPercentile = minPercentile-ratio ;
    percentile = (distanceToMinPercentile/gap)*100;
    return percentile;

  }


  void bebekEkle() async {
     Bebek yeniBebek = Bebek(
      foto: secilenFotoUrl ?? "",
      ad_soyad: _nameSurname.text,
      tc_kimlik: _tcNumber.text,
      dogum_tarihi: _birthDate.text,
      dogum_yeri: _birthPlace.text,
      dogustan_gelen_hastalik: _sickness.text,
      gebelikte_sorun_oldu_mu: _pregnancyProblem.text,
      kronik_hastalik_var_mi: _chronicDisease.text,
      yapilan_asilar: _yapilanAsi.text,
      annenin_kacinci_dogumu: _birthNumber.text,
      duyma_testi_yapildi_mi: _duymaTestiYapidiMi.text,
      kalca_cikigi_taramasi_yapildi_mi: _kalcaCikigiTaramasi.text,
      topuk_kani_problem: _topukKaniProblem.text,
      dogum_sekli: _dogumSekli.text,
      cinsiyet: _cinsiyet.text,
      dogumdaki_bas_cevresi: _basOlcusu.text,
      dogumdaki_boy: _boy.text,
      dogumdaki_kilo: _kilo.text,
     //yeniBebek.persentil: {"0. ay":calculatePercentile(double.parse(_basOlcusu.text),double.parse(_boy.text),double.parse(_kilo.text))},

    );

    /*double basCevresi = double.parse(_basOlcusu.text);
    double boy = double.parse(_boy.text);
    double kilo = double.parse(_kilo.text);
    double percentile = calculatePercentile(basCevresi, boy, kilo);

    Map<String, double> persentilMap = {"0. ay": percentile};
    yeniBebek.persentil['0. ay'] = calculatePercentile(basCevresi, boy, kilo);*/
    print("bebek ekle fonk içi");
    print(yeniBebek.foto);
    try {

      var data=await _firestore.collection('anneler').doc(currentAnne!.mail).get();

      Map<String,dynamic> firebaseData=data.data() as Map<String,dynamic>;
      AnneUser anne=AnneUser.fromJson(firebaseData);
      anne.bebekler.add(yeniBebek);

      await _firestore.collection('anneler').doc(currentAnne!.mail).set(anne.toJson());

      setState(() {
        anne.bebekler;
      });

     /* var data2=await _firestore.collection('anneler').doc(currentAnne!.mail).get();
      Map<String,dynamic> firebaseData2=data2.data() as Map<String,dynamic>;
      print(firebaseData2);*/

    } catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                FotoIslem(

                  onPhotoSelected: onPhotoSelected,

                  /* (photoUrl) {
                    print(" +++++++++++++  secilenFotoUrl: +++++++++++++++++");
                  setState(() {
                      secilenFotoUrl = photoUrl;
                    });
                    print(secilenFotoUrl);
                    // İstediğiniz Firestore işlemlerini yapabilirsiniz
                    // Örneğin:
                    // firestore.collection('photos').add({'photoUrl': photoUrl});
                  },*/
                ),
                buildBabyText(), // Bebeğin text yazısı
                buildForm1(), //
                buildGirlBoyName(), // kız erkek buton
                buildBirthTypeInput(), //normal sezaryan
                buildAtBirthText(), // Dğumdaki text yazısı
                buildBasOlcusuInput(),
                buildKiloInput(),
                buildBoyInput(),
                buildYapilanAsiInput(),
                buildTopukKaniInput(),
                buildKalcaCikigiInput(),
                buildDuymaTestiInput(),
                buildEkleButton(),
                BackIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  Padding buildEkleButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: RoundedButton(
        text: 'Ekle',
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: () {

          bebekEkle();

          Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => UserScreen()),
          );
        },
      ),
    );
  }

  Column buildDuymaTestiInput() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Duyma Testi Yapıldı Mı?               ',
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'Montserrat-Extraligth',
              color:Colors.black87,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: Text(
                '(Bebek 1-3 aylar arasındayken kontrol edilmeli)',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat-Extraligth',
                  color:Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        InputboxWithoutText(
          label: ' ',
          hintText: '',
          keyboardType: TextInputType.text ,
          controller: _duymaTestiYapidiMi,
        ),
      ],
    );
  }

  Widget buildKalcaCikigiInput() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Kalça Çıkığı Taraması Yapıldı Mı?',
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'Montserrat-Extraligth',
              color:Colors.black87,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: Text(
                '(Bebek 1-3 aylar arasındayken kontrol edilmeli)',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat-Extraligth',
                  color:Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        InputboxWithoutText(
          label: ' ',
          hintText: '',
          keyboardType: TextInputType.text ,
          controller: _kalcaCikigiTaramasi,
        ),
      ],
    );
  }
  Widget buildTopukKaniInput() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Topuk Kanında Beklenmeyen Bir\nSonuç Var Mı?',
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'Montserrat-Extraligth',
              color: Colors.black87,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: Text(
                '(Buna doğumda bakılmalı)',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat-Extraligth',
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        InputboxWithoutText(
          label: '',
          hintText: '',
          keyboardType: TextInputType.text,
          controller: _topukKaniProblem,
        ),
      ],
    );
  }


  TextWithInputbox buildYapilanAsiInput() {
    return TextWithInputbox(
      label: 'Yapılan Aşıları:',
      hintText: '',
      keyboardType: TextInputType.text ,
      controller: _yapilanAsi,
    );
  }

  TextWithInputbox buildBoyInput() {
    return TextWithInputbox(
      label: 'Boy:',
      hintText: '',
      keyboardType: TextInputType.text ,
      controller: _boy,
    );
  }

  TextWithInputbox buildKiloInput() {
    return TextWithInputbox(
      label: 'Kilo:',
      hintText: '',
      keyboardType: TextInputType.text ,
      controller: _kilo,
    );
  }

  TextWithInputbox buildBasOlcusuInput() {
    return TextWithInputbox(
      label: 'Baş Ölçüsü: ',
      hintText: '',
      keyboardType: TextInputType.text ,
      controller: _basOlcusu ,
    );
  }

  Column buildForm1() {
    return Column(
      children: [
        buildNameSurnameInput(), // adı soyadı
        buildTcNumberInput(), // tc numara
        buildSicknessInput(), // doğustan gelen hastalık
        buildBirthDateInput(), // doğum tarihi
        buildBirthPlaceInput(), // doğumyeri
        buildPregnancyProblemInput(), // doğumda problem
        buildChronicalDiseaseInput(), // kronik hsatalık
        buildBirthNumberInput(), //kaçıncı doğum

      ],
    );
  }

  Widget buildAtBirthText() {
    return const Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Text(
        'Doğumdaki:',
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Montserrat-Extraligth',
          color:Colors.white,

          //textAlign: TextAlign.center,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
  MyButtonGroup buildBirthTypeInput() {
    return MyButtonGroup(
      text1: 'Normal',
      text2: 'Sezeryan',
      onSelected: (selectedText) {
        _dogumSekli.text = selectedText ?? '';
        // Do something with the selected text
      },
    );
  }
  MyButtonGroup buildGirlBoyName(){
    return MyButtonGroup(
      text1: 'Kız',
      text2: 'Erkek',
      onSelected: (selectedText) {
        _cinsiyet.text = selectedText ?? '';
        // Do something with the selected text
      },
    );
  }




  TextWithInputbox buildBirthNumberInput() {
    return TextWithInputbox(
      label: 'Annenin Kaçıncı Doğumu?',
      hintText: '',
      keyboardType: TextInputType.text ,
      controller: _birthNumber,
    );
  }

  TextWithInputbox buildChronicalDiseaseInput() {
    return TextWithInputbox(
      label: 'Anne Babada Kronik Hastalık Var Mı?',
      hintText: '',
      keyboardType: TextInputType.text ,
      controller: _chronicDisease,
    );
  }

  TextWithInputbox buildPregnancyProblemInput() {
    return TextWithInputbox(
        label: 'Gebelikte Sorun Oldu Mu?',
        hintText: '',
        keyboardType: TextInputType.text ,
        controller: _pregnancyProblem
    );
  }

  TextWithInputbox buildBirthPlaceInput() {
    return TextWithInputbox(
      label: 'Doğum Yeri:',
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _birthPlace,
    );
  }

  TextWithInputbox buildBirthDateInput() {
    return TextWithInputbox(
      label: 'Doğum Tarihi:',
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _birthDate,
    );
  }

  TextWithInputbox buildSicknessInput() {
    return TextWithInputbox(
      label: 'Doğuştan Gelen Hastalık:',
      hintText: '',
      keyboardType:TextInputType.text,
      controller: _sickness,
    );
  }

  TextWithInputbox buildTcNumberInput() {
    return TextWithInputbox(
      label: 'TC Kimlik No:',
      hintText: '',
      keyboardType:TextInputType.text,
      maxLength: 11,
      controller:_tcNumber,
    );
  }

  TextWithInputbox buildNameSurnameInput() {
    return TextWithInputbox(
      label: 'Adı Soyadı:',
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _nameSurname,
    );
  }

  Widget buildBabyText() {
    return const Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Text(
        'Bebeğin;',
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Montserrat-Extraligth',
          color:Colors.white,

          //textAlign: TextAlign.center,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
