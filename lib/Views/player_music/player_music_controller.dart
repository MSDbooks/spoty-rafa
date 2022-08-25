
import 'dart:math';

import 'package:audioplayer/audioplayer.dart';
import 'package:mobx/mobx.dart';
import 'package:spotRafa/Modules/firebase/repositories/firebase-auth-repository.dart';
import 'package:spotRafa/Modules/firebase/repositories/firestore-repository.dart';
import 'package:spotRafa/Modules/player_music/Models/genero_model.dart';
import 'package:spotRafa/Modules/player_music/Models/music_model.dart';

part 'player_music_controller.g.dart';

class PlayerMusicController = _PlayerMusicControllerBase with _$PlayerMusicController;

abstract class _PlayerMusicControllerBase with Store {

  var _musicsAddQueue = <int>[];
  var _authenticated = false;
  var musicasTocadasShuffle = <int>[];
  var _firestore = FirestoreRepository();
  var _firebaseAuth = FirebaseAuthRepository();

  _PlayerMusicControllerBase() {
    if(!_authenticated){
      _firebaseAuth.signInSnonymousAsync().then((value) => _authenticated = value); 
    }
  }

   @action
  Future<bool> addOrRemoveQueue(int index){
    musicas[index].addqueue = !musicas[index].addqueue;
    if(musicas[index].addqueue){
      _musicsAddQueue.add(index);
    }else{
      _musicsAddQueue.removeWhere((musicIndex) =>  musicIndex == index);
    }
    var _mapMusicsEncode = List<dynamic>.from(musicas.map((x) => x.toJson()));
    musicas = MusicModel.fromJsonList(_mapMusicsEncode);
    return Future.value(musicas[index].addqueue);
  }

  @observable
  bool shuffle = false;
  @action
  void activeShuffle({bool active}){
    shuffle = active;
    
    if(!shuffle){
      musicasTocadasShuffle = <int>[];
    }
  }

  @observable
  bool changingMusic = false;
  
  @observable
  List<MusicModel> musicas = <MusicModel>[];

  @observable
  List<GeneroModel> generos = <GeneroModel>[];

  @observable
  int faixa = 0;
  @observable
  int faixaFila = -1;

  @observable
  Duration audioDuration = Duration();

  @observable
  Duration timeToMusic = Duration();

  @computed
  String get getTimeToMusic => timeToMusic != null ? '${timeToMusic.inMinutes.remainder(60)}:${timeToMusic.inSeconds.remainder(60)}' : '-';

  @computed
  String get getTotalTime => audioDuration != null ? '${audioDuration.inMinutes.remainder(60)}:${audioDuration.inSeconds.remainder(60)}' : '-';

  @computed
  double get progressDuration => audioDuration != null 
                                    ? (audioDuration.inSeconds > 0 ? timeToMusic.inSeconds.toDouble() * 1 / audioDuration.inSeconds: 0) 
                                    : 0; 

  @computed
  bool get hasNextMusic => musicas != null ? musicas.length > faixa : false;
  @computed
  bool get hasPreviousMusic => musicas != null ? faixa > 0 : false;                                   
  @observable
  bool musicPlaying = false;

  @observable
  AudioPlayer audioPlayer = AudioPlayer();

  @action
  void changeTimeTiMusic(Duration d) {
    
    timeToMusic = d;
    audioDuration = audioPlayer.duration;
    
    var _totalTime = int.parse((audioDuration.inMilliseconds * 0.95).toString().split('.')[0]);
    if(!changingMusic && timeToMusic.inMilliseconds > _totalTime){
      changingMusic = true;
      Future.delayed(Duration(milliseconds: 5000)).then((value) {
        if(changingMusic){
          nextMusic();
        }
      });
      
    }
  }

  @action
  void setimeMusic(double value){
    audioPlayer.seek(value * audioDuration.inSeconds);
  }



  @action
  void stopMusic(){
    audioPlayer.stop();
    musicPlaying = false;
    timeToMusic = Duration.zero;
  }

