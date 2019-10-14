import 'package:flutter/material.dart';

class Anime extends StatefulWidget {
  Anime({Key key}) : super(key: key);

  _AnimeState createState() => _AnimeState();
}

class _AnimeState extends State<Anime> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(
      milliseconds: 50
    ));
    animation=Tween<double>(
      begin: 0,end: 1
    ).animate(animationController);
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Center(
         child: Container(
           color: Colors.green,
           height: animation.value*200,
           width: animation.value*200,
         ),
       );
        },
      ),
    );
  }
}
