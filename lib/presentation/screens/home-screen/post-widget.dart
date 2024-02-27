import 'dart:developer';

import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/dot-widget.dart';
import 'package:aquae_florentis/presentation/widgets/profile-bar.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:aquae_florentis/presentation/widgets/ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return Container(
      width: isMobile
          ? null
          : isTablet
              ? MediaQuery.of(context).size.width * 0.45
              : MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
          color: ColorManager.background,
          borderRadius: BorderRadius.circular(
              isMobile ? SizeManager.regular * 1.2 : SizeManager.large),
          boxShadow: [
            kElevationToShadow[2]![1],
          ]),
      child: const Column(children: [
        _PostHeader(),
        _PostBody(),
        _PostFooter(),
      ]),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeManager.medium, vertical: 0),
      leading: Consumer(
        builder: (context, ref, child) => ProfileIcon(
            ref.watch(UserProvider.userProvider)!.profile,
            size: 40),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Taiwo Teninlanimi",
            style: GoogleFonts.quicksand(
                fontSize: FontSizeManager.medium * 0.8,
                fontWeight: FontWeightManager.semibold,
                color: ColorManager.primary),
          ),
          smallSpacer(),
          const SvgIcon(
            "verified-fill",
            size: IconSizeManager.regular * 0.8,
            color: Colors.blue,
          )
        ],
      ),
      subtitle: Row(
        children: [
          const SvgIcon(
            "group-fill",
            color: Colors.blue,
            size: IconSizeManager.small,
          ),
          smallSpacer(),
          smallSpacer(),
          Text("Kairos",
              style: GoogleFonts.quicksand(
                  fontSize: FontSizeManager.small * 0.95,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.secondary)),
          regularSpacer(),
          const DotWidget(),
          regularSpacer(),
          Text("5h",
              style: GoogleFonts.quicksand(
                  fontSize: FontSizeManager.small * 0.95,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.secondary)),
        ],
      ),
      trailing: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: ColorManager.secondary,
        size: IconSizeManager.regular,
      ),
    );
  }
}

class _PostBody extends ConsumerStatefulWidget {
  const _PostBody({super.key});

  @override
  ConsumerState<_PostBody> createState() => __PageBodyState();
}

class __PageBodyState extends ConsumerState<_PostBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minWidth: double.maxFinite, maxHeight: 300, minHeight: 200),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                ref.watch(UserProvider.userProvider)!.profile,
              ),
              fit: BoxFit.fitWidth)),
    );
  }
}

class _PostFooter extends ConsumerStatefulWidget {
  const _PostFooter({super.key});

  @override
  ConsumerState<_PostFooter> createState() => __PostFooterState();
}

class __PostFooterState extends ConsumerState<_PostFooter> {
  @override
  Widget build(BuildContext context) {
    final defaultSpanStyle = GoogleFonts.quicksand(
        fontWeight: FontWeightManager.regular,
        fontSize: FontSizeManager.regular,
        color: ColorManager.primary);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeManager.medium * 0.8, vertical: SizeManager.regular),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              overlappingIcons([1, 2, 3]),
              smallSpacer(),
              Text(
                "Liked by a b c",
                style: GoogleFonts.quicksand(
                    fontSize: FontSizeManager.regular * 0.85,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.primary),
              )
            ],
          ),
          smallSpacer(),
          RichText(
            text: TextSpan(style: defaultSpanStyle, children: [
              TextSpan(
                  text: "Teninlanimi ",
                  style: defaultSpanStyle.copyWith(
                      fontWeight: FontWeightManager.semibold)),
              const TextSpan(
                  text:
                      "A milestone reached at the Kairos community. A total of 150 Members !!")
            ]),
          ),
          smallSpacer(),
          regularSpacer(),
          actionButtons(),
          regularSpacer(),
        ],
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      children: [
        Expanded(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(SizeManager.large),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeManager.medium, vertical: SizeManager.small),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeManager.large),
                color: Colors.lightBlueAccent.withOpacity(0.2)),
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.3),
              onTap: () => log("message"),
              child: const Icon(
                CupertinoIcons.hand_thumbsup,
                color: Colors.blue,
                size: IconSizeManager.regular * 0.9,
              ),
            ),
          ),
        )),
        regularSpacer(),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeManager.medium, vertical: SizeManager.small),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeManager.large),
              color: Colors.orange.withOpacity(0.2)),
          child: const Icon(
            CupertinoIcons.bubble_middle_bottom,
            color: Colors.orangeAccent,
            size: IconSizeManager.regular * 0.9,
          ),
        )),
        regularSpacer(),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeManager.medium, vertical: SizeManager.small),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeManager.large),
              color: Colors.purple.withOpacity(0.2)),
          child: const Icon(
            Icons.share_outlined,
            color: Colors.purpleAccent,
            size: IconSizeManager.regular * 0.9,
          ),
        ))
      ],
    );
  }

  Widget overlappingIcons(List l) {
    const double imageSize = 20;
    return SizedBox(
      width: l.length * imageSize,
      height: imageSize * 1.5,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          ...List.generate(
              l.length,
              (index) => Positioned(
                  right: index * imageSize * 0.8,
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.background,
                    ),
                    child: CircleImage(
                        image: DecorationImage(
                            image: NetworkImage(
                                ref.watch(UserProvider.userProvider)!.profile),
                            fit: BoxFit.cover),
                        size: imageSize),
                  )))
        ],
      ),
    );
  }
}
