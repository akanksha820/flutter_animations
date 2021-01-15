// import 'package:flutter/material.dart';

// //explicit animation
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   AnimationController myController;
//   final String myString = "Hey Akanksha Deshpande, How are you?";
//   Animation<int> count;

//   @override
//   void initState() {
//     super.initState();
//     myController =
//         AnimationController(vsync: this, duration: Duration(seconds: 8));
//     count = StepTween(begin: 0, end: myString.length)
//         .animate(CurvedAnimation(curve: Curves.easeIn, parent: myController)
//           // ..addStatusListener((state) {
//           //   print("state is $state");
//           //   if (state == AnimationStatus.completed) {
//           //     print("hello i'm here inside finsih !!");
//           //   }
//           // })
//           ..addListener(() {
//             setState(() {});
//           }));
//     myController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//               Color.fromRGBO(85, 98, 112, 1),
//               Color.fromRGBO(78, 205, 196, 1),
//             ])),
//         child: count == null
//             ? null
//             : Center(
//                 child: Container(
//                   margin: EdgeInsets.all(20),
//                   child: AnimatedBuilder(
//                     animation: count,
//                     builder: (BuildContext context, Widget child) {
//                       String textToBeDisplayed =
//                           myString.substring(0, count.value);
//                       return Text(textToBeDisplayed,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold));
//                     },
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
