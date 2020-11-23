import 'package:flutter/material.dart';
import 'package:flutter_animation_test/home_screen.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item item;

  ItemDetailsScreen({@required this.item});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  Animation _curve;
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _curve =
        CurvedAnimation(parent: _animationController, curve: Curves.slowMiddle);

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.redAccent)
        .animate(_curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 30, end: 50), weight: 500),
      TweenSequenceItem(tween: Tween(begin: 50, end: 30), weight: 500),
    ]).animate(_curve);

    _animationController.addListener(() {
      print(_animationController.value);
      print(_colorAnimation.value);
    });

    _animationController.addStatusListener((status) {
      print(_animationController.status);
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Hero(
                  tag: widget.item.id,
                  child: Icon(
                    widget.item.icon,
                    size: 200,
                  )),
              SizedBox(
                height: 50,
              ),
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, _) {
                    return InkWell(
                      onTap: () => isFav
                          ? _animationController.reverse()
                          : _animationController.forward(),
                      child: Icon(
                        Icons.favorite,
                        size: _sizeAnimation.value,
                        color: _colorAnimation.value,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
