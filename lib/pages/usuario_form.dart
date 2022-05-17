import 'dart:convert';

import 'package:findpet/input_field.dart';
import 'package:findpet/models/usuario_model.dart';
import 'package:findpet/foto_usuario.dart';

import '../usuario.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../usuario_store.dart';

class UsuarioForm extends StatefulWidget {
  final UsuarioModel? pusuario;
  const UsuarioForm({this.pusuario, Key? key}) : super(key: key);
  
  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  UsuarioModel pusuario = UsuarioModel();
  bool salvando = false; 

  @override
  void initState() {
    super.initState();
    if (widget.pusuario != null) {
      pusuario = widget.pusuario!;
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: FotoUsuario(pusuario).getImage(),
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
              initialValue: pusuario.nome,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo não pode ficar vazio";
                }
                return null;
              },
              onsaved: (value) {
                pusuario.nome = value;
              },
            ),
            InputField(
              "Email",
              Icons.mail,
              false,
              initialValue: pusuario.email,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return "Informe um email válido";
                }
                return null;
              },
              onsaved: (value) {
                pusuario.email = value;
              },
            ),
            InputField(
              "Senha",
              Icons.password,
              true,
              validator: (value) {
                if ((value!.isEmpty || value.length < 3) &&
                    (pusuario.id == null)) {
                  return "A senha deve ter ao menos 3 caracteres";
                } else {
                  senha = value;
                }
                return null;
              },
              onsaved: (value) {
                pusuario.senha = senha;
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
            salvando?Center(child: Column(
              children:  [
                 CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black)),
                Text("Aguarde! Salvando..."),
              ],
            )):
            Row(
              children: [
                Expanded(
                    child: ElevatedButton.icon(
                        onPressed: () async {
                            setState(() {
                              salvando = true;
                            });
                          if (_key.currentState!.validate()) {
                            _key.currentState!.save();
                            
                            try {
                              await salvar(pusuario);
                              setState(() {
                                salvando = false;
                              });
                            } catch (e) {
                              setState(() {
                                salvando = false;
                              });
                            }
                             
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Salvar")
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

  salvar(UsuarioModel pusuario) async {
    try {
      if (pusuario.id == null) {
        //se for pusuario novo
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: pusuario.email!, password: pusuario.senha!);
        pusuario.id = userCredential.user!.uid;
      } else if (pusuario.senha?.isNotEmpty ?? false) {
        await FirebaseAuth.instance.currentUser!.updatePassword(pusuario.senha!);
      }
      await UsuarioRepository().salvar(pusuario);
      usuario.value = pusuario;
      Navigator.of(context).pop(pusuario);
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
          pusuario.foto = base64Encode(imagem);
        });
      });
    } catch (e) {
      // ignore: avoid_print
      print("Erro selecionando a foto do pusuario: $e");
    }
  }
}
