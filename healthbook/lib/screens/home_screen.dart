import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/tile.dart';
import '../widgets/constants.dart';
import 'hydration_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showBottomNavigation(context) {
    showModalBottomSheet(
        backgroundColor: Colors.black87,
        context: context,
        builder: (_) {
          return Container(
            height: 500,
            child: Center(
              child: Text('Hello World'),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'For today',
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
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HydrationScreen()));
                        },
                        child: Tile(
                          backgroundColor: kSwatchBlueColor,
                          borderColor: kSwatchBlueColor,
                          textColor: Colors.white,
                          icon: Icons.opacity,
                          title: '4',
                          subtitle: 'cups',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
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
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Tile(
                        backgroundColor: Colors.indigo,
                        borderColor: Colors.indigo,
                        textColor: Colors.white,
                        title: '12001',
                        subtitle: 'steps',
                        icon: Icons.directions_walk,  
                      ),
                    ),
                    SizedBox(width: 20.0),

                    Expanded(
                      flex: 1,
                      child: Tile(
                        backgroundColor: Colors.amber,
                        borderColor: Colors.amber,
                        textColor: Colors.white,
                        title: '100',
                        subtitle: 'percent',
                        icon: Icons.wb_sunny,  
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Tile(
                        backgroundColor: Colors.lightGreen,
                        borderColor: Colors.lightGreen,
                        textColor: Colors.white,
                        title: '2878',
                        subtitle: 'kcal',
                        icon: Icons.fastfood,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
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
                )
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
            child: Icon(Icons.trending_up),
            backgroundColor: Colors.amber,
            onPressed: () {
              _showBottomNavigation(context);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
