
import 'package:flutter/material.dart';
import 'package:bitirme2/components/backIconButton.dart';
import 'package:bitirme2/components/background.dart';


import '../../model/AnneUser.dart';


// Bebeğin doktor tarafında tüm bilgilerinin listelendiği sayfa

class BabyValues extends StatefulWidget {
  final Bebek bebek;

  const BabyValues({Key? key, required this.bebek}) : super(key: key);

  @override
  State<BabyValues> createState() => _BabyValuesState();
}

class _BabyValuesState extends State<BabyValues> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left:20.0, top:70.0),
              child: Column(
                children: [
                  buildBabyNameText(),
                  buildTestValues(context),
                  buildBirthValuesText(),
                  buildBirthValues(context),
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
      ),
    );
  }

  Padding buildTestValues(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [

          buildDogustanGelenHastalik(),
          buildCinsiyetValue(),
          buildDogumCesidi(),
          buildDogumTarihi(),
          buildDogumYeri(),
          buildGebelikteSorun(),
          buildKronikHastalik(),
          buildDogumSayisi(),
          buildTopukKaniValue(context),
          buildKalcaCikigiValue(),
          buildDuymaTestiValue(),

        ],
      ),
    );
  }
  Padding buildBirthValues(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          buildDogumBasOlcu(),
          buildKilo(),
          buildBoy(),
          buildYapilanAsilari(),
        ],
      ),
    );
  }

  Column buildDuymaTestiValue() {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Duyma Testi Sonuçları:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),

        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.duyma_testi_yapildi_mi}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCinsiyetValue() {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Cinsiyet:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.cinsiyet}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGebelikteSorun() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Gebelikte Sorun:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.gebelikte_sorun_oldu_mu}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildKronikHastalik() {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Anne Babada Kronik Hastalık :',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.kronik_hastalik_var_mi}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildDogumYeri() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Doğum Yeri:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.dogum_yeri}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildDogumTarihi() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Doğum Tarihi:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.dogum_tarihi}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildDogumCesidi() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Doğum Çeşidi:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.dogum_sekli}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildDogumSayisi() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Annenin Doğum Sayısı:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.annenin_kacinci_dogumu}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildDogumBasOlcu() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Baş Ölçüsü:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.dogumdaki_bas_cevresi}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildKilo() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Kilo:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.dogumdaki_kilo}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildYapilanAsilari() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Yapılan Aşıları:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.yapilan_asilar}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildTopukKani() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Topuk Kanında Beklenmeyen Bir Sonuç Var Mı? :',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.topuk_kani_problem}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildBoy() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Boy:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.dogumdaki_boy}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildKalcaCikigiValue() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Kalça Çıkığı Değerleri:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.kalca_cikigi_taramasi_yapildi_mi}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildDogustanGelenHastalik() {
    return Column(
      children: [

        Row(
          children: const [
            Text(
              'Doğuştan Gelen Hastalık:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.dogustan_gelen_hastalik}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTopukKaniValue(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Bebeğin Topuk Kanında Belirlenen Hastalıkları:',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${widget.bebek.topuk_kani_problem}",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }

  Text buildBabyNameText() {
    return  Text(
      ' ${widget.bebek.ad_soyad} Bebeğin Değerleri;',
      style:const TextStyle(
        fontSize: 25,
        fontFamily: 'Montserrat',
        color: Colors.white,
      ),
      textAlign: TextAlign.start,
    );
  }
  Text buildBirthValuesText() {
    return  const Text(
      'Doğumdaki:',
      style:TextStyle(
        fontSize: 25,
        fontFamily: 'Montserrat',
        color: Colors.white,
      ),
      textAlign: TextAlign.start,
    );
  }
}
//33589099780



