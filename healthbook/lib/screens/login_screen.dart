import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:toast/toast.dart';

import '../widgets/FormCard.dart';
import '../widgets/SocialIcon.dart';
import '../widgets/CustomIcons.dart';
import './home_screen.dart';
import './signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DatabaseReference database = FirebaseDatabase.instance.reference();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  bool _isSelected = false;
  bool validatedUsername = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  void getData() {
    String username = usernameController.text;
    if (!username.contains('@') ||
        !(username.contains('.com') || username.contains('.in'))) {
      validatedUsername = false;
      Toast.show("Enter valid email id", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      return;
    }

  String decrypt(String password) {
    final encryptedString = password.split('');
          for (int i = 0; i < password.length; i++) {
            encryptedString[i] =
                String.fromCharCode(((password.codeUnitAt(i) - 3)));
          }
          print('decrtpted password: ');
          print(encryptedString.join(''));
          return encryptedString.join('');
  }

    bool checkPassword(String username, String password) {
      print(password);
      database.once().then((DataSnapshot snapshot) {
        String originalPassword =
            decrypt(snapshot.value[username].child('password'));
        print(originalPassword);
        if (originalPassword.compareTo(password) == 0) {
          return true;
        } else {
          return false;
        }
      });
      return false;
    }

    username = username.split('@')[0];
    print(username);

    database.once().then((DataSnapshot snapshot) {
      print(username);
      if (snapshot.value[username] != null) {
        validatedUsername = true;
        if (checkPassword(username, passwordController.text)) {
          return;
        } else {
          Toast.show("Invalid username or password", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        }
      } else {
        Toast.show("Invalid username or password", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
    });
  }

  // Remember me radio button
  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset('lib/assets/images/image_01.png'),
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset('lib/assets/images/image_02.png'),
              ],
            ),
            SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'lib/assets/images/logo_foreground.png',
                              width: ScreenUtil.getInstance().setWidth(90),
                              height: ScreenUtil.getInstance().setHeight(90),
                            ),
                            Text(
                              '  HealthBook',
                              style: GoogleFonts.quintessential(
                                textStyle: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(62),
                                  letterSpacing: .6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(180),
                        ),
                        FormCard(
                          passwordController: passwordController,
                          usernameController: usernameController,
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(35),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      ScreenUtil.getInstance().setWidth(12.0),
                                ),
                                GestureDetector(
                                  onTap: _radio,
                                  child: radioButton(_isSelected),
                                ),
                                SizedBox(
                                  width: ScreenUtil.getInstance().setWidth(8.0),
                                ),
                                Text('Remember me',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    )),
                              ],
                            ),
                            InkWell(
                              child: Container(
                                width: ScreenUtil.getInstance().setWidth(300),
                                height: ScreenUtil.getInstance().setHeight(100),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF17ead9),
                                    Color(0xFF6078ea)
                                  ]),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0,
                                    )
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      getData();
                                      validatedUsername
                                          ? Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                  usernameController:
                                                      usernameController,
                                                ),
                                              ),
                                            )
                                          : LoginScreen();
                                    },
                                    child: Center(
                                      child: Text(
                                        'SIGNIN',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            letterSpacing: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            horizontalLine(),
                            Text('Social Login',
                                style: TextStyle(
                                  fontSize: 16.0,
                                )),
                            horizontalLine(),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SocialIcon(
                              colors: [
                                Color(0xFF102397),
                                Color(0xFF187adf),
                                Color(0xFF00eaf8),
                              ],
                              icondata: CustomIcons.facebook,
                              onPressed: () {},
                            ),
                            SocialIcon(
                              colors: [
                                Color(0xFFff4f38),
                                Color(0xFFff355d),
                              ],
                              icondata: CustomIcons.googlePlus,
                              onPressed: () {},
                            ),
                            SocialIcon(
                              colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea),
                              ],
                              icondata: CustomIcons.twitter,
                              onPressed: () {},
                            ),
                            SocialIcon(
                              colors: [
                                Color(0xFF00c6fb),
                                Color(0xFF005bea),
                              ],
                              icondata: CustomIcons.linkedin,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'New User? ',
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text('SignUp',
                                  style: TextStyle(
                                    color: Color(0xFF5d74e3),
                                  )),
                            )
                          ],
                        )
                      ],
                    ))),
          ],
        ));
  }
}
