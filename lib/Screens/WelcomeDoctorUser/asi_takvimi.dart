import 'package:bitirme2/components/backIconButton.dart';
import 'package:bitirme2/components/background.dart';
import 'package:flutter/material.dart';

class AsiTakvimi extends StatelessWidget {
  const AsiTakvimi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0,left: 10.0,right: 10.0,bottom:35.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/asi_takvimi.jpeg'),
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
}