// Screen to display contents of amount of water consumed.

import 'package:flutter/material.dart';
import '../widgets/number_tile.dart';
import '../widgets/constants.dart';

class HydrationScreen extends StatefulWidget {
  @override
  _HydrationScreenState createState() => _HydrationScreenState();

  final isSwitched;

  HydrationScreen(this.isSwitched);
}

class _HydrationScreenState extends State<HydrationScreen> {
  var cupCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSwatchBlueColor,
      appBar: AppBar(
        backgroundColor: kSwatchBlueColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'cups',
              child: Icon(
                Icons.opacity,
                size: 80.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.isSwitched ? 'ജലാംശം' : 'Hydration',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
            Text(
              '$cupCount of 12',
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
                          child: NumberTile(
                            content: '4',
                            textColor: kTileDefaultTextColor,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cupCount += 1;
                              });
                            },
                            child: NumberTile(
                              content: '+',
                              textColor: kSwatchBlueColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: NumberTile(
                            content: '',
                            textColor: kTileDefaultTextColor,
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
