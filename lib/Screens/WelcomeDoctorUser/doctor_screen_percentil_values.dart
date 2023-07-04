import 'package:bitirme2/Screens/WelcomeUser/get_baby_values.dart';
import 'package:bitirme2/components/backIconButton.dart';
import 'package:bitirme2/components/background.dart';
import 'package:flutter/material.dart';

import '../../model/AnneUser.dart';

class DoctorPercentilValues extends StatefulWidget {
  final Bebek bebek;
  const DoctorPercentilValues({Key? key, required this.bebek}) : super(key: key);

  @override
  State<DoctorPercentilValues> createState() => _DoctorPercentilValuesState();
}

class _DoctorPercentilValuesState extends State<DoctorPercentilValues> {
  Map<String,String> mapData = {
    '1. Ay':'123',
    '2. Ay':'234',
    '3. Ay':'345'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left:20.0, top:20.0),
              child: Column(
                children: [
                  BackIconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  buildPercentileText(),
                  SizedBox(height: 20.0,),
                  buildPercentileList(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPercentileText(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
          children: const [
            Text(
            'Percentil',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ]
    ),
    );
}
  Widget buildPercentileList(context) {
    final sortedKeys = widget.bebek.persentil.keys.toList()..sort();

    if(widget.bebek.persentil.length != 0){
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
                        value.toString() ?? 'bos bırakılmıs',
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
    else{
      return Text(
        '(Henüz girilen bir persentil değeri yok.)',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black45
        ),
        textAlign: TextAlign.center,
      );
    }

  }
//44044300101



/*
  Widget buildPercentileList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Text(
                'Percentil',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: mapData.length,  //data.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(
                    mapData.keys.toList()[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    width: 170,
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
                    child: Text(
                      mapData.values.toList()[index],
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }*/
}
