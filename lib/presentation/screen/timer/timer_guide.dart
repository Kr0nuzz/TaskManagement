import 'package:flutter/material.dart';

class TimerGuide extends StatelessWidget {
  const TimerGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(30),
      child: const Column(children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "- Session time is for how much session do u want, 1x session equals 1x focus time & 1x rest time",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            decoration: TextDecoration.none
          ),
        ),
        SizedBox(height: 20,),
        Text(
          "- Focus time is for you to be focus of what you want to do",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
             decoration: TextDecoration.none
          ),
        ),
        SizedBox(height: 20,),
        Text(
          "- Rest time is for you to take a brake after focusing your self",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
             decoration: TextDecoration.none
          ),
        ),
      ]),
    );
  }
}
