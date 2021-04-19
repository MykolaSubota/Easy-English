import 'package:audioplayers/audio_cache.dart';
import 'package:engapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:engapp/screens/navDrawer.dart';
import 'package:audioplayers/audioplayers.dart';

final AuthService _auth = AuthService();

class C2 extends StatefulWidget {
  @override
  _C2State createState() => _C2State();
}

List audioData = [
  'audio/elementary-podcasts-s02-e01.mp3',
  'audio/elementary-podcasts-s02-e02.mp3'
];

class _C2State extends State<C2> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;
  String nameAudio = audioData[0];

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration audioLength = new Duration();

  Widget slider() {
    return Slider(
        value: position.inSeconds.toDouble(),
        activeColor: Colors.deepPurple[300],
        inactiveColor: Colors.grey,
        max: audioLength.inSeconds.toDouble(),
        onChanged: (value) {
          sekToSek(value.toInt());
        });
  }

  void sekToSek(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        audioLength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Easy English'),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              child: Text(
                "Audio1",
                style: TextStyle(color: Colors.deepPurple[200], fontSize: 18.0),
              ),
              onPressed: () {
                nameAudio = audioData[0];
                cache.play(nameAudio);
              },
            ),
            TextButton(
              child: Text(
                "Audio2",
                style: TextStyle(color: Colors.deepPurple[200], fontSize: 18.0),
              ),
              onPressed: () {
                nameAudio = audioData[1];
                cache.play(nameAudio);
              },
            ),
            Row(
              children: [
                Text(
                    "${position.inMinutes}:${position.inSeconds.remainder(60)}"),
                slider(),
                Text(
                    '${audioLength.inMinutes}:${audioLength.inSeconds.remainder(60)}')
              ],
            ),
            IconButton(
              icon: Icon(playBtn),
              onPressed: () {
                if (!playing) {
                  cache.play(nameAudio);
                  setState(() {
                    playBtn = Icons.pause;
                    playing = true;
                  });
                } else {
                  _player.pause();
                  setState(() {
                    playBtn = Icons.play_arrow;
                    playing = false;
                  });
                }
              },
              iconSize: 62,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
