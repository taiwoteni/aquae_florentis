import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopCommunitiesSection extends StatefulWidget {
  const TopCommunitiesSection({super.key});

  @override
  State<TopCommunitiesSection> createState() => _TopCommunitiesSectionState();
}

class _TopCommunitiesSectionState extends State<TopCommunitiesSection> {
  @override
  void setState(VoidCallback fn) {
    if(!mounted){
      return;
    }
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeManager.medium * 1.2, vertical: SizeManager.regular),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderText(
                "Top Comms",
                headerTextStyle: HeaderTextStyle.subheader,
                color: ColorManager.primary,
                fontSize: isMobile ? 16 : 19,
              ),
              const Spacer(),
              TextButton(
                  onPressed: null,
                  child: Text(
                    "see all",
                    style: GoogleFonts.quicksand(
                        decoration: TextDecoration.underline,
                        fontSize: isMobile
                            ? FontSizeManager.small * 1.1
                            : FontSizeManager.regular,
                        color: Colors.blue),
                  ))
            ],
          ),
          // mediumSpacer(),
          // SingleChildScrollView(
          //   padding: EdgeInsets.zero,
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.max,
          //     children: List.generate(
          //         2,
          //         (index) => Padding(
          //               padding: EdgeInsets.only(
          //                   left: index == 0
          //                       ? 0
          //                       : isMobile
          //                           ? SizeManager.regular
          //                           : SizeManager.medium,
          //                   right: isMobile
          //                       ? SizeManager.regular
          //                       : SizeManager.medium),
          //               child: GroupWidget(
          //                 index: index,
          //                 onlyRight: true,
          //                 isTop: true,
          //               ),
          //             )),
          //   ),
          // ),
        ],
      ),
    );
  }
}
