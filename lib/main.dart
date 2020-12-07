import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Phrases',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(title: 'Basic Phrases'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioCache _audioCache;

  final List<List<String>> _titleAudioMapping = <List<String>>[
    <String>['salut', 'salut.mp3'],
    <String>['salut (Japoneză)', 'salut_ja.mp3'],
    <String>['mă numesc', 'ma_numesc.mp3'],
    <String>['mă numesc (Japoneză)', 'ma_numesc_ja.mp3'],
    <String>['cum ești?', 'cum_esti.mp3'],
    <String>['cum ești? (Japoneză)', 'cum_esti_ja.mp3'],
    <String>['sunt bine', 'sunt_bine.mp3'],
    <String>['sunt bine (Japoneză)', 'sunt_bine_ja.mp3'],
  ];

  @override
  void initState() {
    super.initState();
    // create this only once
    _audioCache =
        AudioCache(prefix: 'assets/basicPhrases/', fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Card(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(_titleAudioMapping[index][0],
                        style: const TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold))),
                elevation: 8.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
            onTap: () {
              _audioCache.play(_titleAudioMapping[index][1]);
            },
          );
        },
      ),
    );
  }
}
