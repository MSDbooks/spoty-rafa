import 'package:spotRafa/Modules/firebase/providers/firestore-instance-provider.dart';
import 'package:spotRafa/Modules/player_music/Models/music_model.dart';

import '../models/musical_genre_model.dart';

class FirestoreRepository{

  final FirestoreInstanceProvider _instance = FirestoreInstanceProvider();

  Future<List<MusicalGenreModel>> getGenerosMusica() async {
    
    var _list = <MusicalGenreModel>[];
    await _instance.firestore.collection('genero-musical')
      .get()
      .then((snapshots) {
        snapshots.docs.forEach((item) {
          if(item.exists){
            var data = MusicalGenreModel.fromJson(item.data());
            data.documentId = item.id;
            _list.add(data);
          }
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