import 'package:flutter/material.dart';

import '../models/animal_model.dart';

class MyDogWidget extends StatelessWidget {
  final AnimalModel mydog; 
  const MyDogWidget(this.mydog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.amber,
      child: SizedBox(
        height: 100,
        width: 100,
      )
    );
  }
}