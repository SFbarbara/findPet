import 'package:flutter/material.dart';

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
                      width: MediaQuery.of(context).size.width-8,
                      child: Column(
                        children: [
                          Text("${perdido.nome}"),
                          Expanded(
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage("https://static1.patasdacasa.com.br/articles/8/10/38/@/4864-o-cachorro-inteligente-mostra-essa-carac-articles_media_mobile-1.jpg"),),
                          ),
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
                      child: Icon(Icons.camera_alt)
                    ),
                  ),
                ]
              ),
            ],
    );
  }
}