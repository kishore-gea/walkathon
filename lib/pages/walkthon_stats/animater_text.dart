import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/text_style.dart';

class AnimatedCounter extends StatelessWidget {
  final double targetValue;
  final Duration duration;
  final TextStyle? style;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.duration = const Duration(seconds: 1000),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetValue),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Text(
          AppTextStyles().formatIndianNumber(value.toInt()), // round to integer
          style: style ?? Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}