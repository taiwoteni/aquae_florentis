import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieIcon extends StatefulWidget {
  final String res;
  final Color? color;
  final double size;
  final BoxFit? fit;
  final bool? repeat;
  const LottieIcon(this.res,
      {super.key, required this.size, this.color, this.fit, this.repeat});

  @override
  State<LottieIcon> createState() => _LottieIconState();
}

class _LottieIconState extends State<LottieIcon> {
  
  @override
  Widget build(BuildContext context) {
    final lottieWidget = Lottie.asset(
        "assets/lottie/${widget.res}.json",
        width: widget.size,
        height: widget.size,
        fit: widget.fit ?? BoxFit.cover,
        repeat: widget.repeat ?? false,
        filterQuality: FilterQuality.medium,
      );
    return widget.color != null? ColorFiltered(
      colorFilter: ColorFilter.mode(widget.color!, BlendMode.srcIn),
      child: lottieWidget,
    ):lottieWidget;
  }
}
