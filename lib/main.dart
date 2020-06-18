import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Application',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _backgroundController;
  Animation _color;
  Color _textColor;

  Color _curColor;
  Color _prevColor = Colors.white;
  final Random _random = Random();

  Color myRandomColor() {
    int a = _random.nextInt(256);
    int r = _random.nextInt(256);
    int g = _random.nextInt(256);
    int b = _random.nextInt(256);
    if (a > 100 && r > 100 && g > 100 && b > 100)
      _textColor = Colors.black;
    else
      _textColor = Colors.white;

    Color tmpColor = Color.fromARGB(a, r, g, b);

    return tmpColor;
  }

  void tapAction() {
    _curColor = myRandomColor();
    if (_backgroundController.status == AnimationStatus.completed) {
      _color = ColorTween(begin: _curColor, end: _prevColor)
          .animate(_backgroundController);
      _backgroundController.reverse();
    } else {
      _color = ColorTween(begin: _prevColor, end: _curColor)
          .animate(_backgroundController);
      _backgroundController.forward();
    }
    _prevColor = _curColor;
  }

  @override
  void initState() {
    _backgroundController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _color = ColorTween(begin: Colors.white).animate(_backgroundController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _backgroundController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _color,
      builder: (context, child) => RaisedButton(
          child: Text(
            "Hey there",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _textColor,
              fontSize: 30.0,
              fontFamily: 'Georgia',
              letterSpacing: 10,
            ),
          ),
          color: _color.value,
          onPressed: tapAction),
    );
  }
}
