// TextForms inside signup screen.

import 'package:flutter/material.dart';
import '../widgets/responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final String errorText;

  CustomTextField({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.obscureText = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    double _width;
    double _pixelRatio;
    bool large;
    bool medium;

    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        obscureText: obscureText,
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.deepPurple,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple, size: 20),
          hintText: hint,
          errorText: errorText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
