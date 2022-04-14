class AnimalModel {
  String? id;
  String? nome;
  String? foto;

  AnimalModel({this.id, this.nome, this.foto});
  

  Map<String, dynamic> toJson() {
    return {"nome: ": nome, "foto: ": foto};
  }
  
}

