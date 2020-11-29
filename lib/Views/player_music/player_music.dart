import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:seekbar/seekbar.dart';
import 'package:spotRafa/Views/player_music/player_music_controller.dart';

class PlayerMusic extends StatefulWidget {
  @override
  _PlayerMusicState createState() => _PlayerMusicState();
}

class _PlayerMusicState extends State<PlayerMusic> {


  PlayerMusicController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PlayerMusicController();
    _controller.audioPlayer.onAudioPositionChanged.listen((d) => _controller.changeTimeTiMusic(d));
  }

  @override
  void dispose() {
    _controller.stopMusic();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Spoty Rafa ;)'),
      ),
      body: Column(
        children: [
          _buildImageheader(),
          _buildNameMusic(),
          _buildProgressBar(),
          _buildButtons()
        ],
      ),
    ); 
  }
  
  Widget _buildImageheader(){
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/spoty-rafa.appspot.com/o/img%2Fdownload%20(1).png?alt=media&token=5425fc07-b71c-4570-8a77-564de7192c9b'),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[700],
              blurRadius: 15,
              offset: Offset(2,5)
            )
          ]
        ),
      ),
    );
  }

  Widget _buildNameMusic(){
    return Observer(
      builder: (_){
        return  Column(
          children: [
            Container(
              child: Text(
                _controller.musicas[_controller.faixa].nome,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              child: Text(
                'Artista',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ); 
      },
    ); 
  }

  Widget _buildProgressBar(){
    return Observer(
      builder: (_){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 30),
              child: SeekBar(
                value: _controller.progressDuration,
                onStartTrackingTouch:(){},
                onProgressChanged: (value){
                  _controller.setimeMusic(value);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Row(
                children: [
                  Text(_controller.getTimeToMusic),
                  Expanded(child: Container()),
                  Text(_controller.getTotalTime)
                ],
              ),
            )
          ],
        );
      }); 
  }

  Widget _buildButtons(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          FlatButton(
            child: Icon(Icons.skip_previous, size: 70),
            onPressed: () => _controller.previousMusic(),
          ),
          Expanded(
            child: Observer(
                builder: (_){
                  return FlatButton(
                    child: Icon(
                    _controller.musicPlaying 
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline, 
                    size: 70
                  ),
                  onPressed: (){
                  _controller.playMusic();
              },
                );
              },
            ),
          ),
          FlatButton(
            child: Icon(
              Icons.skip_next, 
              size: 70
            ),
            onPressed: () => _controller.nextMusic(),
          ),
        ],
      ),
    );
  }


}