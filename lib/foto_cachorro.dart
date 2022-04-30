import 'dart:convert';
import 'package:flutter/material.dart';

class FotoCachorro {
  String? foto;

  FotoCachorro(this.foto);

  ImageProvider getImage() {
    if (foto != null) {
      if (foto!.contains("https")) {
        return NetworkImage(foto!);
      } else {
        return MemoryImage(base64Decode(foto!));
      }
    } else {
      return const ExactAssetImage("imagens/dogcam.jpg");
    }
  }
}
