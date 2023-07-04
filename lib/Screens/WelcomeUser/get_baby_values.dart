import 'package:bitirme2/components/backIconButton.dart';
import 'package:bitirme2/components/background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/textButton.dart';
import '../../main.dart';
import '../../model/AnneUser.dart';

class GetBabyValuesScreen extends StatefulWidget {
  final Bebek bebek;

  const GetBabyValuesScreen({Key? key, required this.bebek}) : super(key: key);
  @override
  State<GetBabyValuesScreen> createState() => _GetBabyValuesScreenState();
}

class _GetBabyValuesScreenState extends State<GetBabyValuesScreen> {
  String? topukKani;
  String? kalcaCikigi;
  String? duymaTesti;
  //String? bebekAdi = bebek.ad_soyad;

  void printBebekValues(Bebek? bebek) {
    if (bebek != null) {
      print("--------xxxx----- get_baby_values ----xxxx---------");
      print('Bebek ad soyad: ${bebek.ad_soyad}');
      print('dogustan gelen hastalik: ${bebek.dogustan_gelen_hastalik}');
      print('dogum_sekli: ${bebek.dogum_sekli}');
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
      currentAnne = AnneUser.fromJson(data);
      return currentAnne;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    topukKani = widget.bebek.topuk_kani_problem;
    kalcaCikigi = widget.bebek.kalca_cikigi_taramasi_yapildi_mi;
    duymaTesti = widget.bebek.duyma_testi_yapildi_mi;
  }


  @override
  Widget build(BuildContext context) {
    printBebekValues(widget.bebek);
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 70.0),
              child: Column(
                children: [
                  buildBabyNameText(widget.bebek),
                  SizedBox(height: 15,),
                  buildPercentileList(context),
                  buildTestValues(context),
                  SizedBox(height:15.0,),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0 ,bottom: 8.0),
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
      ),
    );
  }

  Widget buildPercentileList(context) {

    buildPercentileText(context);

    final sortedKeys = widget.bebek.persentil.keys.toList()..sort();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final key = sortedKeys[index];
        final value = widget.bebek.persentil[key];

        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 54),
                child: Text(
                  key.toString() ?? 'ay',
                  style: const TextStyle(
                    fontSize: 19,
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              flex: 6,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  //width: 80,
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
                      value.toString() ?? '---',
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  Padding buildTestValues(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          buildTopukKaniValue(context),
          buildKalcaCikigiValue(),
          buildDuymaTestiValue(),
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
              duymaTesti ?? '',
              style: const TextStyle(fontSize: 16.0),
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              kalcaCikigi ?? '',
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
              topukKani ?? '',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPercentileText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Text(
                'Persentil',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Text buildBabyNameText(Bebek bebek) {
  return  Text(
    '${bebek.ad_soyad} Bebeğin\nDeğerleri;',
    style: TextStyle(
      fontSize: 25,
      fontFamily: 'Montserrat',
      color: Colors.white,
    ),
    textAlign: TextAlign.start,
  );
}
