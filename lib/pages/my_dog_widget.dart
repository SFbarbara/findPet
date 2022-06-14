import 'package:findpet/foto_cachorro.dart';
import 'package:flutter/material.dart';

import '../models/animal_model.dart';
import 'animal_page.dart';

class MyDogWidget extends StatelessWidget {
  final AnimalModel mydog;
  final Function alterado;
  const MyDogWidget(this.mydog, this.alterado, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AnimalPage(animal: mydog),
      ));
      alterado();
      },
      child: Column(
        children: [
          // ignore: unnecessary_string_interpolations
          Text("${mydog.nome ?? ''}",),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: FotoCachorro(mydog.foto).getImage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
