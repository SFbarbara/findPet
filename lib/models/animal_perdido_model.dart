import 'package:findpet/models/animal_model.dart';

class AnimalPerdidoModel {
  String? id;
  AnimalModel animal;

  AnimalPerdidoModel(
    this.animal,
    {this.id}
  );

  Map<String, dynamic> toJson() {
    return {
      "animal: ": animal.toJson(),
    };
  }

  factory AnimalPerdidoModel.fromMap(Map<String, dynamic> snapshot) {
    return AnimalPerdidoModel(
      AnimalModel.fromMap(snapshot['animal: ']),
      id: snapshot['id']
    );
  }
}
