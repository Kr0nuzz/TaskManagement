import 'package:flutter/material.dart';

class TombolSwitch extends StatelessWidget{
  TombolSwitch();

  @override
  Switch build(BuildContext context){
    bool initswitch = false;
    return Switch(value: initswitch, onChanged: (nilai){});
  }
}