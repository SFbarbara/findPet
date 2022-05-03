import 'dart:convert';

import 'package:findpet/input_field.dart';
import 'package:findpet/models/usuario_model.dart';
import 'package:findpet/foto_usuario.dart';

import '../usuario.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
<<<<<<< HEAD
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _key,
        child: Column(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: FotoUsuario(usuario).getImage(),
                ),
              ),
            ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children:[
                      ElevatedButton.icon(
                        onPressed: (){
                          _tirarFoto(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("Camera"),
                      )
                    ],
                  ),
                ),
                Row(
                  children:[
                    ElevatedButton.icon(
                      onPressed: (){
                        _tirarFoto(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image_search_outlined),
                      label: const Text("Galeria"),
                    )
                  ],
                ), 
              ],
            ), 
            const SizedBox(
                 height: 20,
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
              "Confirmação da senha",
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
=======
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
                    backgroundImage: FotoUsuario(usuario).getImage(),
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
                "Confirmação da senha",
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
>>>>>>> e4ff0649be42401fcd71e32b7fb5dd810d3fbc0b
        ),
      ),
    );
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email já foi utilizado por outra conta.')));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> _tirarFoto(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? photo = await _picker.pickImage(source: source);

      photo!.readAsBytes().then((imagem) {
        setState(() {
          usuario.foto = base64Encode(imagem);
        });
      });
    } catch (e) {
      // ignore: avoid_print
      print("Erro selecionando a foto do usuario: $e");
    }
  }
}
