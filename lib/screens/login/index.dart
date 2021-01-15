import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/new_implicit.dart';

//using explicit animation

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController;
  TextEditingController passwordController;
  AnimationController myController;
  Animation<double> buttonWidth;
  double loginButtonWidth = 180;
  double loginButtonHeight = 60;
  bool loginComplete = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    myController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    buttonWidth = Tween<double>(begin: loginButtonWidth, end: loginButtonHeight)
        .animate(CurvedAnimation(curve: Curves.bounceOut, parent: myController)
          ..addStatusListener((state) {
            print("state is $state");
            if (state == AnimationStatus.completed) {
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  loginComplete = true;
                });
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySplash()),
                  );
                });
              });
            }
          })
          ..addListener(() {
            setState(() {});
          }));
  }

  @override
  Widget build(BuildContext context) {
    getTextField(
        {TextEditingController textController,
        bool isPassword = false,
        String helperText,
        IconData prefixIcon}) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: textController,
          obscureText: isPassword ? true : false,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(55.0),
                borderSide: BorderSide(
                  color: Colors.pinkAccent,
                  width: 1.0,
                ),
              ),
              helperText: helperText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(55.0),
                borderSide: BorderSide(
                  color: Colors.pinkAccent,
                  width: 1.0,
                ),
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: Colors.black26,
              )),
        ),
      );
    }

    getLoginButton() {
      return Container(
        width: buttonWidth.value,
        height: loginButtonHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60.0))),
        child: buttonWidth.status == AnimationStatus.completed
            ? loginComplete
                ? Icon(
                    Icons.check_circle_outline,
                    size: 60,
                    color: Colors.white,
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )
            : ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text(
                      buttonWidth.status == AnimationStatus.forward
                          ? ""
                          : "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    myController.forward();
                  },
                ),
              ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          getTextField(
              textController: emailController,
              helperText: "Email here",
              prefixIcon: Icons.person_outline),
          SizedBox(
            height: 20,
          ),
          getTextField(
              textController: passwordController,
              isPassword: true,
              helperText: "Passeord here",
              prefixIcon: Icons.lock),
          SizedBox(
            height: 50,
          ),
          getLoginButton()
        ],
      ),
    );
  }
}
