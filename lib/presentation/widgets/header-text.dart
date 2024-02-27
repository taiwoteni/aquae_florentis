import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum HeaderTextStyle { header, subheader }

class HeaderText extends StatelessWidget {
  final String title;
  final Color? color;
  final double fontSize;
  final HeaderTextStyle headerTextStyle;
  final TextAlign textAlign;
  const HeaderText(this.title,
      {super.key,
      this.fontSize = 21,
      this.textAlign = TextAlign.left,
      this.color,
      this.headerTextStyle = HeaderTextStyle.header});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: GoogleFonts.quicksand(
        fontSize: headerTextStyle == HeaderTextStyle.header
            ? Responsive.isMobile(context)
                ? FontSizeManager.large * 1.1
                : FontSizeManager.extralarge
            : fontSize,
        color: color ?? ColorManager.primary,
        fontWeight: FontWeightManager.extrabold,
      ),
    );
  }
}
