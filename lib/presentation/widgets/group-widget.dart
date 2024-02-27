import 'dart:ui';

import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/number-decorator.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:aquae_florentis/presentation/widgets/ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupWidget extends StatefulWidget {
  final Community community;
  final int index;
  final bool isTop;
  final bool isLocation;
  final bool onlyRight;
  const GroupWidget(
      {super.key,
      required this.community,
      this.isLocation = false,
      this.onlyRight = false,
      required this.index,
      this.isTop = false});

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final Community community = widget.community;
    return Container(
      width: isMobile ? 145 : 150,
      height: isMobile ? 177 : 193,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeManager.regular * 1.2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: kElevationToShadow[1]![1].color,
                blurRadius: kElevationToShadow[1]![1].blurRadius,
                spreadRadius: kElevationToShadow[1]![1].spreadRadius,
                offset: Offset(kElevationToShadow[1]![1].offset.dx, 2))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeManager.regular * 1.2),
        child: Stack(
          children: [
            ClipPath(
              clipper: GroupWidgetClipper(
                  right: widget.onlyRight ? true : widget.index % 2 == 0),
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.white.withOpacity(0.07),
                  alignment: widget.onlyRight
                      ? Alignment.topRight
                      : widget.index % 2 == 0
                          ? Alignment.topRight
                          : Alignment.topLeft,
                  child: widget.isTop
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            PositionWriter.positionString(
                                position: widget.index + 1),
                            style: GoogleFonts.bubblegumSans(
                                fontWeight: FontWeightManager.extrabold,
                                fontSize: isMobile
                                    ? FontSizeManager.medium
                                    : FontSizeManager.extralarge,
                                color: Colors.black),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleImage(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(community.profile)),
                      size: isMobile ? 55 : 65),
                  regularSpacer(),
                  smallSpacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(isMobile ? 13 : 15),
                      Text(
                        community.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            fontWeight: FontWeightManager.semibold,
                            fontSize: isMobile
                                ? FontSizeManager.small * 1.17
                                : FontSizeManager.regular * 1.1,
                            color: ColorManager.primary),
                      ),
                      smallSpacer(),
                      SvgIcon(
                        "verified-fill",
                        color: community.verified
                            ? Colors.blue
                            : Colors.transparent,
                        size: isMobile ? 13 : 15,
                      )
                    ],
                  ),
                  isMobile ? regularSpacer() : mediumSpacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.group_solid,
                          size: isMobile
                              ? IconSizeManager.small * 1.1
                              : IconSizeManager.small * 1.2,
                          color: ColorManager.secondary),
                      smallSpacer(),
                      Text(
                        NumberDecorator.toDecoratedString(number: community.communitySize),
                        style: GoogleFonts.quicksand(
                          fontSize: isMobile
                              ? FontSizeManager.small
                              : FontSizeManager.regular,
                          color: ColorManager.secondary,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                    ],
                  ),
                  if (isMobile) smallSpacer(),
                  smallSpacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.location_solid,
                          size: isMobile
                              ? IconSizeManager.small * 0.9
                              : IconSizeManager.small * 1.1,
                          color: ColorManager.secondary),
                      smallSpacer(),
                      Text(
                        community.city,
                        style: GoogleFonts.quicksand(
                          fontSize: isMobile
                              ? FontSizeManager.small
                              : FontSizeManager.regular,
                          color: ColorManager.secondary,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PositionWriter {
  static String positionString({required final int position}) {
    switch (position) {
      case 1:
        return "1st";
      case 2:
        return "2nd";
      case 3:
        return "3rd";
      default:
        return "${position}th";
    }
  }
}

class GroupWidgetClipper extends CustomClipper<Path> {
  final bool right;
  const GroupWidgetClipper({required this.right});

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double w = size.width;
    final double h = size.height;

    if (right) {
      final control = Offset(w * 0.5, h * 0.5);
      final end = Offset(w, h * 0.5);

      path.moveTo(w * 0.5, 0);
      path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
      path.lineTo(w, 0);
      return path;
    }

    final control = Offset(w * 0.5 - 10, h * 0.5);
    final end = Offset(0, h * 0.5);

    path.lineTo(w * 0.5, 0);
    path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
    path.lineTo(0, h * 0.5);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
