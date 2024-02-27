import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:aquae_florentis/presentation/widgets/ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatefulWidget {
  final Community community;
  const ProfileHeader({super.key, required this.community});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late Community community;

  @override
  void initState() {
    community = widget.community;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final isMobile = Responsive.isMobile(context);
    const double imageSize = 110;
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
          vertical: SizeManager.regular, horizontal: SizeManager.medium * 1.1),
      decoration: BoxDecoration(
        color: community.primaryColor,
      ),
      child: Column(
        children: [
          largeSpacer(),
          largeSpacer(),
          SizedBox(
            height: imageSize,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleImage(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(community.profile)),
                    size: imageSize),
                mediumSpacer(),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          community.name,
                          style: GoogleFonts.ubuntu(
                              fontSize: FontSizeManager.medium * 1.2,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.primaryDark),
                        ),
                        smallSpacer(),
                        smallSpacer(),
                        if (!widget.community.verified)
                          const SvgIcon(
                            "verified-fill",
                            size: IconSizeManager.regular * 0.8,
                            color: Colors.white,
                          )
                      ],
                    ),
                    regularSpacer(),
                    smallSpacer(),
                    RatingBar.builder(
                      ignoreGestures: true,
                      allowHalfRating: true,
                      initialRating: widget.community.rating,
                      itemCount: 5,
                      glowColor: Colors.white,
                      unratedColor: Colors.white.withOpacity(0.3),
                      itemSize: IconSizeManager.small * 1.1,
                      itemBuilder: (context, index) {
                        return const Icon(CupertinoIcons.star_fill,
                            color: Colors.white);
                      },
                      onRatingUpdate: (value) {},
                    ),
                    regularSpacer(),
                    smallSpacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          CupertinoIcons.location_solid,
                          size: IconSizeManager.small * 1.1,
                          color: Colors.white,
                        ),
                        smallSpacer(),
                        Text(
                          widget.community.country,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: GoogleFonts.quicksand(
                              color: ColorManager.primaryDark,
                              fontSize: FontSizeManager.small,
                              fontWeight: FontWeightManager.medium),
                        )
                      ],
                    ),
                    regularSpacer(),
                    smallSpacer(),
                  ],
                ))
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
                horizontal: SizeManager.medium, vertical: SizeManager.regular),
            child: Row(
              children: [
                const ExpandedItem(
                  title: "Members",
                  label: "4K",
                ),
                Divider(
                  color: Colors.white.withOpacity(0.5),
                  thickness: 1,
                ),
                const ExpandedItem(
                  title: "Rank",
                  label: "1",
                ),
                Divider(
                  color: Colors.white.withOpacity(0.5),
                  thickness: 1,
                ),
                const ExpandedItem(
                  title: "Tasks",
                  label: "100",
                ),
              ],
            ),
          ),
          mediumSpacer(),
          Padding(
            padding: const EdgeInsets.only(left: SizeManager.regular),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgIcon(
                  TaskTypeConverter.convertToSVGIcon(taskType: community.role),
                  size: IconSizeManager.small * 1.5,
                  color: Colors.white,
                ),
                regularSpacer(),
                Text(
                  TaskTypeConverter.convertToString(
                      taskType: widget.community.role),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.quicksand(
                      color: ColorManager.primaryDark,
                      fontSize: FontSizeManager.regular,
                      fontWeight: FontWeightManager.semibold),
                )
              ],
            ),
          ),
          regularSpacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: SizeManager.regular),
            child: Text(
              widget.community.about,
              textAlign: TextAlign.left,
              style: GoogleFonts.quicksand(
                  color: ColorManager.primaryDark,
                  fontSize: FontSizeManager.regular,
                  fontWeight: FontWeightManager.medium),
            ),
          ),
          mediumSpacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: SizeManager.regular),
            width: double.maxFinite,
            child: Row(
              children: [
                ActionButton(
                    label: "Donate",
                    onPressed: () {},
                    accent: community.accentColor),
                mediumSpacer(),
                ActionButton(
                  label: "Join",
                  onPressed: () {},
                  accent: community.accentColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ExpandedItem extends StatelessWidget {
  final String label, title;
  const ExpandedItem({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontSize: FontSizeManager.medium * 1.2,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            regularSpacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                color: Colors.white.withOpacity(0.9),
                fontSize: FontSizeManager.small,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ],
        ));
  }
}

class ActionButton extends StatefulWidget {
  final Color accent;
  final String label;
  final void Function() onPressed;
  const ActionButton(
      {super.key,
      required this.accent,
      required this.label,
      required this.onPressed});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: InkWell(
          onTap: widget.onPressed,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
                horizontal: SizeManager.regular * 1.1,
                vertical: SizeManager.regular * 1.3),
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              borderRadius: BorderRadius.circular(SizeManager.large),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.label,
              style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSizeManager.regular),
            ),
          ),
        ),
      ),
    );
  }
}
