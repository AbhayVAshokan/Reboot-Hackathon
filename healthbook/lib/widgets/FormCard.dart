import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
  final usernameController, passwordController;

  FormCard({this.usernameController, this.passwordController});
}

class _FormCardState extends State<FormCard> {
  final DatabaseReference database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: ScreenUtil.getInstance().setHeight(500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Login',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(58),
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text(
                'Username',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                    color: Colors.blue,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Username (ഉപയോക്തൃനാമം നൽകുക)',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                controller: widget.usernameController,
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text(
                'Password',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                    color: Colors.blue,
                  ),
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password (പാസ്വേഡ് നല്കൂ)',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                  ),
                ),
                controller: widget.passwordController,
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil.getInstance().setSp(28),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
