import 'package:findPet/input_field.dart';
import 'package:flutter/material.dart';

class UsuarioRecuperar extends StatelessWidget {
  const UsuarioRecuperar({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar Senha"),
      ),
      body: Container(
        child: Column(
          children: [
            /*InputField(
              "Senha",
              Icons.password,
              true,
              onsaved: (senha) => usuario.senha = senha,
            ),*/
          ],
        ),
      ), 
    );
  }
}