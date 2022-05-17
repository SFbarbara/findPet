import 'package:findpet/models/usuario_model.dart';
import 'package:findpet/pages/usuario_form.dart';
import 'package:flutter/material.dart';


class UsuarioPage extends StatelessWidget {
  final UsuarioModel? usuario;
  const UsuarioPage({this.usuario, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: UsuarioForm(pusuario:usuario),
    );
  }
}