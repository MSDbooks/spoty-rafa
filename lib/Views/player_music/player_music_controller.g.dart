// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_music_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlayerMusicController on _PlayerMusicControllerBase, Store {
  Computed<String> _$getTimeToMusicComputed;

  @override
  String get getTimeToMusic =>
      (_$getTimeToMusicComputed ??= Computed<String>(() => super.getTimeToMusic,
              name: '_PlayerMusicControllerBase.getTimeToMusic'))
          .value;
  Computed<String> _$getTotalTimeComputed;

  @override
  String get getTotalTime =>
      (_$getTotalTimeComputed ??= Computed<String>(() => super.getTotalTime,
              name: '_PlayerMusicControllerBase.getTotalTime'))
          .value;
  Computed<double> _$progressDurationComputed;

  @override
  double get progressDuration => (_$progressDurationComputed ??=
          Computed<double>(() => super.progressDuration,
              name: '_PlayerMusicControllerBase.progressDuration'))
      .value;
  Computed<bool> _$hasNextMusicComputed;

  @override
  bool get hasNextMusic =>
      (_$hasNextMusicComputed ??= Computed<bool>(() => super.hasNextMusic,
              name: '_PlayerMusicControllerBase.hasNextMusic'))
          .value;
  Computed<bool> _$hasPreviousMusicComputed;

  @override
  bool get hasPreviousMusic => (_$hasPreviousMusicComputed ??= Computed<bool>(
          () => super.hasPreviousMusic,
          name: '_PlayerMusicControllerBase.hasPreviousMusic'))
      .value;

  final _$musicasAtom = Atom(name: '_PlayerMusicControllerBase.musicas');

  @override
  List<MusicModel> get musicas {
    _$musicasAtom.reportRead();
    return super.musicas;
  }

  @override
  set musicas(List<MusicModel> value) {
    _$musicasAtom.reportWrite(value, super.musicas, () {
      super.musicas = value;
    });
  }

  final _$faixaAtom = Atom(name: '_PlayerMusicControllerBase.faixa');

  @override
  int get faixa {
    _$faixaAtom.reportRead();
    return super.faixa;
  }

  @override
  set faixa(int value) {
    _$faixaAtom.reportWrite(value, super.faixa, () {
      super.faixa = value;
    });
  }

  final _$audioDurationAtom =
      Atom(name: '_PlayerMusicControllerBase.audioDuration');

  @override
  Duration get audioDuration {
    _$audioDurationAtom.reportRead();
    return super.audioDuration;
  }

  @override
  set audioDuration(Duration value) {
    _$audioDurationAtom.reportWrite(value, super.audioDuration, () {
      super.audioDuration = value;
    });
  }

  final _$timeToMusicAtom =
      Atom(name: '_PlayerMusicControllerBase.timeToMusic');

  @override
  Duration get timeToMusic {
    _$timeToMusicAtom.reportRead();
    return super.timeToMusic;
  }

  @override
  set timeToMusic(Duration value) {
    _$timeToMusicAtom.reportWrite(value, super.timeToMusic, () {
      super.timeToMusic = value;
    });
  }

  final _$musicPlayingAtom =
      Atom(name: '_PlayerMusicControllerBase.musicPlaying');

  @override
  bool get musicPlaying {
    _$musicPlayingAtom.reportRead();
    return super.musicPlaying;
  }

  @override
  set musicPlaying(bool value) {
    _$musicPlayingAtom.reportWrite(value, super.musicPlaying, () {
      super.musicPlaying = value;
    });
  }

  final _$audioPlayerAtom =
      Atom(name: '_PlayerMusicControllerBase.audioPlayer');

  @override
  AudioPlayer get audioPlayer {
    _$audioPlayerAtom.reportRead();
    return super.audioPlayer;
  }

  @override
  set audioPlayer(AudioPlayer value) {
    _$audioPlayerAtom.reportWrite(value, super.audioPlayer, () {
      super.audioPlayer = value;
    });
  }

  final _$playMusicAsyncAction =
      AsyncAction('_PlayerMusicControllerBase.playMusic');

  @override
  Future<void> playMusic() {
    return _$playMusicAsyncAction.run(() => super.playMusic());
  }

  final _$_PlayerMusicControllerBaseActionController =
      ActionController(name: '_PlayerMusicControllerBase');

  @override
  void changeTimeTiMusic(Duration d) {
    final _$actionInfo = _$_PlayerMusicControllerBaseActionController
        .startAction(name: '_PlayerMusicControllerBase.changeTimeTiMusic');
    try {
      return super.changeTimeTiMusic(d);
    } finally {
      _$_PlayerMusicControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setimeMusic(double value) {
    final _$actionInfo = _$_PlayerMusicControllerBaseActionController
        .startAction(name: '_PlayerMusicControllerBase.setimeMusic');
    try {
      return super.setimeMusic(value);
    } finally {
      _$_PlayerMusicControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopMusic() {
    final _$actionInfo = _$_PlayerMusicControllerBaseActionController
        .startAction(name: '_PlayerMusicControllerBase.stopMusic');
    try {
      return super.stopMusic();
    } finally {
      _$_PlayerMusicControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextMusic() {
    final _$actionInfo = _$_PlayerMusicControllerBaseActionController
        .startAction(name: '_PlayerMusicControllerBase.nextMusic');
    try {
      return super.nextMusic();
    } finally {
      _$_PlayerMusicControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousMusic() {
    final _$actionInfo = _$_PlayerMusicControllerBaseActionController
        .startAction(name: '_PlayerMusicControllerBase.previousMusic');
    try {
      return super.previousMusic();
    } finally {
      _$_PlayerMusicControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
musicas: ${musicas},
faixa: ${faixa},
audioDuration: ${audioDuration},
timeToMusic: ${timeToMusic},
musicPlaying: ${musicPlaying},
audioPlayer: ${audioPlayer},
getTimeToMusic: ${getTimeToMusic},
getTotalTime: ${getTotalTime},
progressDuration: ${progressDuration},
hasNextMusic: ${hasNextMusic},
hasPreviousMusic: ${hasPreviousMusic}
    ''';
  }
}
