
class MusicModel{
  String nome;
  String banda;
  String url;
  bool addqueue;

  MusicModel({
    this.nome,
    this.banda,
    this.url,
    this.addqueue
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    nome: json["nome"] == null ? '' : json["nome"],
    url: json["url"] == null ? '' : json["url"],
    banda: json["banda"] == null ? '' : json["banda"],
    addqueue: json["addqueue"] == null ? false : json["addqueue"],
  );

   Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
    "url": url == null ? null : url,
    "banda": banda == null ? null : banda,
    "addqueue": addqueue
  };


  static List<MusicModel> fromJsonList(dynamic jsonResponse) {
      var result = <MusicModel>[];
      jsonResponse.forEach((item) {
        result.add(MusicModel.fromJson(item));
      });
      return result;
    }
}