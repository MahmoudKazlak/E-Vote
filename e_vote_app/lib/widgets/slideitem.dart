import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/slide.dart';


class SlideItem extends StatelessWidget{
  final int index;
  const SlideItem(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Align(
                  alignment: Alignment.center,
                  child: 
                  Image.asset(slideList[index].imageurl,
                  width: 390.0,
                  height: 260.0,
                  fit:BoxFit.fill,
                  ),
                ),
                  Text(
                  slideList[index].title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20,),
                  Text(
                  slideList[index].description,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 131, 73, 162),
                  ),
                ),
                  ],
                );
  }

}