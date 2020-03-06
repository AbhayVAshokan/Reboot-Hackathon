// Screen to implement User Sign Up

import 'package:flutter/material.dart';

import '../widgets/CustomIcons.dart';
import '../widgets/SocialIcon.dart';
import '../widgets/constants.dart';
import '../widgets/custom_shape.dart';
import '../widgets/customappbar.dart';
import '../widgets/responsive_ui.dart';
import '../widgets/textformfield.dart';
import '../widgets/drop_down.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  // Variables to check whether the contents are entered or not
  bool _validateFirstName = true,
      _validateLastName = true,
      _validateEmail = true,
      _validateMobileNumber = true,
      _validationHeight = true,
      _validationWeight = true,
      _validateConfirm = true;

  // TextEditingControllers for all textFields.
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  var gender = "Male";

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                acceptTermsTextRow(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                infoTextRow(),
                socialIconsRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.indigo],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange[200], Colors.indigo],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () {
              // getImage();
            },
            child: gender == "Male"
                ? Image.asset('healthbook/lib/assets/images/man_face.jpeg')
                : Image.asset('healthbook/lib/assets/images/female_face.png'),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            genderDropDown(),
            SizedBox(height: _height / 60.0),
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
            confirmPasswordTextFormField(),
            SizedBox(height: _height / 60.0),
            heightTextFormField(),
            SizedBox(height: _height / 60.0),
            weightTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget genderDropDown() {
    var _width = MediaQuery.of(context).size.width;
    var _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    var large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    var medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    var selectedUser;

    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: Center(
        child: DropdownButton<Item>(
          hint: Text("Select Gender (ലിംഗഭേദം)"),
          value: selectedUser,
          onChanged: (Item value) {
            setState(() {
              selectedUser = value;
            });
          },
          items: users.map((Item user) {
            return DropdownMenuItem<Item>(
              value: user,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                  children: <Widget>[
                    user.icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      user.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Set of widgets used to create the textFields.
  Widget confirmPasswordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.lock,
      hint: "Confirm Password (പാസ്വേഡ്)",
      obscureText: true,
      textEditingController: confirmController,
      errorText: _validateConfirm ? null : "Password do not match",
    );
  }

  Widget heightTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.linear_scale,
      hint: "Height (in cm) (ഉയരം)",
      textEditingController: heightController,
      errorText: _validationHeight ? null : "Enter valid height",
    );
  }

  Widget weightTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.fastfood,
      hint: "Weight (in kg) (ഭാരം)",
      textEditingController: weightController,
      errorText: _validationWeight ? null : "Enter valid weight",
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "First Name (പേരിന്റെ ആദ്യഭാഗം)",
      textEditingController: firstNameController,
      errorText: _validateFirstName ? null : "Enter valid first name",
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Last Name (പേരിന്റെ അവസാന ഭാഗം)",
      textEditingController: lastNameController,
      errorText: _validateLastName ? null : "Enter valid last name",
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID (ഇ - മെയിൽ ഐഡി)",
      textEditingController: emailController,
      errorText: _validateEmail ? null : "Enter valid email id",
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Mobile Number (മൊബൈൽ നമ്പർ)",
      textEditingController: mobileNumberController,
      errorText: _validateMobileNumber ? null : "Enter valid mobile number",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password (പാസ്വേഡ്)",
      textEditingController: passwordController,
      errorText: checkStrongPassword(),
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.blue[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  bool isDigit(String s, int idx) =>
      "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;

  // Function to check whether the password is strong or not.
  String checkStrongPassword() {
    if (passwordController.text.isEmpty) {
      return "Password cannot be empty";
    }
    var password = passwordController.text.toString();

    var flags = [0, 0, 0, 0];
    for (int i = 0; i < password.length; i++) {
      if (allNumbers.contains(password[i])) {
        flags[0] = 1;
      }
      if (allCapitals.contains(password[i])) {
        flags[1] = 1;
      }
      if (allSmalls.contains(password[i])) {
        flags[2] = 1;
      }
      if (allSymbols.contains(password[i])) {
        flags[3] = 1;
      }
    }

    if (flags[0] == 0) {
      return "Password must contain atleast one digit";
    } else if (flags[1] == 0) {
      return "Password must contain atleast one capital letter";
    } else if (flags[2] == 0) {
      return "Password must contain atleast one small letter";
    } else if (flags[3] == 0) {
      return "Password must contain atleast one special character";
    } else if (password.length < 8) {
      return "Password must contain atleast 8 letters";
    } else {
      return null;
    }
  }

  // SIGN UP raised button.
  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print("Routing to your account");
        setState(() {
          if (firstNameController.text.isEmpty) {
            _validateFirstName = false;
          } else {
            _validateFirstName = true;
          }

          if (lastNameController.text.isEmpty) {
            _validateLastName = false;
          } else {
            _validateLastName = true;
          }

          if (emailController.text.isEmpty) {
            _validateEmail = false;
          } else if (!(emailController.text.contains('@') &&
              (emailController.text.contains('.com') ||
                  emailController.text.contains('.in')))) {
            _validateEmail = false;
          } else {
            _validateEmail = true;
          }

          if (mobileNumberController.text.isEmpty) {
            _validateMobileNumber = false;
          } else {
            _validateMobileNumber = true;
          }

          if (mobileNumberController.text.isEmpty) {
            _validateMobileNumber = false;
          } else if (mobileNumberController.text.length != 10) {
            _validateMobileNumber = false;
          } else {
            _validateMobileNumber = true;
          }

          if (heightController.text.isEmpty) {
            _validationHeight = false;
          } else if (int.parse(heightController.text) < 0) {
            _validationHeight = false;
          } else {
            _validationHeight = true;
          }

          if (weightController.text.isEmpty) {
            _validationWeight = false;
          } else if (int.parse(heightController.text) < 0) {
            _validationWeight = false;
          } else {
            _validationWeight = true;
          }

          if (confirmController.text.compareTo(passwordController.text) == 0) {
            _validateConfirm = true;
          } else {
            _validateConfirm = false;
          }
        });
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[200], Colors.purple],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SocialIcon(
            colors: [
              Color(0xFFff4f38),
              Color(0xFFff355d),
            ],
            icondata: CustomIcons.googlePlus,
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          ),
          SocialIcon(
            colors: [
              Color(0xFF102397),
              Color(0xFF187adf),
              Color(0xFF00eaf8),
            ],
            icondata: CustomIcons.facebook,
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          ),
          SocialIcon(
            colors: [
              Color(0xFF17ead9),
              Color(0xFF6078ea),
            ],
            icondata: CustomIcons.twitter,
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          ),
          SocialIcon(
            colors: [
              Color(0xFF17ead9),
              Color(0xFF6078ea),
            ],
            icondata: CustomIcons.linkedin,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(signIn);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.yellow[200],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
