import 'package:findpet/input_field.dart';
import 'package:findpet/models/usuario_model.dart';
import 'package:findpet/usuario.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'usuario_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool ver = false;
  UsuarioModel usuario = UsuarioModel();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const CircleAvatar(
                backgroundImage: ExactAssetImage('imagens/logo.png'),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: kElevationToShadow[5],
              ),
            ),
            const Text("FindPet", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(
                "Faça login",
                style: GoogleFonts.nanumGothic(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
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
                      const SizedBox(
                        height: 20,
                      ),
                      _botaoEntrar(),
                      const SizedBox(
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
              child: const Text("Entrar")),
        ),
      ],
    );
  }

  _botaoEsqueceu() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Esqueceu sua senha?",
          style: GoogleFonts.dekko(
            fontWeight: FontWeight.w900,
          ),
        ),
        TextButton(
          onPressed: () async {
            _key.currentState?.save();
            try {
              await UsuarioRepository().recuperar(usuario.email!);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Código de recuperação enviado no email")));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Erro: o endereço de e-mail está mal formatado ($e)")));
            }
          },
          child: const Text(
            "Clique aqui",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ]),
    );
  }

  _botaoCadastrar() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Não tem uma conta. ",
          style: GoogleFonts.dekko(
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UsuarioPage()));
          },
          child: const Text(
            "Cadastre-se",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        )
      ]),
    );
  }

  Future<void> _login() async {
    _key.currentState!.save();

    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usuario.email!.trim(), password: usuario.senha!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'usuário não encontrado!') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Usuário não encontrado!")));
      } else if (e.code == 'Senha Incorreta') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Senha incorreta!")));
      } else if (e.code == 'too-many-requests') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Usuario bloqueado por muitas tentativas")));
      }
    }
  }
}
