// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  Indicator({super.key, required this.active, this.expand = true, this.size = 6});
  double size;
  bool expand;
  bool active;

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(
          horizontal: widget.expand & widget.active ? 4 : 2, vertical: 6),
      height: widget.size,
      width: widget.expand & widget.active ? widget.size * 3 : widget.size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: widget.active ? Colors.white : Colors.white.withOpacity(0.4)),
      duration: const Duration(milliseconds: 350),
    );
  }
}
