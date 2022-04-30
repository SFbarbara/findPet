import 'package:flutter/material.dart';

import '../foto_cachorro.dart';

class FotoAnimalTile extends StatelessWidget {
  final String? foto;
  const FotoAnimalTile(this.foto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: Container(
            width: 100,
            height: 100,
            color: Color.fromARGB(255, 77, 74, 74),
            child: Image(image: FotoCachorro(foto).getImage())),
        elevation: 5,
      ),
    );
  }
}
