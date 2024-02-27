import 'package:aquae_florentis/data/auth.dart';
import 'package:aquae_florentis/domain/models/user.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ui_widget.dart';

class ProfileBar extends StatefulWidget {
  final User user;
  const ProfileBar({super.key, required this.user});

  @override
  State<ProfileBar> createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  late double searchBarWidth;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    searchBarWidth = MediaQuery.of(context).size.width * 0.2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? ProfileIcon(
            widget.user.profile,
            size: 40,
            online: true,
          )
        : InkWell(
            onTap: () => AppAuth.signOut(context: context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.medium, vertical: 8),
              decoration: BoxDecoration(
                  color: ColorManager.background,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.secondary.withOpacity(0.2),
                    )
                  ]),
              child: Row(
                children: [
                  ProfileIcon(
                    widget.user.profile,
                    size: 35,
                    online: true,
                  ),
                  const Gap(SizeManager.medium),
                  Text(
                    '${widget.user.firstName} ${widget.user.lastName}',
                    style: GoogleFonts.quicksand(
                        color: ColorManager.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  const Gap(SizeManager.medium),
                  Icon(
                    CupertinoIcons.chevron_down,
                    color: ColorManager.secondary,
                    size: 17,
                  ),
                ],
              ),
            ),
          );
  }

  Widget searchIcon(Color color) {
    return SvgIcon(
      'res/icons/search.svg',
      size: 24,
      color: color,
    );
  }

  void search() {}
}

class ProfileIcon extends StatefulWidget {
  final double size;
  final BorderRadius? borderRadius;
  final bool? online;
  final String url;
  final BoxShape shape;
  final EdgeInsets? margin;
  const ProfileIcon(this.url,
      {super.key,
      required this.size,
      this.online,
      this.borderRadius,
      this.margin})
      : shape = borderRadius == null ? BoxShape.circle : BoxShape.rectangle;

  @override
  State<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.size,
          height: widget.size,
          margin: widget.margin,
          decoration: BoxDecoration(
            shape: widget.shape,
            borderRadius: widget.borderRadius,
          ),
          child: CircleImage(
              image: DecorationImage(
                  image: NetworkImage(widget.url), fit: BoxFit.cover),
              size: widget.size),
        ),
        if (widget.online != null)
          Positioned(
            bottom: -1,
            right: 0,
            child: SizedBox(
              width: 14,
              height: 14,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !Responsive.isMobile(context)
                      ? Colors.white
                      : ColorManager.tertiary,
                ),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.online! ? Colors.green : Colors.red)),
              ),
            ),
          )
      ],
    );
  }
}
