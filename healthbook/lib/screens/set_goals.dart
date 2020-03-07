import 'package:flutter/material.dart';

class SetGoals extends StatefulWidget {
  @override
  _SetGoalsState createState() => _SetGoalsState();
}

class _SetGoalsState extends State<SetGoals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            'SET YOUR GOALS FOR TODAY!',
            style: TextStyle(
              fontSize: 40,
            ),
            
          ),
        ],
      ),
    );
  }
}
