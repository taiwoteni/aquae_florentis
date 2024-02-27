import 'dart:ui';

import 'package:aquae_florentis/domain/models/navigation-model.dart';
import 'package:aquae_florentis/presentation/providers/navigation-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/logo-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardSide extends ConsumerStatefulWidget {
  const DashboardSide({super.key});

  @override
  ConsumerState<DashboardSide> createState() => _DashboardSideState();
}

class _DashboardSideState extends ConsumerState<DashboardSide> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(SizeManager.extralarge * 1.5)),
      child: Container(
        width: 302,
        height: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(SizeManager.extralarge * 1.5)),
            gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue],
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            Column(
              children: [
                ClipPath(
                  clipper: _CustomBezierClipper(),
                  child: Container(
                    height: 250,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const LogoWidget(
                      size: 80,
                    ),
                  ),
                ),
                mediumSpacer(),
                ...List.generate(
                    navigationItems.length,
                    (index) => _NavigationItem(
                        navigationItem: navigationItems[index], index: index))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends ConsumerStatefulWidget {
  final NavigationItemModel navigationItem;
  final int index;
  const _NavigationItem(
      {super.key, required this.index, required this.navigationItem});

  @override
  ConsumerState<_NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends ConsumerState<_NavigationItem> {
  @override
  Widget build(BuildContext context) {
    bool selected = ref.watch(navigationProvider) == widget.index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected ? Colors.white.withOpacity(0.3) : Colors.transparent),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          onTap: () {
            ref.watch(navigationProvider.notifier).state = widget.index;
          },
          tileColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          horizontalTitleGap: 15,
          leading: SvgIcon(
            selected
                ? "${widget.navigationItem.icon}-fill"
                : widget.navigationItem.icon,
            color: Colors.white,
            fit: BoxFit.cover,
            size: 24,
          ),
          title: Text(
            widget.navigationItem.label,
            style: GoogleFonts.quicksand(
                color: Colors.white,
                fontSize: FontSizeManager.medium,
                fontWeight: selected
                    ? FontWeightManager.bold
                    : FontWeightManager.medium),
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(101, 0);
    path.quadraticBezierTo(101, 20, 75, 20);
    path.lineTo(50, 20);
    path.quadraticBezierTo(25, 20, 25, 40);
    path.lineTo(101, 40);
    path.close();

    path.moveTo(101, 80);
    path.quadraticBezierTo(101, 60, 75, 60);
    path.lineTo(50, 60);
    path.quadraticBezierTo(25, 60, 25, 40);
    path.lineTo(101, 40);
    path.close();

    paint.color = ColorManager.primaryDark;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CustomBezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset controlOffset1 = Offset(size.width * 0.1, size.height);
    Offset endOffset1 = Offset(size.width, size.height * 0.9);

    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        controlOffset1.dx, controlOffset1.dy, endOffset1.dx, endOffset1.dy);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
