import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;
  final Tween _backgroundTween = Tween(begin: 0.0, end: 1.0);
  AnimationController? _starAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _starAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _starAnimationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circularAnimationButton(),
                _starIcon(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 2),
      tween: _backgroundTween,
      curve: Curves.easeInCirc,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
            debugPrint(_buttonRadius.toString());
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: _buttonRadius,
          width: _buttonRadius,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 140, 45, 159),
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          child: const Center(
            child: Text("Date"),
          ),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starAnimationController!.view,
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _starAnimationController!.value * 2 * pi,
          child: child,
        );
      },
    );
  }
}
