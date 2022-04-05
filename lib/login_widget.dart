import 'package:findPet/usuario_recuperar_senha.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_field.dart';

import 'usuario_model.dart';
import 'usuario_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool ver = false;
  UsuarioModel usuario = UsuarioModel();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container( 
                padding: const EdgeInsets.all(8.0),
                child: const  CircleAvatar(backgroundImage:
                  ExactAssetImage('imagens/logo.png'),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: kElevationToShadow[5],
                ),
              ),
             const Text(
                "FindPet",
                style: TextStyle(color: Colors.white)
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(200.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Faça login",
                  style: GoogleFonts.nanumGothic(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InputField(
                          "Email",
                          Icons.email,
                          false,
                          onsaved: (email) => usuario.email = email,
                        ),
                        InputField(
                          "Senha",
                          Icons.password,
                          true,
                          onsaved: (senha) => usuario.senha = senha,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _botaoEntrar(),
                        SizedBox(
                          height: 10,
                        ),
                        _botaoEsqueceu(),
                        _botaoCadastrar(),
                     ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  _botaoEntrar() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _login();
            },
            child: Text("Entrar")
          ),
        ),
      ],
    );
  }

  _botaoEsqueceu() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text(
            "Esqueceu sua senha?",
            style: GoogleFonts.dekko(
              fontWeight: FontWeight.w900,
              //fontSize: 15,
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UsuarioRecuperar()));
            }, 
            child: Text(
              "Clique aqui",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ]
      ),
    );
  }

  _botaoCadastrar() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Text(
            "Não tem uma conta. ", 
            style: GoogleFonts.dekko(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UsuarioPage()));
            },
            child: Text(
              "Cadastre-se",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          )
        ]
      ),
    );
  }

  Future<void> _login() async {
    _key.currentState!.save();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usuario.email!, password: usuario.senha!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email desconhecido!")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Senha incorreta!")));
      } else if (e.code == 'too-many-requests') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuario bloqueado por muitas tentativas")));
      }
    }
  }
}

