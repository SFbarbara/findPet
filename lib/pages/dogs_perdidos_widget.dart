import 'package:flutter/material.dart';

import '../foto_cachorro.dart';
import '../models/animal_model.dart';
import 'inferir/inferir_page.dart';

class DogsPerdidosWidget extends StatelessWidget {
  final AnimalModel perdido; 
  const DogsPerdidosWidget(this.perdido, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Stack(
                children: [
                  Card(
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width-20,
                      child: Column(
                        children: [
                          Text("${perdido.nome}"),
                           Expanded(
                            child: Image(
                              fit: BoxFit.cover,
                              image:  FotoCachorro(perdido.foto).getImage()
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => InferirPage(perdido))
                        );
                      }, 
                      child: const Icon(Icons.camera_alt)
                    ),
                  ),
                ]
              ),
            ],
    );
  }
}