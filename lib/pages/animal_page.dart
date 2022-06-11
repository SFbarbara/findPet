import 'dart:convert';

import 'package:findpet/animal_perdido_repository.dart';
import 'package:findpet/animal_repository.dart';
import 'package:findpet/foto_cachorro.dart';
import 'package:findpet/input_field.dart';
import 'package:findpet/models/animal_model.dart';
import 'package:findpet/models/animal_perdido_model.dart';
import 'package:findpet/text_input_formater.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../text_input_formater.dart';
import 'foto_animal_tile.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:intl/date_symbol_data_file.dart';

class AnimalPage extends StatefulWidget {
  final AnimalModel? animal;
  const AnimalPage({this.animal, Key? key}) : super(key: key);

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AnimalModel animal = AnimalModel();
  var gravando = false;

  @override
  void initState() {
    super.initState();

    if (widget.animal != null) {
      animal = widget.animal!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _fotos = <FotoAnimalTile>[];

    for (var i = 0; i < animal.fotos.length; i++) {
      _fotos.add(FotoAnimalTile(animal.fotos[i], ((foto) {
        setState(() {
          animal.fotos[i] = foto;
        });
      })));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastre seu cachorro"),
        actions: [
          FloatingActionButton(
              child: const Icon(Icons.report_gmailerrorred),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Animal perdido"),
                    content: const Text(
                        "Você está prestes a fazer uma notificação de perda de animal. Confirma a operação?"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pop(context), // Closes the dialog
                        child: const Text('Não'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await AnimalPerdidoRepository()
                              .salvar(AnimalPerdidoModel(animal)); 
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cachorro adicionado na lista de perdidos.")));
                              
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro adicionando cachorro. Tente mais tarde.")));
                          }
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
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
                        backgroundImage: FotoCachorro(animal.foto,
                                imagemAlternativa:
                                    "imagens/cadastro_animal.png")
                            .getImage(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _fotoAnimal(ImageSource.camera);
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text("Camera"),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _fotoAnimal(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.image_search_outlined),
                            label: const Text("Galeria"),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    "Nome",
                    Icons.autofps_select_sharp,
                    false,
                    initialValue: animal.nome,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo não pode ficar vazio";
                      }
                      return null;
                    },
                    onsaved: (value) {
                      animal.nome = value;
                    },
                  ),
                  InputField(
                    "Raça",
                    Icons.pets,
                    false,
                    initialValue: animal.raca,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo não pode ficar vazio";
                      }
                      return null;
                    },
                    onsaved: (value) {
                      animal.raca = value;
                    },
                  ),
                  InputField(
                    "Data de nascimento",
                    Icons.date_range_rounded,
                    false,
                    inputType: TextInputType.datetime,
                    inputFormatters: [DateTextFormatter()],
                    maxLength: 10,
                    initialValue: animal.nasc,
                    validator: (value) {
                      try {
                        var data = DateTime.parse(formatarDataUS(value!));
                        if (data.isAfter(DateTime.now())) {
                          return "Data de nascimento não pode ser no futuro";
                        }
                        return null;
                      } catch (e) {
                        // ignore: avoid_print
                        print(e);
                        return "Data Inválida";
                      }
                    },
                    onsaved: (value) {
                      animal.nasc = value;
                    },
                  ),
                  ListTile(
                    leading: Radio<String?>(
                      value: "Macho",
                      groupValue: animal.genero,
                      onChanged: (value) {
                        setState(() {
                          animal.genero = value;
                        });
                      },
                    ),
                    title: const Text("Macho"),
                  ),
                  ListTile(
                    leading: Radio<String?>(
                      value: "Fêmea",
                      groupValue: animal.genero,
                      onChanged: (value) {
                        setState(() {
                          animal.genero = value;
                        });
                      },
                    ),
                    title: const Text("Fêmea"),
                  ),
                  InputField(
                    "Descrição",
                    Icons.description_rounded,
                    false,
                    initialValue: animal.descricao,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo não pode ficar vazio";
                      }
                      return null;
                    },
                    onsaved: (value) {
                      animal.descricao = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Inclua 10 fotos do seu cachorro",
                    style: TextStyle(fontSize: 16),
                  ),
                  Wrap(
                    children: _fotos,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      gravando
                          ? const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.red)),
                              ),
                            )
                          : Expanded(
                              child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      _key.currentState!.save();

                                      setState(() {
                                        gravando = true;
                                      });
                                      try {
                                        await _salvarAnimal(animal);
                                        setState(() {
                                          gravando = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Cachorro cadastrado com sucesso!"),
                                        ));
                                      } catch (e) {
                                        setState(() {
                                          gravando = false;
                                        });
                                      }
                                      Navigator.pop(context);
                                    }
                                  },
                                  icon: const Icon(Icons.save),
                                  label: const Text("Salvar")),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _salvarAnimal(AnimalModel animal) async {
    await AnimalRepository().salvar(animal);
  }

  Future<void> _fotoAnimal(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? photo = await _picker.pickImage(
          maxHeight: 480, maxWidth: 640, imageQuality: 50, source: source);

      photo!.readAsBytes().then((imagem) {
        setState(() {
          animal.foto = base64Encode(imagem);
        });
      });
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao selecionar a foto do Animal: $e");
    }
  }

  String formatarDataUS(String value) {
    var adata = value.split("/");
    String nstr = "${adata[2]}-${adata[1]}-${adata[0]}";
    // ignore: avoid_print
    print(nstr);
    return nstr;
  }
}
