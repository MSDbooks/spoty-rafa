import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spotRafa/Modules/player_music/Models/genero_model.dart';
import 'package:spotRafa/Views/player_music/player_music_controller.dart';
import 'package:spotRafa/Views/shared/app_config.dart';

class ListMusicPage extends StatefulWidget {

  final GeneroModel genre;
  final PlayerMusicController controller;
  const ListMusicPage({Key key, @required this.genre, @required this.controller}) : super(key: key);
  @override
  _ListMusicPageState createState() => _ListMusicPageState();
}

class _ListMusicPageState extends State<ListMusicPage> {

  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('${widget.genre.nome}'),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: _ac.rWP(5)),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.genre.imageurl),
              ),
            ),
          ],
        ),
        body: Observer(
          builder: (_){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: widget.controller.musicas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${widget.controller.musicas[index].nome}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.green[300]
                    ),
                  ),
                  subtitle: Text(
                    '${widget.controller.musicas[index].banda}',
                  ),
                  onTap: (){
                    widget.controller.addOrRemoveQueue(index);
                  },
                  trailing: widget.controller.musicas[index].addqueue 
                  ? Icon(
                    Icons.assignment_turned_in,
                    color: Colors.green[100],
                  ) : null, 
                );
              },
            );
          })
      ),
    );
  }
}