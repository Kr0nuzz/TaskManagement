import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CenterNotepad extends StatelessWidget{

  const CenterNotepad({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/empty.json',
                          width: 200, height: 200),
                       Text(
                        'Kosong',
                        style: TextStyle(
                            fontSize: 20, color: Theme.of(context)
                                            .appBarTheme
                                            .titleTextStyle
                                            ?.color),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                );
  }
}