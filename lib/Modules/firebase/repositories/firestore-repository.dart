import 'package:spotRafa/Modules/firebase/providers/firestore-instance-provider.dart';
import 'package:spotRafa/Modules/player_music/Models/music_model.dart';

class FirestoreRepository{

  final FirestoreInstanceProvider _instance = FirestoreInstanceProvider();

  Future<List<String>> getGenerosMusica() async {
    var _list = <String>[];
    await _instance.firestore.collection('genero-musical')
      .get()
      .then((snapshots) {
        snapshots.docs.forEach((item) {
          var _nome = item.id;
          _list.add(_nome);
        });
      });
      return _list;
  }

    Future<List<MusicModel>> getMusicas(String document) async {
    var _list = <MusicModel>[];
    await _instance.firestore.collection('genero-musical/$document/musicas')
      .get()
      .then((snapshots) {
        snapshots.docs.forEach((item) {
          var _itemModel = MusicModel.fromJson(item.data());
          _list.add(_itemModel);
        });
      });
      return _list;
  }
}