import 'package:flutter/material.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash>
    with SingleTickerProviderStateMixin {
  AnimationController myController;
  TextEditingController textController;
  Animation<int> count;
  String myString = "Hey! welcome to Animation lets find whats new";
  bool showFloatingButton = false;
  bool showInputText = false;
  bool hideInputBox = false;
  double _top = 20;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    myController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    count = StepTween(begin: 0, end: myString.length)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: myController)
          ..addStatusListener((state) {
            print("state is $state");
            if (state == AnimationStatus.completed) {
              setState(() {
                showFloatingButton = true;
              });
            }
          })
          ..addListener(() {
            setState(() {});
          }));
    myController.forward();
  }

  @override
  Widget build(BuildContext context) {
    getWelcomeText() {
      String stringTobDisplay = myString.substring(0, count.value);
      return Align(
        alignment: Alignment.center,
        child: Center(
            child: Container(
          height: 250,
          width: 300,
          child: Text(
            stringTobDisplay,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )),
      );
    }

    getFloatingButton() {
      return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {},
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  color: Colors.teal,
                  onPressed: showInputText
                      ? () {
                          print("came here");
                          setState(() {
                            hideInputBox = true;
                            showFloatingButton = false;
                            _top = 400;
                          });
                        }
                      : () {
                          setState(() {
                            showInputText = true;
                          });
                        },
                )),
          ));
    }

    getAnimatedFloatingButton() {
      return AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: showFloatingButton ? 1 : 0,
        child: getFloatingButton(),
        curve: Curves.easeIn,
      );
    }

//
    getInputText() {
      return Padding(
        padding: EdgeInsets.only(top: 100, right: 50, left: 50),
        child: Container(
          height: 200,
          width: 400,
          child: Column(
            children: <Widget>[
              Text(
                "Please provide your Name ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: textController,
                ),
              ),
            ],
          ),
        ),
      );
    }

    hideWelcomeText() {
      return AnimatedOpacity(
        duration: Duration(seconds: 1),
        child: getInputText(),
        opacity: hideInputBox ? 0 : 1,
        curve: Curves.easeIn,
      );
    }

    getCrossFadeWelcomeText() {
      return AnimatedCrossFade(
        duration: Duration(seconds: 1),
        alignment: Alignment.center,
        crossFadeState: showInputText
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: getWelcomeText(),
        secondChild: hideWelcomeText(),
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.easeIn,
      );
    }

    getLastWelcomeMessage() {
      return AnimatedOpacity(
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
          opacity: hideInputBox ? 1 : 0,
          child: Container(
              child: Text("Welcome ${textController.text} :)",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))));
    }

    getAnimatedLastWelcomeMessage() {
      return AnimatedPositioned(
          child: getLastWelcomeMessage(),
          left: 50,
          right: 50,
          top: _top,
          duration: Duration(seconds: 3),
          curve: Curves.bounceOut);
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(85, 98, 112, 1),
              Color.fromRGBO(78, 205, 196, 1),
            ])),
        child: Stack(
          children: <Widget>[
            count == null ? Container() : getCrossFadeWelcomeText(),
            getAnimatedLastWelcomeMessage(),
            // showInputText ? getInputText() : Container(),
            getAnimatedFloatingButton(),
          ],
        ),
      ),
    );
  }
}
