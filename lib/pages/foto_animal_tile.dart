import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../foto_cachorro.dart';

// ignore: must_be_immutable
class FotoAnimalTile extends StatelessWidget {
  final String? foto;
  final Function(String? foto) onGetFoto;
  const FotoAnimalTile(this.foto, this.onGetFoto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          GestureDetector(
              onTap: _fotoAnimal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: Container(
                      width: 100,
                      height: 100,
                      color: const Color.fromARGB(255, 77, 74, 74),
                      child: Image(image: FotoCachorro(foto).getImage())),
                  elevation: 5,
                ),
              ))
        ],
      );

  Future<void> _fotoAnimal() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

      photo!.readAsBytes().then((imagem) {
        onGetFoto(base64Encode(imagem));
      });
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao selecionar a foto do Animal: $e");
    }
  }

  void setState(Null Function() param0) {}
}
