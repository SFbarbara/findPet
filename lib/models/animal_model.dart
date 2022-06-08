class AnimalModel {
  String? id;
  String? nome;
  String? raca;
  String? nasc;
  String? foto;
  String? genero;
  String? descricao;
  List<String?> fotos = List.filled(10, null);

  AnimalModel({
    this.id,
    this.nome,
    this.raca,
    this.nasc,
    this.foto,
    this.genero,
    this.descricao,
  });

  Map<String, dynamic> toJson() {
    return {
      "nome: ": nome,
      "raça: ": raca,
      "nascimento: ": nasc,
      "foto: ": foto,
      "genêro: ": genero,
      "descrição: ": descricao,
    };
  }

  factory AnimalModel.fromMap(Map<String, dynamic> snapshot) {
    return AnimalModel(
        id: snapshot['id'],
        descricao: snapshot['descricao'],
        nome: snapshot['nome'],
        raca: snapshot['raca'],
        nasc: snapshot['nasc'],
        foto: snapshot['foto'],
        genero: snapshot['genero']);
  }
}
