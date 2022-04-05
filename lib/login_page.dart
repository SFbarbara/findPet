import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findPet/usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_widget.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UsuarioModel? usuario;

  autenticacao() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('Usuário fez logout!');
        setState(() {
          usuario = null;
        });
      } else {
        print('Usuario fez SigIn!');
        var snapshot =
            FirebaseFirestore.instance.collection('usuarios').doc(user.uid);

        var doc = await snapshot.get();
        if (doc.exists) {
          Map<String, dynamic>? fbUser = doc.data();
          setState(() {
              usuario = UsuarioModel(
                  id: user.uid,
                  nome: fbUser!['nome'],
                  email: user.email,
                  foto: fbUser['foto']);
          });
        } else {
                    setState(() {
              usuario = UsuarioModel(
                  id: user.uid,
                  nome: "",
                  email: user.email,
                  foto: null);
          });

        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    autenticacao();
  }

  @override
  Widget build(BuildContext context) {
    return usuario == null ? LoginWidget() : MainPage(usuario);
  }
}