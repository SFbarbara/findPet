import 'package:findpet/models/animal_model.dart';

class AnimalPerdidoModel {
  String? id;
  AnimalModel animal;

  AnimalPerdidoModel(
    this.id,
    this.animal,
  );

  Map<String, dynamic> toJson() {
    return {
      "id: ": id,
      "animal: ": animal.toJson(),
    };
  }

  factory AnimalPerdidoModel.fromMap(Map<String, dynamic> snapshot) {
    return AnimalPerdidoModel(
        snapshot['id'], AnimalModel.fromMap(snapshot['animal']));
  }
}
