import 'dart:async';
import 'package:flutter/material.dart';


//using implicit animation

class LoginScreen2 extends StatefulWidget {
  @override
  _LoginScreen2State createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController;
  TextEditingController passwordController;
  double loginButtonWidth = 180;
  double loginButtonHeight = 60;
  bool loginComplete = false;
  String loginString = "Login";
  bool completedAnimatingButton = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
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
      return AnimatedContainer(
        onEnd: () {
          print("ended here !!");
          // CircularProgressIndicator();
          setState(() {
            completedAnimatingButton = true;
          });
          //
          Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  loginComplete = true;
                });
              });
        },
        curve: Curves.bounceOut,
        duration: Duration(seconds: 2),
        width: loginButtonWidth,
        height: loginButtonHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60.0))),
        child: completedAnimatingButton ? 
        loginComplete ? 
        Icon(Icons.check_circle_outline,
              size: 60,
              color: Colors.white,
                  )
        : CircularProgressIndicator()
        :ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: RaisedButton(
            color: Colors.pinkAccent,
            child: Text(
              loginButtonWidth == loginButtonHeight ? "" : loginString,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                loginButtonWidth = loginButtonHeight;
              });
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
         getLoginButton(),
        ],
      ),
    );
  }
}
