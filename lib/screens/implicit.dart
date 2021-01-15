import 'package:flutter/material.dart';

//explicit animation
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController myController;
  final String myString = "Hey Akanksha, How are you?";
  Animation<int> count;
  bool showFloatingButton = false;
  bool showTextInput = false;
  bool hideTextInput = false;
  dynamic lastName = "";
  TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    myController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    count = StepTween(begin: 0, end: myString.length)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: myController)
          ..addStatusListener((state) {
            print("state is $state");
            if (state == AnimationStatus.completed) {
              print("hello i'm here inside finsih !!");
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
    _getWelcomeText() {
      return Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: AnimatedBuilder(
            animation: count,
            builder: (BuildContext context, Widget child) {
              String textToBeDisplayed = myString.substring(0, count.value);
              return Text(textToBeDisplayed,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold));
            },
          ),
        ),
      );
    }

    getFloatingButton() {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: showTextInput
                ? () {
                    print("came here setting hideTextInput");
                    setState(() {
                      hideTextInput = true;
                    });
                  }
                : () {
                    setState(() {
                      showTextInput = true;
                    });
                  },
            child: Icon(
              Icons.arrow_forward,
              color: Colors.teal,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      );
    }

    getAnimatedFloatingButton() {
      return AnimatedOpacity(
        opacity: hideTextInput ? 0 : 1,
        duration: Duration(seconds: 2),
        child: getFloatingButton(),
      );
    }

    getTextInputSection() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          height: 200,
          width: 400,
          child: Column(
            children: <Widget>[
              Text(
                "Hello, please give your lastName",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                color: Colors.white,
                height: 50,
                width: 200,
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: textController,
                ),
              )
            ],
          ),
        ),
      );
    }

    hideWelcomeInput() {
      return AnimatedOpacity(
        curve: Curves.easeInOut,
        duration: Duration(seconds: 1),
        opacity: hideTextInput ? 0 : 1,
        child: getTextInputSection(),
      );
    }

    getCrossFade() {
      return AnimatedCrossFade(
        duration: Duration(seconds: 2),
        alignment: Alignment.center,
        firstChild: _getWelcomeText(),
        firstCurve: Curves.fastOutSlowIn,
        secondChild: hideWelcomeInput(),
        secondCurve: Curves.easeIn,
        crossFadeState: showTextInput
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
      );
    }

    getAnimatedLastWelcomeText() {
      return AnimatedOpacity(
        duration: Duration(seconds: 1),
        curve: Curves.bounceOut,
        opacity: hideTextInput ? 1 : 0,
        child: Center(
          child: Text(
            "Hey Akanksha ${textController.text} !!",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // ),
        ),
      );
      // return AnimatedPositioned(
      //   top: 400,
      //   left: 100,
      //   duration: Duration(seconds: 3),
      //   curve: Curves.bounceOut,
      //   child:  AnimatedOpacity(
      //     duration: Duration(seconds: 1),
      //     curve: Curves.easeIn,
      //     opacity: hideTextInput ?  1 : 0,
      //       child: Center(
      //         // child: Container(
      //         //   height: 200,
      //         //   width: 500,
      //         child:  Text("Hey Akanksha ${textController.text} !!", style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),
      // ),
      //               // ),
      //       ),
      //   ),
      // );
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
            count == null ? null : getCrossFade(),
            getAnimatedLastWelcomeText(),
            showFloatingButton ? getAnimatedFloatingButton() : Container(),
          ],
        ),
      ),
    );
  }
}
