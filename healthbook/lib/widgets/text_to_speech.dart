import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech extends StatefulWidget {
  @override
  _TextToSpeechState createState() => _TextToSpeechState();

  final String text, language;
  TextToSpeech({@required this.language, @required this.text});
}

enum TtsState { playing, stopped }

class _TextToSpeechState extends State<TextToSpeech> {
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (widget.text != null) {
      if (widget.text.isNotEmpty) {
        var result = await flutterTts.speak(widget.text);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter TTS'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              RaisedButton(
                child: Text("Play"),
                onPressed: () {_speak();},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
