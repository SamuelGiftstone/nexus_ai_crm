// lib/shared/animations/fade_slide_transition.dart

import 'package:flutter/material.dart';

class FadeSlideTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Offset offset;

  const FadeSlideTransition({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.offset = const Offset(0, 0.05),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, childWidget) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              offset.dx * (1 - value) * 100,
              offset.dy * (1 - value) * 100,
            ),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}