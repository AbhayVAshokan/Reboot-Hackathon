// Customization of each tile/card inside the home_screen

import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final double height;

  Tile(
      {this.backgroundColor,
      this.borderColor,
      this.textColor,
      this.icon,
      this.title = "",
      this.subtitle = "",
      this.height = 175.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
            color: this.borderColor, style: BorderStyle.solid, width: 2.0),
        borderRadius: BorderRadius.circular(30.0),
        color: this.backgroundColor,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Opacity(
                opacity: this.icon != null ? 1.0 : 0.0,
                child: Hero(
                  tag: this.subtitle,
                  child: Icon(
                    this.icon,
                    color: this.textColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FittedBox(
                child: Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w400,
                    color: this.textColor,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  this.subtitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: this.textColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
