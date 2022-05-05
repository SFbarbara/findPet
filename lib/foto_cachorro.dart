import 'dart:convert';
import 'package:flutter/material.dart';

class FotoCachorro {
  String? imagemAlternativa;
  String? foto;

  FotoCachorro(this.foto, {this.imagemAlternativa});

  getImage() {

    if (foto != null) {
      if (foto!.contains("https")) {
        return NetworkImage(foto!);
      } else {
        return MemoryImage(base64Decode(foto!));
      }
    } else {
      return ExactAssetImage(imagemAlternativa??"imagens/dogcam.jpg");
    }
  }
  
}
