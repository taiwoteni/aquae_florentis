import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/community-screen.dart';
import 'package:aquae_florentis/presentation/utilities/number-decorator.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/profile-bar.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityWidget extends ConsumerStatefulWidget {
  final Community community;
  const CommunityWidget({super.key, required this.community});

  @override
  ConsumerState<CommunityWidget> createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends ConsumerState<CommunityWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommunityScreen(community: widget.community),
        ));
      },
      child: Container(
        width: isMobile
            ? null
            : isTablet
                ? MediaQuery.of(context).size.width * 0.45
                : MediaQuery.of(context).size.width * 0.25,
        padding: const EdgeInsets.symmetric(
            vertical: SizeManager.regular, horizontal: 0),
        decoration: BoxDecoration(
            color: ColorManager.background,
            borderRadius: BorderRadius.circular(
                isMobile ? SizeManager.regular * 1.2 : SizeManager.large),
            boxShadow: [
              kElevationToShadow[2]![1],
            ]),
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.transparent,
              dense: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.medium, vertical: 0),
              leading: ProfileIcon(widget.community.profile, size: 45),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.community.name,
                    style: GoogleFonts.quicksand(
                        fontSize: FontSizeManager.medium * 0.8,
                        fontWeight: FontWeightManager.semibold,
                        color: ColorManager.primary),
                  ),
                  smallSpacer(),
                  if (widget.community.verified)
                    const SvgIcon(
                      "verified-fill",
                      size: IconSizeManager.regular * 0.8,
                      color: Colors.blue,
                    )
                ],
              ),
              subtitle: RatingBar.builder(
                ignoreGestures: true,
                allowHalfRating: true,
                initialRating: widget.community.rating,
                itemCount: 5,
                glowColor: Colors.orangeAccent,
                unratedColor: Colors.orangeAccent.withOpacity(0.3),
                itemSize: IconSizeManager.small,
                itemBuilder: (context, index) {
                  return const Icon(CupertinoIcons.star_fill,
                      color: Colors.orangeAccent, size: IconSizeManager.small);
                },
                onRatingUpdate: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 61),
              child: Row(
                children: [
                  SvgIcon(
                    TaskTypeConverter.convertToSVGIcon(taskType: widget.community.role),
                    size: IconSizeManager.small * 1.3,
                    color: Colors.blue,
                  ),
                  smallSpacer(),
                  Text(
                    TaskTypeConverter.convertToString(
                        taskType: widget.community.role),
                    style: GoogleFonts.quicksand(
                        color: ColorManager.secondary,
                        fontSize: FontSizeManager.regular * 0.8,
                        fontWeight: FontWeightManager.medium),
                  )
                ],
              ),
            ),
            regularSpacer(),
            Padding(
              padding: const EdgeInsets.only(left: 61),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.group_solid,
                    size: IconSizeManager.small * 1.3,
                    color: Colors.blue,
                  ),
                  regularSpacer(),
                  Text(
                    NumberDecorator.toDecoratedString(
                        number: widget.community.communitySize),
                    style: GoogleFonts.quicksand(
                        color: ColorManager.secondary,
                        fontSize: FontSizeManager.regular * 0.8,
                        fontWeight: FontWeightManager.medium),
                  )
                ],
              ),
            ),
            regularSpacer(),
            Padding(
              padding: const EdgeInsets.only(left: 61),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    CupertinoIcons.location_solid,
                    size: IconSizeManager.small * 1.3,
                    color: Colors.blue,
                  ),
                  smallSpacer(),
                  Text(
                    widget.community.addressFormat,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: GoogleFonts.quicksand(
                        color: ColorManager.secondary,
                        fontSize: FontSizeManager.regular * 0.8,
                        fontWeight: FontWeightManager.medium),
                  )
                ],
              ),
            ),
            regularSpacer(),
          ],
        ),
      ),
    );
  }
}
