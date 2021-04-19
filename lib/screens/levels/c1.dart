import 'package:audioplayers/audio_cache.dart';
import 'package:engapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:engapp/screens/navDrawer.dart';
import 'package:audioplayers/audioplayers.dart';

final AuthService _auth = AuthService();

class C1 extends StatefulWidget {
  @override
  _C1State createState() => _C1State();
}

List audioData = [
  'audio/elementary-podcasts-s01-e09.mp3',
  'audio/elementary-podcasts-s01-e10.mp3'
];

class _C1State extends State<C1> {
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
        activeColor: Colors.blue,
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
        title: Text('Daily English'),
        backgroundColor: Colors.lightBlue[900],
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
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
              ),
              onPressed: () {
                nameAudio = audioData[0];
                cache.play(nameAudio);
                playing = true;
              },
            ),
            TextButton(
              child: Text(
                "Audio2",
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
              ),
              onPressed: () {
                nameAudio = audioData[1];
                cache.play(nameAudio);
                playing = true;
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
