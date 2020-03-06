import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FormCard extends StatelessWidget {
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
                  hintText: 'Enter Username',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),

                ),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
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
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                  ),
                ),
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
