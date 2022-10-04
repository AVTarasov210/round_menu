import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class FloatingMenu extends StatefulWidget {
  const FloatingMenu(this.duration, this.radius, {Key? key})
      : super(key: key);

  final int duration;
  final double radius;

  @override
  _FloatingMenuState createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _buttonAnimatedIcon;

  late Animation<double> _translateButton;

  bool _isExpanded = false;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 0,
      end: widget.radius,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.radius * 2 + 60;
    double height = widget.radius + 60;
    double center = width/2-30;
    return Container(
        height: height,
        width: width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: center + cos(pi) * _translateButton.value,
              bottom: sin(pi) * _translateButton.value,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  print("aaa");
                },
                child: const Icon(
                  Icons.photo_camera,
                ),
              ),
            ),
            Positioned(
              left: center + cos(3 * pi / 4) * _translateButton.value,
              bottom: sin(3 * pi / 4) * _translateButton.value,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  print("bbb");
                  /* Do something */
                },
                child: const Icon(
                  Icons.video_camera_back,
                ),
              ),
            ),
            Positioned(
              left: center + cos(pi / 2) * _translateButton.value,
              bottom: sin(pi / 2) * _translateButton.value,
              child: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {
                  print("ccc");
                  /* Do something */
                },
                child: const Icon(Icons.photo),
              ),
            ),
            Positioned(
              left: center + cos(pi / 4) * _translateButton.value,
              bottom: sin(pi / 4) * _translateButton.value,
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurpleAccent,
                onPressed: () {
                  print("ddd");
                  /* Do something */
                },
                child: const Icon(
                  Icons.people_alt_outlined,
                ),
              ),
            ),
            Positioned(
              left: center + cos(0) * _translateButton.value,
              bottom: sin(0) * _translateButton.value,
              child: FloatingActionButton(
                backgroundColor: Colors.tealAccent,
                onPressed: () {
                  print("eee");
                  /* Do something */
                },
                child: const Icon(
                  Icons.settings,
                ),
              ),
            ),
            Positioned(
              left: center,
              bottom: 0,
              child: FloatingActionButton(
                onPressed: _toggle,
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _buttonAnimatedIcon,
                ),
              ),
            )
          ],
        ));
  }
}