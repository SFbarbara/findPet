/*import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findpet/models/animal_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AnimalRepository{
  Future<void> salvar(AnimalModel animal) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var col = firestore.collection("animais");
    var doc = await col.doc(animal.id).get();
    if(doc.exists){
      await col.doc(animal.id).update(animal.toJson());
    } else {
      await col.doc(animal.id).set(animal.toJson());
    }

    if(animal.foto!=null){
      var filename = animal.id!+".jpg";
      var ref = FirebaseStorage.instance.ref(filename);
      await ref.putData(base64Decode(animal.foto!));
      var url = await ref.getDownloadURL();
      await col.doc(animal.id).update({'foto':url});
    }
  }
}*/