class UsuarioModel {
  String? id;
  String? nome;
  String? email;
  String? senha;
  String? foto;

  UsuarioModel({this.id, this.nome, this.email, this.senha, this.foto});

  Map<String, dynamic> toJson() {
    return {"nome":nome,"email":email};
  }
}
