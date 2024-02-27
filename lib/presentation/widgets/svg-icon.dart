import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatefulWidget {
  final String res;
  final double? size;
  final Color? color;
  final BoxFit? fit;
  const SvgIcon(this.res,{
    this.size,
    this.color,
    this.fit,
    super.key});

  @override
  State<SvgIcon> createState() => _SvgIconState();
}

class _SvgIconState extends State<SvgIcon> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      !widget.res.startsWith("assets/")? "assets/icons/${widget.res}.svg": widget.res,
      height: widget.size,
      width: widget.size,
      fit: widget.fit ?? BoxFit.cover,
      color: widget.color,
      );
  }
}