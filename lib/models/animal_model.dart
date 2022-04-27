class AnimalModel {
  String? id;
  String? nome;
  String? raca;
  String? nasc;
  String? foto;
  String? genero;
  String? descricao;
  

  AnimalModel({this.id, this.nome, this.raca, this.nasc, this.foto, this.genero, this.descricao});
  

  Map<String, dynamic> toJson() {
    return {"nome: ": nome, "raça: ": raca, "nascimento: ": nasc, "foto: ": foto, "genêro: ": genero, "descrição: ": descricao};
  }
  
}

