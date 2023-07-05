import 'dart:convert';
import 'dart:io';
import 'package:bitirme2/components/textButtonUnderline.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FotoIslem extends StatelessWidget {
  final Function(String)? onPhotoSelected;

  const FotoIslem({Key? key, this.onPhotoSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FotoIslemHome(
      onPhotoSelected: onPhotoSelected,
    );
  }
}


class FotoIslemHome extends StatefulWidget {
  final Function(String)? onPhotoSelected;

  const FotoIslemHome({Key? key, this.onPhotoSelected}) : super(key: key);

  @override
  State<FotoIslemHome> createState() => _FotoIslemHomeState();
}

class _FotoIslemHomeState extends State<FotoIslemHome> {
  File? _secilenDosya;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        const SizedBox(height: 20.0,),
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              image: _secilenDosya != null ? DecorationImage(image: FileImage(_secilenDosya!), fit: BoxFit.cover) : null,
            ),
            child: _secilenDosya == null ? Center(child: Text('Bebeğin Fotoğrafı')) : null,
          ),
        ),
        const SizedBox(height: 20.0,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextButton(
              text: 'Fotoğraf Ekle',
              onPressed: () {
                _secimFotoGoster(context);
              },
              color: Colors.black,
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }

  void _secimFotoGoster(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Galeriden Fotoğraf Seç'),
              onTap: () {
                _secimYukle(ImageSource.gallery);
              },
            ),
            ListTile(
              title: Text('Kameradan Fotoğraf Çek'),
              onTap: () {
                _secimYukle(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _secimYukle(ImageSource source) async {
    final picker = ImagePicker();
    final secilen = await picker.getImage(source: source);

    List<int>? imageBytes = await secilen?.readAsBytes();
    String base64Image = imageBytes == null ? '' : base64Encode(imageBytes);

    setState(() {
      if (secilen != null) {
        _secilenDosya = File(secilen.path);
      }
    });

    if (widget.onPhotoSelected != null && secilen != null) {
      widget.onPhotoSelected!(secilen.path);
    }

  }
}
