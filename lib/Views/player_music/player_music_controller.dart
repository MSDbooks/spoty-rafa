
import 'package:audioplayer/audioplayer.dart';
import 'package:mobx/mobx.dart';
import 'package:spotRafa/Modules/player_music/Models/music_model.dart';

part 'player_music_controller.g.dart';

class PlayerMusicController = _PlayerMusicControllerBase with _$PlayerMusicController;

abstract class _PlayerMusicControllerBase with Store {
  
  @observable
  List<MusicModel> musicas = List<MusicModel>();
  _PlayerMusicControllerBase(){
    var music1 = MusicModel();
    var music2 = MusicModel();
    music1.url = 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/Axe%2FAXE%20BAHIA%20ONDA%20ONDA(ORIGINAL)%20(%20160kbps%20).mp3?alt=media&token=ed584e27-8d57-4125-becb-19b7bf2c49db';
    music1.nome = 'Olha a Onda';
    musicas.add(music1);
    music2.url = 'https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/Rock-nacional%2FAnna%20Julia%20Letra%20(%20160kbps%20).mp3?alt=media&token=745d4486-e06d-411c-a405-f4ea6998aa9b';
    music2.nome = 'Ana Julia';
    musicas.add(music2);
  }

  

  @observable
  int faixa = 0;

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
  void changeTimeTiMusic(Duration d){
    timeToMusic = d;
  }

  @action
  void setimeMusic(double value){
    audioPlayer.seek(value * audioDuration.inMilliseconds);
  }

  @action
  void stopMusic(){
    audioPlayer.stop();
    musicPlaying = false;
    timeToMusic = Duration.zero;
  }

  @action
  void nextMusic(){
    faixa++;
    stopMusic();
    audioDuration = Duration.zero;
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
      Future.delayed(Duration(milliseconds: 200), () => audioDuration = audioPlayer.duration); 
    }else{
      musicPlaying = false;
      await audioPlayer.pause();
    }
  }

}