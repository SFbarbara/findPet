import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/animal_perdido_model.dart';

class AnimalPerdidoRepository {
  Future<void> salvar(AnimalPerdidoModel animal) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var col = firestore.collection("animais_perdidos");
    if (animal.id == null) {
      DocumentReference<Map<String, dynamic>> doc =
          await col.add(animal.toJson());
      animal.id = doc.id;
      await doc.update({'id': doc.id});
    } else {
      // ignore: unused_local_variable
      var doc = await col.doc(animal.id).get();
      await col.doc(animal.id).update(animal.toJson());
    }
  }

  Future<List<AnimalPerdidoModel>> listar() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var col = firestore.collection("animais_perdidos");
    QuerySnapshot<Map<String, dynamic>> snapshot = await col.get();

    return snapshot.docs
        .map((e) => AnimalPerdidoModel.fromMap(e.data()))
        .toList();
  }
}
