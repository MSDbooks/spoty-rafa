class MusicModel{
  String nome;
  String url;

  MusicModel({
    this.nome,
    this.url
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    nome: json["nome"],
    url: json["url"],
  );

}