// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPallete extends StatefulWidget {
  final int? rows, columns;
  final double? itemSize;
  int? selectedIndex;
  final void Function(Map<String, Color> clickedColor) onSelect;
  ColorPallete(
      {super.key,
      this.rows,
      this.columns,
      this.itemSize,
      this.selectedIndex,
      required this.onSelect});

  @override
  State<ColorPallete> createState() => _ColorPalleteState();
}

class _ColorPalleteState extends State<ColorPallete> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.columns ?? 5,
          childAspectRatio: 1,
          mainAxisSpacing: SizeManager.regular),
      shrinkWrap: true,
      itemCount: ColorManager.colorSet.length,
      itemBuilder: (context, index) {
        final selectedColorSet = ColorManager.colorSet[index];
        return GestureDetector(
          onTap: () {
            widget.onSelect(selectedColorSet);
          },
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            alignment: Alignment.center,
            child: Container(
                width: widget.itemSize ?? SizeManager.extralarge * 1.4,
                height: widget.itemSize ?? SizeManager.extralarge * 1.4,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        selectedColorSet["primary"]!,
                        selectedColorSet["accent"]!
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.primaryDark,
                          width: 2.2,
                          style: (widget.selectedIndex ?? 0) == index
                              ? BorderStyle.solid
                              : BorderStyle.none),
                      color: Colors.transparent,
                      shape: BoxShape.circle),
                )),
          ),
        );
      },
    );
  }
}

class AccentPainter extends CustomPainter {
  final Color accentColor;
  const AccentPainter({required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = accentColor;

    final double centerX = size.width / 2;
    final double centerY = size.height;

    // Calculate the radius
    final double radius = size.width / 2;

    canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        0,
        pi,
        true,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
