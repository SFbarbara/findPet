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
        title: const Text("Cadastre seu animal")
      ),
      body: Center(
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
              ],
            ),
          ),
        ),
      ),

    );
  }
}

Future<void> _fotoAnimal() async {

}