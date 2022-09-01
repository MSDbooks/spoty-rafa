class MusicalGenreModel{

  String? frontCover;
  String? name;
  bool? active;
  String? documentId;


  MusicalGenreModel({
    this.frontCover,
    this.name,
    this.active,
    this.documentId
  });

  factory MusicalGenreModel.fromJson(Map<String, dynamic> json) => MusicalGenreModel(
        frontCover: json["front_cover"],
        name: json["name"],
        active: json["active"],   
        documentId: json["document_id"],        
      );

  Map<String, dynamic> toJson() => {
        "front_cover": frontCover,
        "name": name,
        "active": active,
        "document_id": documentId,
      };

}