import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:flutter/material.dart';
import '../resources/value-manager.dart';
import '../utilities/responsive.dart';
import 'header-text.dart';
import 'spacers.dart';

class LabelledProgressBar extends StatefulWidget {
  final double? barWidth;
  final String? label;
  final String? title;
  final Color? barColor, progressColor;
  final double max, progress;
  const LabelledProgressBar({
    super.key,
    required this.progress,
    required this.max,
    this.title,
    this.barWidth,
    this.barColor,
    this.progressColor,
    this.label,
  });

  @override
  State<LabelledProgressBar> createState() => _LabelledProgressBarState();
}

class _LabelledProgressBarState extends State<LabelledProgressBar> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final double size =
        isMobile ? SizeManager.extralarge * 2.3 : SizeManager.extralarge * 3.3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: size,
                    height: size,
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: CircularProgressIndicator(
                          backgroundColor:
                              widget.barColor ?? ColorManager.tertiary,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              widget.progressColor ??
                                  ColorManager.primaryColor),
                          value: (widget.progress / widget.max),
                          strokeWidth: widget.barWidth ?? 4,
                        ))),
              ),
              if (widget.label != null)
                HeaderText(
                  widget.label!,
                  headerTextStyle: HeaderTextStyle.subheader,
                  fontSize: (0.27 * size),
                )
            ],
          ),
        ),
        if (widget.title != null) isMobile ? regularSpacer() : mediumSpacer(),
        if (widget.title != null)
          HeaderText(
            widget.title!,
            headerTextStyle: HeaderTextStyle.subheader,
            fontSize: isMobile
                ? FontSizeManager.regular * 0.8
                : FontSizeManager.medium,
          )
      ],
    );
  }
}
