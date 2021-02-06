import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:seekbar/seekbar.dart';
import 'package:spotRafa/Modules/player_music/Models/genero_model.dart';
import 'package:spotRafa/Views/list_music/list_music_page.dart';
import 'package:spotRafa/Views/player_music/player_music_controller.dart';

class PlayerMusic extends StatefulWidget {

  final GeneroModel genero;

  const PlayerMusic({Key key, @required this.genero}) : super(key: key);

  @override
  _PlayerMusicState createState() => _PlayerMusicState();
}

class _PlayerMusicState extends State<PlayerMusic> {

  double _appWidth;
  double _appHeight;
  PlayerMusicController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PlayerMusicController();
    _controller.getMusicas(widget.genero.nome);
    _controller.audioPlayer.onAudioPositionChanged.listen((d){
      _controller.changeTimeTiMusic(d);
    });
  }

  @override
  void dispose() {
    _controller.stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Spoty",
                    style: TextStyle(
                      color: Colors.green[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  TextSpan(
                    text: "Rafa ;)",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ], 
              ),
            ),
        actions: [
           IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              
            },
          ),
        ],
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
      margin: EdgeInsets.only(left: _appWidth / 50, right: _appWidth / 50, top: _appHeight / 90),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.genero.imageurl),
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
                _controller.musicas.length == 0  ? '-' : _controller.musicas[_controller.faixa].nome,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              child: Text(
                _controller.musicas.length == 0  ? '-' : _controller.musicas[_controller.faixa].banda,
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
              padding: EdgeInsets.only(left: _appWidth / 15, right: _appWidth / 15, top: _appHeight / 30),
              child: SeekBar(
                value: _controller.progressDuration,
                onStartTrackingTouch:(){},
                onProgressChanged: (value){
                  _controller.setimeMusic(value);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: _appWidth / 15, right: _appWidth/ 15),
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
    return Padding(
      padding: EdgeInsets.only(top: _appHeight / 60, right: _appWidth / 20, left: _appWidth / 30),
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: IconButton(
                icon: Observer(
                  builder: (_){
                    return Icon(
                      Icons.shuffle,
                      color: _controller.shuffle ? Colors.green : Colors.grey
                    );
                  },
                ),  
                onPressed: () => _controller.activeShuffle(active: !_controller.shuffle),
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: FlatButton(
                        child: Icon(Icons.skip_previous, size: 40),
                        onPressed: () {
                          if(_controller.hasPreviousMusic){
                            _controller.previousMusic();
                          }
                        },
                      ),
                    ),
                    Observer(
                        builder: (_){
                          return FlatButton(
                            child: Icon(
                            _controller.musicPlaying 
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline, 
                            size: 60
                          ),
                          onPressed: (){
                          _controller.playMusic();
                      },
                        );
                      },
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.skip_next, 
                        size: 40
                      ),
                      onPressed: () {
                        if(_controller.hasNextMusic){
                          _controller.nextMusic();
                        } 
                      },
                    ),    
                  ],
                ),
            ),
          
            Expanded(
              flex: 2,
                child: IconButton(
                icon: Icon(Icons.list), 
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListMusicPage(genre: widget.genero, controller: _controller)
                    )
                  );
                }
              ),
            ),  
          ],
        ),
      ),
    );
  }
}