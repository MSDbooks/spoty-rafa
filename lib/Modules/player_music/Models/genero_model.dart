class GeneroModel {
  String nome;
  String imageurl;

  GeneroModel({
    this.nome,
    this.imageurl
  });

  factory GeneroModel.fromJson(Map<String, dynamic> json) => GeneroModel(
    nome: json["nome"] == null ? "" : json["nome"],
    imageurl: json["imageurl"] == null ? "" : json["imageurl"] 
  );
}