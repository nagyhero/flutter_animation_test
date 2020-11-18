import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TweenAnimationBuilder(
            child: Text(
              ' app title',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 500),
            curve: Curves.bounceOut,
            builder: (context, value, child) {
              return Opacity(
                  opacity: value,
                  child: Padding(
                      padding: EdgeInsets.only(top: value * 20), child: child));
            }),
      ),
    );
  }
}
