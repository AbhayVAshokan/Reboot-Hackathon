// Screen to display contents of amount of water consumed.

import 'package:flutter/material.dart';
import '../widgets/number_tile.dart';
import '../widgets/constants.dart';

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();

  final isSwitched;

  SleepScreen(this.isSwitched);
}

class _SleepScreenState extends State<SleepScreen> {
  var cupCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 0, 29, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 0, 29, 1),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'hours',
              child: Icon(
                Icons.star,
                size: 80.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.isSwitched ? 'ഉറക്കം (പ്രതിവാരം)' : 'Sleep (weekly)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
            Text(
              '$cupCount of 45',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 1;
                              });
                            },
                            child: NumberTile(
                              content: '1',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 2;
                              });
                            },
                            child: NumberTile(
                              content: '2',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 3;
                              });
                            },
                            child: NumberTile(
                              content: '3',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 4;
                              });
                            },
                            child: NumberTile(
                              content: '4',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 5;
                              });
                            },
                            child: NumberTile(
                              content: '5',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 6;
                              });
                            },
                            child: NumberTile(
                              content: '6',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 7;
                              });
                            },
                            child: NumberTile(
                              content: '7',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 8;
                              });
                            },
                            child: NumberTile(
                              content: '8',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 9;
                              });
                            },
                            child: NumberTile(
                              content: '9',
                              textColor: kTileDefaultTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