  @action
  void nextMusic(){

    stopMusic();
    audioDuration = Duration.zero;

    if(_musicsAddQueue.length > 0){
      
      if(faixaFila == -1){
         faixaFila = faixa;
      }

      faixa = _musicsAddQueue.first;
      musicas[_musicsAddQueue.first].addqueue = false;
      _musicsAddQueue.removeWhere((musicIndex) =>  musicIndex == _musicsAddQueue.first);
      
      playMusic();
      changingMusic = false;

    }else{
       if(faixaFila != -1){
         faixa = faixaFila;
         faixaFila = -1;
       }
       if(faixa < musicas.length -1){
        var _fimPlaylist = false;
        if(shuffle){
          var _sair = true;
          var rng = new Random(musicas.length);
          while(_sair){
            var _idFaixa = rng.nextInt(musicas.length);
            var _musicaJaTocada = musicasTocadasShuffle.firstWhere((a) => a == _idFaixa, orElse: () => null);
            if(_musicaJaTocada == null){
              faixa = _idFaixa;
              _sair = false;
              musicasTocadasShuffle.add(_idFaixa);
            }else{
              if(musicasTocadasShuffle.length == musicas.length){
                _sair = false;
                _fimPlaylist = true;
                musicasTocadasShuffle = <int>[];
              }
            }
          }
        }else{
          faixa++;
        }
        
        if(!_fimPlaylist){
          playMusic();
        }
        changingMusic = false;

      }
    }
  }

  @action
  void previousMusic(){

    faixa--;
    stopMusic();
    audioDuration = Duration.zero;
  }

  @action
  Future<void> playMusic() async {
    if(!musicPlaying){
      musicPlaying = true;
      await audioPlayer.play(musicas[faixa].url);
    }else{
      musicPlaying = false;
      await audioPlayer.pause();
    }
  }
  
   @action
  Future<void> getAllGeneros() async{
    
    var _generos = await _firestore.getGenerosMusica();
    
    var _listGeneros = <GeneroModel>[];
    _generos.forEach((genero) {
        
      var _nomeGenero = genero == 'axe'
                                  ? 'Axé'
                                  : genero == 'flash-back'
                                  ? 'Flash back'
                                  : genero == 'funk'
                                  ? 'Funk' 
                                  : genero == 'rock-nacional' 
                                  ? 'Rock Nacional' 
                                  : genero == 'popero'
                                  ? 'Popero' 
                                  : 'diversos';
       
       var _urlGenero = genero == 'axe'
                                  ? 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/img%2Faxe.png?alt=media&token=8110c569-2249-4442-aefa-278ff7b7c08b'
                                  : genero == 'flash-back'
                                  ? 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/img%2Fflashback.jpg?alt=media&token=39fc7827-b25d-4cee-8a14-2a5333d35653'
                                  : genero == 'funk'
                                  ? 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/img%2Ffunk2000.jpg?alt=media&token=e2e99ac1-f81c-4434-8f77-1331548d0d96' 
                                  : genero == 'rock-nacional' 
                                  ? 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/img%2Frocknacional.jpg?alt=media&token=f44756a2-e61e-4e13-903f-2e4e20b50eab' 
                                  : genero == 'popero' 
                                  ? 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/img%2Fpopero.jpg?alt=media&token=266646b3-0c93-4b67-b7f8-88f6ac01ae15' 
                                  : 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/img%2Fmusicas.png?alt=media&token=4cc1788f-34ff-4e14-8ab8-ab9b40fc4d39';
      _listGeneros.add(GeneroModel(
        nome: _nomeGenero,
        imageurl: _urlGenero
      ));
     });
     generos = _listGeneros;

  }

  @action
  Future<void> getMusicas(String genero) async{

    var _document = genero == 'Axé'
                                  ? 'axe'
                                  : genero == 'Flash back'
                                  ? 'flash-back'
                                  : genero == 'Funk'
                                  ? 'funk' 
                                  : genero == 'Rock Nacional' 
                                  ? 'rock-nacional' 
                                  : genero == 'Popero' 
                                  ? 'popero' : 'diversos';

    var _musicas = await _firestore.getMusicas(_document); 
    musicas = _musicas;                         

  }

}