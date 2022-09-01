import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spotRafa/Views/player_music/player_music.dart';
import 'package:spotRafa/Views/player_music/player_music_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _controller = PlayerMusicController();
  
  @override
  void initState() {
    super.initState();
    _controller.getAllGenres();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Spot Rafa ;)',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Observer(
        builder: (_){
          return   ListView.builder(
            itemCount: _controller.genres.length,
            itemBuilder: (_, index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_controller.genres[index].frontCover!),
                ),
                title: Text(_controller.genres[index].name!),
                subtitle: Text('Detalhe musica'),
                contentPadding: EdgeInsets.all(10),
                onTap: (){
                  Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => PlayerMusic(genre: _controller.genres[index])
                      )
                  );
                },
              );
            }
          );
        }
      ),
    );
  }
}