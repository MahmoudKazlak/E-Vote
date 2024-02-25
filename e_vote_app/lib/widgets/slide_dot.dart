import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget{
    bool isActive;
    SlideDots(this.isActive, {super.key});
  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive?12:8 ,
      width: isActive?12:8,
      decoration: BoxDecoration(
        color: isActive?Color.fromARGB(255, 69, 34, 75):Color.fromARGB(255, 126, 85, 138),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      );
  }

}