
import 'dart:math';
import 'package:audioplayer/audioplayer.dart';
import 'package:mobx/mobx.dart';
import 'package:spotRafa/Modules/firebase/repositories/firebase-auth-repository.dart';
import 'package:spotRafa/Modules/firebase/repositories/firestore-repository.dart';
import 'package:spotRafa/Modules/player_music/Models/music_model.dart';

//import '../../Modules/components/audio_player/audio_player.dart';
import '../../Modules/firebase/models/musical_genre_model.dart';

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
    musicas[index].addqueue = !musicas[index].addqueue!;
    if(musicas[index].addqueue!){
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
  void activeShuffle({bool active = false}){
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
  List<MusicalGenreModel> genres = <MusicalGenreModel>[];

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
            var _musicaJaTocada = musicasTocadasShuffle.firstWhere((a) => a == _idFaixa, orElse: () => -1);
            if(_musicaJaTocada == -1){
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
      await audioPlayer.play(musicas[faixa].url!);
    }else{
      musicPlaying = false;
      await audioPlayer.pause();
    }
  }
  
   @action
  Future<void> getAllGenres() async{
    var response = await _firestore.getGenerosMusica();
     genres = response;
  }

  @action
  Future<void> getMusics(MusicalGenreModel genre) async{
    var _musicas = await _firestore.getMusicas(genre.documentId!); 
    musicas = _musicas;                         
  }
}