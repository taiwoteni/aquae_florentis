import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  const DotWidget({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: size ?? 3,
        height: size ?? 3,
        child: DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color ?? ColorManager.secondary.withOpacity(0.4))),
      ),
    );
  }
}
