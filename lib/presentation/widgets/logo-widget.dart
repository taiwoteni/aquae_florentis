import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final BoxShape shape;
  const LogoWidget({super.key, this.size = 100, this.shape = BoxShape.circle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: shape),
      child: const SvgIcon('aquae-florentis', size: double.maxFinite,),
    );
  }
}