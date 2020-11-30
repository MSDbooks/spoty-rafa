import 'package:spotRafa/Modules/firebase/providers/firestore-instance-provider.dart';
import 'package:spotRafa/Modules/player_music/Models/music_model.dart';

class FirestoreRepository{

  final FirestoreInstanceProvider _instance = FirestoreInstanceProvider();

  Future<List<String>> getGenerosMusica() async {
    var _list = List<String>();
    await _instance.firestore.collection('genero-musical')
      .getDocuments()
      .then((onValue) {
        onValue.documents.forEach((item) {
          var _nome = item.documentID;
          _list.add(_nome);
        });
      });
      return _list;
  }

    Future<List<MusicModel>> getMusicas(String document) async {
    var _list = List<MusicModel>();
    await _instance.firestore.collection('genero-musical/$document/musicas')
      .getDocuments()
      .then((onValue) {
        onValue.documents.forEach((item) {
          var _itemModel = MusicModel.fromJson(item.data);
          _list.add(_itemModel);
        });
      });
      return _list;
  }
}