import 'package:flutter/material.dart';

import '../models/animal_model.dart';

class MyDogWidget extends StatelessWidget {
  final AnimalModel mydog;
  const MyDogWidget(this.mydog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${mydog.nome}"),
        // ignore: avoid_unnecessary_containers
        Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Stack(
                  children: const [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://static1.patasdacasa.com.br/articles/8/10/38/@/4864-o-cachorro-inteligente-mostra-essa-carac-articles_media_mobile-1.jpg"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
