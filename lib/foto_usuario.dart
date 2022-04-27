import 'dart:convert';
import 'package:findpet/models/usuario_model.dart';
import 'package:flutter/material.dart';

class FotoUsuario {
  UsuarioModel usuario;

  FotoUsuario(this.usuario);
    
  getImage(){

  if (usuario.foto!=null) {
      if (usuario.foto!.contains("https")) {
        return NetworkImage(usuario.foto!);
      } else {
        return MemoryImage(base64Decode(usuario.foto!));
      }
    } else {
      return const ExactAssetImage("imagens/pessoa.jpg");
    }
  }
  
    

  
}