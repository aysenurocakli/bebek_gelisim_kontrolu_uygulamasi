import 'package:flutter/material.dart';
import 'package:bitirme2/constants.dart';


class TextFieldContainer extends StatelessWidget{
  //final Widget child;
  final String hintText;
  final IconData? icon;
  final IconData? icon2;
  final  isObsecure;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged; // <-- onChanged parametresi eklendi.

  const TextFieldContainer({
    Key? key,
    //required this.child,
    required this.hintText,
    this.icon,
    this.icon2,
    this.isObsecure,
    required this.keyboardType,
    required this.controller,
    this.onChanged, // <-- onChanged parametresi eklendi.
  }): super(key : key);

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical:10,),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

      width: size.width*0.8,
      height: size.height*0.06,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: controller, // Assign the controller here
        obscureText: isObsecure,
        decoration: InputDecoration(
          icon: Icon(
          icon,
          color: Colors.black45,
          ),
          suffixIcon: Icon(
            icon2,
            color: Colors.black45,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
