// Screen to display the home screen containing all the information.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/tile.dart';
import '../widgets/constants.dart';
import './sleep_screen.dart';
import './hydration_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  final usernameController;
  HomeScreen({@required this.usernameController});
}

enum TtsState { playing, stopped }

class _HomeScreenState extends State<HomeScreen> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue;
  static final lang = ["en_US", "ml-IN"];
  bool isSwitched = false;
  String engText =
      "We have analysed your health status. You are reaching your hydration goals. The number of steps travelled is 121 and the corresponding calories burnt is 5. You have a very good posture accuracy. You'r bmi  is almost close to normal value. Please make your brightness to lowered to 75%. Your blink rate is too low. This is too much stess to your eyes.";
  String malText =
      "നിങ്ങളുടെ ആരോഗ്യ നില ഞങ്ങൾ വിശകലനം ചെയ്തു. നിങ്ങളുടെ ജലാംശം ലക്ഷ്യത്തിലെത്തുകയാണ്. യാത്ര ചെയ്ത പടികളുടെ എണ്ണം 121 ഉം അനുബന്ധ കലോറികൾ 5 ഉം ആണ്. നിങ്ങൾക്ക് വളരെ നല്ല പോസ്ചർ കൃത്യതയുണ്ട്. നിങ്ങൾ bmi സാധാരണ മൂല്യത്തോട് ഏകദേശം അടുത്താണ്. നിങ്ങളുടെ തെളിച്ചം 75% ആയി കുറയ്‌ക്കുക. നിങ്ങളുടെ ബ്ലിങ്ക് നിരക്ക് വളരെ കുറവാണ്. ഇത് നിങ്ങളുടെ കണ്ണുകൾക്ക് വളരെയധികം സ്റ്റെസ്സാണ്.്";

  // Calculate calories burnt from the pedometer steps
  int caloriesBurnt() {
    if (_stepCountValue == null)
      return null;
    else {
      return (int.parse(_stepCountValue) * 0.57 * 2.20462 * 55).toInt();
    }
  }

  // Pedometer functions
  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void startListening() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  void stopListening() {
    _subscription.cancel();
  }

  void _onData(int stepCountValue) async {
    setState(() => _stepCountValue = "$stepCountValue");
    print(_stepCountValue);
  }

  @override
  void initState() {
    super.initState();
    initTts();
    startListening();
  }

  initTts() {
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        print(engText);
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

  FlutterTts flutterTts;
  dynamic languages;
  String language = lang[0];
  double volume = 0.5;
  double pitch = 1.0;
  double engRate = 0.5;
  double malRate = 0.45;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  Future _speak(text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(isSwitched ? malRate : engRate);
    await flutterTts.setPitch(pitch);

    if (text != null) {
      if (text.isNotEmpty) {
        var result = await flutterTts.speak(text);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  var hydration, sleep, bmi, steps, cal, posture, brightness, blink, bpm;
  var userName;
  final DatabaseReference database = FirebaseDatabase.instance.reference();
  void getHomeScreenValues() {
    userName = widget.usernameController.text.split('@')[0];
    print("Hello World!");
    print("Hello World!");
    print("Hello World!");
    print("Hello World!");
    print(userName);
    database.once().then((DataSnapshot snapshot) {
      print(snapshot.value[userName]);
      setState(() {
        hydration = snapshot.value[userName].child('cups_of_water');
        sleep = snapshot.value[userName].child('sleep');
        bmi = snapshot.value[userName].child('bmi');
        steps = snapshot.value[userName].child('pedomenter');
        cal = snapshot.value[userName].child('cal');
        posture = snapshot.value[userName].child('posture');
        brightness = snapshot.value[userName].child('brightness');
        blink = snapshot.value[userName].child('avgblinkrate');
        bpm = snapshot.value[userName].child('bpm');
        // print(snapshot);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("HEALTHBOOK"),
        ),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          Icon(Icons.sort_by_alpha),
          Switch(
              activeColor: Colors.white,
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        isSwitched ? 'ഇന്നത്തേക്ക്' : 'For today',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMMd('en_US').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HydrationScreen(
                                                      isSwitched,
                                                      hydration == null
                                                          ? 0
                                                          : int.parse(
                                                              hydration))));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20.0),
                                      height: 77.5,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kSwatchBlueColor,
                                            style: BorderStyle.solid,
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: kSwatchBlueColor,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Opacity(
                                                opacity: Icons.opacity != null
                                                    ? 1.0
                                                    : 0.0,
                                                child: Icon(
                                                  Icons.opacity,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SleepScreen(isSwitched)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    height: 77.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromRGBO(38, 0, 29, 1),
                                          style: BorderStyle.solid,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Color.fromRGBO(38, 0, 29, 1),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Opacity(
                                              opacity:
                                                  Icons.surround_sound != null
                                                      ? 1.0
                                                      : 0.0,
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Tile(
                              backgroundColor: Colors.teal,
                              borderColor: Colors.teal,
                              textColor: Colors.white,
                              title: '22.5',
                              subtitle: isSwitched ? 'ബിഎംഐ' : 'BMI',
                              icon: Icons.access_time,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Tile(
                              backgroundColor: Colors.indigo,
                              borderColor: Colors.indigo,
                              textColor: Colors.white,
                              title: '121',
                              subtitle: isSwitched ? 'ചുവടുകൾ' : 'steps',
                              icon: Icons.directions_walk,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Tile(
                              backgroundColor: Colors.pinkAccent,
                              borderColor: Colors.pinkAccent,
                              textColor: Colors.white,
                              title: '85.35',
                              subtitle: '%',
                              icon: Icons.airline_seat_legroom_normal,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Tile(
                              backgroundColor: Colors.lightGreen,
                              borderColor: Colors.lightGreen,
                              textColor: Colors.white,
                              title: '5' /*caloriesBurnt().toString()*/,
                              subtitle: isSwitched ? 'കലോറി' : 'cal',
                              icon: Icons.fastfood,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Tile(
                              backgroundColor: Colors.amber,
                              borderColor: Colors.amber,
                              textColor: Colors.white,
                              title: '75',
                              subtitle: isSwitched ? 'ശതമാനം' : 'percent',
                              icon: Icons.wb_sunny,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Tile(
                              backgroundColor: Colors.indigoAccent,
                              borderColor: Colors.indigoAccent,
                              textColor: Colors.white,
                              title: '12',
                              subtitle:
                                  isSwitched ? 'കണ്ണ് ചിമ്മുന്നു' : 'blinks pm',
                              icon: Icons.wb_sunny,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 3,
                            child: Tile(
                              backgroundColor: kSwatchPinkColor,
                              borderColor: kSwatchPinkColor,
                              textColor: Colors.white,
                              icon: Icons.favorite,
                              title: '118',
                              subtitle: 'bpm',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 65,
        width: 65,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.play_arrow),
            backgroundColor: Colors.amber,
            onPressed: () {
              getHomeScreenValues();
              _speak(isSwitched ? malText : engText);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
