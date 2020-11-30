class MusicModel{
  String nome;
  String banda;
  String url;

  MusicModel({
    this.nome,
    this.banda,
    this.url
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    nome: json["nome"],
    url: json["url"],
    banda: json["banda"],
  );

}