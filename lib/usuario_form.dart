import 'dart:convert';

import 'input_field.dart';
import 'usuario.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'usuario_model.dart';

class UsuarioForm extends StatefulWidget {
  final UsuarioModel? usuario;
  const UsuarioForm({this.usuario, Key? key}) : super(key: key);

  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  UsuarioModel usuario = UsuarioModel();

  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      usuario = widget.usuario!;
    }
  }

  @override
  Widget build(BuildContext context) {
    String senha = "";
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _key,
        child: Column(
          children: [
            GestureDetector(
              onTap: _tirarFoto,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _foto(),
                ),
              ),
            ),  
            InputField(
              "Nome",
              Icons.autofps_select_sharp,
              false,
              initialValue: usuario.nome,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo não pode ficar vazio";
                }
                return null;
              },
              onsaved: (value) {
                usuario.nome = value;
              },
            ),
            InputField(
              "Email",
              Icons.mail,
              false,
              initialValue: usuario.email,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return "Informe um email válido";
                }
                return null;
              },
              onsaved: (value) {
                usuario.email = value;
              },
            ),
            InputField(
              "Senha",
              Icons.password,
              true,
              validator: (value) {
                if ((value!.isEmpty || value.length < 3) &&
                    (usuario.id == null)) {
                  return "A senha deve ter ao menos 3 caracteres";
                } else {
                  senha = value;
                }
                return null;
              },
              onsaved: (value) {
                usuario.senha = senha;
              },
            ),
            InputField(
              "Confirmação",
              Icons.add_to_photos_outlined,
              true,
              validator: (value) {
                if (value != senha) {
                  return "Confirmação de senha deve ser igual a senha";
                }
                return null;
              },
            ),
            Row(children: [
              Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          salvar(usuario);
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Salvar")))
            ])
          ],
        ),
      ),
    ));
  }

  salvar(UsuarioModel usuario) async {
    try {
      if (usuario.id == null) {
        //se for usuario novo
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: usuario.email!, password: usuario.senha!);
        usuario.id = userCredential.user!.uid;
      } else if (usuario.senha?.isNotEmpty ?? false) {
        await FirebaseAuth.instance.currentUser!.updatePassword(usuario.senha!);
      }
      await UsuarioRepository().salvar(usuario);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('A senha informada é muito fácil.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email já foi utilizado por outra conta.')));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> _tirarFoto() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      photo!.readAsBytes().then((imagem){

      setState(()  {
         
         usuario.foto = base64Encode(imagem);
         
      });

      });
      
    } catch (e) {
      // ignore: avoid_print
      print("Erro selecionando a foto do usuario: $e");
    }
  }

  _foto() {
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
