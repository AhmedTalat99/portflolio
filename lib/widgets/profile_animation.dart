import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portflolio/globals/app_colors.dart';

import '../globals/app_assets.dart';

class ProfileAnimation extends StatefulWidget {
  const ProfileAnimation({super.key});

  @override
  State<ProfileAnimation> createState() => _ProfileAnimationState();
}

class _ProfileAnimationState extends State<ProfileAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _animation = Tween(begin: const Offset(0, 0.1), end: const Offset(0, 0.2))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: CircleAvatar(
        radius: 200,
        child: Image.asset(
          AppAssets.profile2,
          height: 450,
          width: 400,
          /*  width: MediaQuery.of(context).size.width * .7,
          height: MediaQuery.of(context).size.height * .5,
        */
        ),
      ),
    );
  }
}
