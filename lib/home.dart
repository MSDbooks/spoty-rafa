import 'package:flutter/material.dart';
import 'package:spotRafa/Views/player_music/player_music.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Play List',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index){
          return ListTile(
            leading: CircleAvatar(),
            title: Text('Nome Musica'),
            subtitle: Text('Detalhe musica'),
            contentPadding: EdgeInsets.all(10),
            onTap: (){
               Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => PlayerMusic()
                  )
              );
            },
          );
        }
      )
    );
  }
}