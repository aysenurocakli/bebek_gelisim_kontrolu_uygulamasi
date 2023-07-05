import 'package:bitirme2/Screens/WelcomeUser/baby_value.dart';
import 'package:bitirme2/Screens/WelcomeUser/user_screen.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/dropDownButton.dart';
import 'package:bitirme2/components/iconButton.dart';
import 'package:bitirme2/components/inputBox.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../components/backIconButton.dart';
import '../../main.dart';
import '../../model/AnneUser.dart';

class AddPercentilScreen extends StatefulWidget {
  final int index; // Add the bebek parameter to the constructor

  const AddPercentilScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<AddPercentilScreen> createState() => _AddPercentilScreenState();
}

class _AddPercentilScreenState extends State<AddPercentilScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _headController = TextEditingController();

  void printBebekValues(Bebek? bebek) {
    if (bebek != null) {
      print('Bebek ad soyad: ${bebek.ad_soyad}');
      print('dogum_sekli: ${bebek.dogum_sekli}');
      print('dogum yeri: ${bebek.dogum_yeri}');
      print('Persentil Values: ${bebek.persentil}');
    }
  }
 

  void addPercentileToBebek(int bebekIndex, double percentile, String key) async {
    // Retrieve the specific bebek object
    Bebek? specificBebek = currentAnne?.bebekler[bebekIndex];

    // Add the percentile value to the specific bebek
    specificBebek?.persentil[key] = percentile;

    // Update the bebek document in Firestore
    if (specificBebek != null) {
      try {
        DocumentSnapshot anneSnapshot = await FirebaseFirestore.instance
            .collection('anneler')
            .doc(currentAnne?.mail)
            .get();
        Map<String, dynamic> anneData = anneSnapshot.data() as Map<String, dynamic>;
        List<Map<String, dynamic>> bebeklerData = [];
        for (var bebek in currentAnne!.bebekler) {
          bebeklerData.add(bebek.toJson());
        }
        anneData['bebekler'] = bebeklerData;

        await FirebaseFirestore.instance
            .collection('anneler')
            .doc(currentAnne?.mail)
            .set(anneData);

        print('Percentile added to Firestore successfully');
      } catch (e) {
        print('Error updating bebek document: $e');
      }
    } else {
      print('Specific bebek is null');
    }
    // Print the specific bebek values
    printBebekValues(specificBebek);
  }

  double calculatePercentile(double basCevresi, double boy, double kilo){
    double percentile=0;
    double minPercentile=26.65;
    double maksPercentile=47.8;
    double gap = maksPercentile-minPercentile;
    double ratio = (basCevresi*0.33 + boy*0.33 + kilo*0.33)/ (3.0);
    double distanceToMinPercentile = minPercentile-ratio ;
    percentile = (distanceToMinPercentile/gap)*100;
    return double.parse(percentile.toStringAsFixed(4));;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _secilenAy = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTopArea(_secilenAy),
                buildToAddButton(_secilenAy),
                SizedBox(height: 30,),
                BackIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildToAddButton(TextEditingController _secilenAy) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 9.h),
      child: RoundedButton(
        text: 'Ekle',
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: () {
          print('Button clicked!');
          final String selectedValue = _secilenAy.text;
          print("secilen Ay");
          print(selectedValue);
          int bebekIndex = 0; //buraya hangi bebeğe ekleneceği bilgisi yani index'İ gelecek
          double basCevresi = double.parse(_headController.text);
          double boy = double.parse(_heightController.text);
          double kilo = double.parse(_headController.text);
          double percentile = calculatePercentile(basCevresi, boy, kilo);
          print(percentile);
          addPercentileToBebek(bebekIndex, percentile, selectedValue);
          final int indexOfBaby = widget.index;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BabyValue(index : indexOfBaby)),
          );
          // ekleme yaparken _secilenAy textini de persentil ekle fonsiyonuna key value olarak göndereceğiz
        },
      ),
    );
  }

  Widget buildHeadInputbox() {
    return TextWithInputbox(
      label: 'Baş Çevresi(cm) :',
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _headController,
    );
  }

  Padding buildTopArea(TextEditingController _secilenAy) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildNewPercentilText(),
          buildMonthText(),
          buildMonthButton(_secilenAy),
          buildHeightInputbox(),
          buildWeighttInputBox(),
          buildHeadInputbox(),
        ],
      ),
    );
  }

  TextWithInputbox buildWeighttInputBox() {
    return TextWithInputbox(
      label: 'Kilo (kg) :',
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _weightController,
    );
  }

  TextWithInputbox buildHeightInputbox() {
    return TextWithInputbox(
      label: 'Boy (cm) :',
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _heightController,
    );
  }

  DropDownButton buildMonthButton(TextEditingController _secilenAy) {
    return DropDownButton(controller: _secilenAy);
  }

  Widget buildMonthText() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Ay:',
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

  Widget buildNewPercentilText() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Yeni Persentil:',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
