import 'package:findpet/input_field.dart';
import 'package:findpet/models/animal_model.dart';
import 'package:flutter/material.dart';

class AnimalPage extends StatefulWidget {
  final AnimalModel? animal;
  const AnimalPage({this.animal, Key? key}) : super(key: key);

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AnimalModel animal = AnimalModel();

  bool checkValue = false;

  @override
  void initState() {
    super.initState();
    if (widget.animal != null) {
      animal = widget.animal!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastre seu cachorro")
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
                    onTap: _fotoAnimal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage("https://static.vecteezy.com/ti/vetor-gratis/p1/2668165-coleira-cachorro-cara-bonito-com-osso-animal-animal-de-estimacao-domestico-cartoon-gr%C3%A1tis-vetor.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    "Nome",
                    Icons.autofps_select_sharp,
                    false,
                    initialValue: animal.nome,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Campo não pode ficar vazio";
                      }
                      return null;
                    },
                    onsaved: (value){
                      animal.nome = value;
                    },
                  ),
                  InputField(
                    "Raça",
                    Icons.pets,
                    false,
                    initialValue: animal.raca,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Campo não pode ficar vazio";
                      }
                      return null;
                    },
                    onsaved: (value){
                      animal.raca = value;
                    },
                  ),
                  InputField(
                    "Data de nascimento",
                    Icons.date_range_rounded,
                    false,
                    initialValue: animal.nasc,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Campo não pode ficar vazio";
                      }
                      return null;
                    },
                    onsaved: (value){
                      animal.nasc = value;
                    },
                  ),
                  Column(
                    children: [
                      CheckboxListTile(
                        title: Text("Fêmea"),
                        value: checkValue,
                        onChanged: (bool? valor){
                          setState(() {
                            checkValue = valor!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Macho"),
                        value: checkValue,
                        onChanged: (bool? valor){
                          setState(() {
                            if(checkValue!=null){
                              checkValue = valor!;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  InputField(
                    "Descrição",
                    Icons.description_rounded,
                    false,
                    initialValue: animal.descricao,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Campo não pode ficar vazio";
                      }
                      return null;
                    },
                    onsaved: (value){
                      animal.descricao = value;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: 
                          ElevatedButton.icon(
                            onPressed: () {
                              /*if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                salvar(animal);
                              }*/
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
        ),
      ),
    );
  }
}


/*salvar(AnimalModel animal) async {

}*/


Future<void> _fotoAnimal() async {

}