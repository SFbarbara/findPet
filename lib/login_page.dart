import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findpet/models/usuario_model.dart';
import 'package:findpet/pages/login_widget.dart';
import 'package:findpet/pages/main_page.dart';
import 'package:findpet/usuario_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

  autenticacao() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        // ignore: avoid_print
        print('Usuário fez logout!');
        setState(() {
          usuario.value = null;
        });
      } else {
        // ignore: avoid_print
        print('Usuario fez SigIn!');
        var snapshot =
            FirebaseFirestore.instance.collection('usuarios').doc(user.uid);

        var doc = await snapshot.get();
        if (doc.exists) {
          Map<String, dynamic>? fbUser = doc.data();
          setState(() {
              usuario.value = UsuarioModel(
                  id: user.uid,
                  nome: fbUser!['nome'],
                  email: user.email,
                  foto: fbUser['foto']);
          });
        } else {
                    setState(() {
              usuario.value = UsuarioModel(
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
    return usuario.value == null ? const LoginWidget() : MainPage();
  }
}
