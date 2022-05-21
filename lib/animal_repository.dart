import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findpet/models/animal_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AnimalRepository {
  Future<void> salvar(AnimalModel animal) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var col = firestore.collection("animais");
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

    if (animal.foto != null) {
      var filename = animal.id! + ".jpg";
      var ref = FirebaseStorage.instance.ref(filename);
      await ref.putData(base64Decode(animal.foto!));
      var url = await ref.getDownloadURL();
      await col.doc(animal.id).update({'foto': url});
    }
  }

  Future<List<AnimalModel>> listar() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var col = firestore.collection("animais");
      QuerySnapshot<Map<String, dynamic>>   snapshot = await col.get();
      
      return snapshot.docs.map((e) => AnimalModel.fromMap(e.data())).toList();

  }
}
