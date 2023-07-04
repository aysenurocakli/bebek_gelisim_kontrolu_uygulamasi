import 'package:bitirme2/components/background.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../components/backIconButton.dart';

class InfoScreenAboutBaby extends StatelessWidget {
  const InfoScreenAboutBaby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildInfoText(),
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

  Widget buildInfoText() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 35.0),
      child: Column(
                  children: [
                    buildBeslenmeText(),
                    buildYasakliBesinlerText(),
                    buildGelisimOykusuText(),
                  ],
                ),
    );
  }

  Widget buildGelisimOykusuText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,top: 10.0),
      child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Gelişim Öyküsü:\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Baş tutabilme : 3.ay\nOturma: destekli oturma 6 ay\nDesteksiz oturma 7-9 ay\nEmekleme: 6-9 ay\nYürüme: 13-18 ay\nKonuşma: 1 yaş ilk bilinçli kelime söylenir\nİlk diş: 6.ayda çıkmalı.\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                            ),
                          ),

                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '! 1 yaşında diş doktoruna gitmeli.\n! 1 yaşında göz doktoruna gitmeli\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                            ),
                          ),

                        ),
                      ],
                    ),
                  ],
                ),
    );
  }

  Padding buildYasakliBesinlerText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,top: 10.0),
      child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Yasaklı Besinler:\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tuz/Şeker kısıtlı.\nAmbalajlı gıda verilememeli.\nKabuklu deniz hayvanları 3 yaşa kadar verilmez.\nKuruyemişler 3 yaşa kadar verilmemeli.\nBal 1 yaşına kadar verilmemeli.\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
  }

  Widget buildBeslenmeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Beslenme Öyküsü\n',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '6.Ayda ek gıdaya başlanmalı.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
