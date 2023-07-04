import 'package:bitirme2/Screens/WelcomeUser/add_baby.dart';
import 'package:bitirme2/Screens/WelcomeUser/baby_value.dart';
import 'package:bitirme2/Screens/WelcomeUser/get_baby_values.dart';
import 'package:bitirme2/Screens/WelcomeUser/info_about_baby.dart';
import 'package:bitirme2/components/background.dart';
import 'package:bitirme2/components/customTextField.dart';
import 'package:bitirme2/components/roundedButton.dart';
import 'package:bitirme2/components/textButtonUnderline.dart';
import 'package:bitirme2/components/textButton.dart';
import 'package:bitirme2/constants.dart';
import 'package:bitirme2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/AnneUser.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String user = currentAnne?.isim ?? "";

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<AnneUser?>(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final anneUser = snapshot.data;
                      if (anneUser != null) {
                        currentAnne = anneUser; // Update currentAnne with new data
                        return Column(
                          children: [
                            buildTopArea(),
                            buildUserWelcomeText(),
                            buildUserText(),
                            buildBebeklerListView(),
                            buildInfo(),
                            buildNewRecord(),
                          ],
                        );
                      } else {
                        return Text('Document does not exist');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTopArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: buildLogout()),
      ],
    );
  }

  Widget buildLogout() {
    return IconButton(
      icon: const Icon(Icons.exit_to_app_rounded),
      tooltip: 'Logout',
      onPressed: () {
        // Perform logout operation
        currentAnne = null; // Clear the current user session

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login', // Replace with the route name of your LoginScreen
              (route) => false, // Remove all the routes above LoginScreen
        );
      },
    );
  }

  /*IconButton(
    icon: const Icon(Icons.exit_to_app_rounded),
    tooltip: 'Logout',
    onPressed: () {
      // Perform logout operation
      currentAnne = null; // Clear the current user session

      Navigator.pushNamedAndRemoveUntil(
      context,
      '/login', // Replace with the route name of your LoginScreen
      (route) => false, // Remove all the routes above LoginScreen
    );
    },
  ),*/

  void navigateToBabyValue(int index) {
    if (index != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BabyValue(index : index)),
      );
    }
  }
  //problem bu sayfada , yeni bebek ekledikten sonra bu sayfya geçişte o değer güncellenmiyor

  Widget buildBebeklerListView() {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }
        if(snapshot.hasError){
          return Text(snapshot.error.toString(),);
        }
        else{
          currentAnne= snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Disable scrolling within the ListView
            itemCount: currentAnne?.bebekler.length ?? 0,
            itemBuilder: (context, index) {
              final bebek = currentAnne?.bebekler[index];
              return CustomTextButton(
                text: '\n${index + 1}) ${bebek?.ad_soyad ?? ""} Bebek',
                textAlign: TextAlign.center,
                onPressed: () {
                  navigateToBabyValue(index); // Call a separate function to handle navigations
                },
              );
            },
          );
        }
      },
    );
  }
  /*
  * child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(), // Disable scrolling within the ListView
        itemCount: currentAnne?.bebekler.length ,
        itemBuilder: (context, index) {
          final bebek = currentAnne?.bebekler[index];
          return CustomTextButton(
            text: '\n${index + 1}) ${bebek?.ad_soyad ?? ""} Bebek',
            textAlign: TextAlign.center,

            onPressed: () {
              print(currentAnne?.bebekler.length);
              print(bebek);
              navigateToBabyValue(bebek); // Call a separate function to handle navigations
            },
          );
        },
      ),*/
  RoundedButton buildNewRecord() {
    return RoundedButton(
      text: 'Yeni Kayıt Ekle',
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBabyScreen()),
        );
      },
    );
  }

  MyTextButton buildInfo() {
    return MyTextButton(
      text: 'Bebekler Hakkında Bilgilendirme',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoScreenAboutBaby()),
        );
      },
      color: Colors.black45,
      child: Container(),
    );
  }

  Widget buildUserText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Kayıtlı Çocuklarım:',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Montserrat',
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: 'Hoş Geldin\n$user',
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
