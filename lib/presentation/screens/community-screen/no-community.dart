import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/lottie-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NoCommunity extends ConsumerStatefulWidget {
  final bool emptyCommunity;
  const NoCommunity({super.key, this.emptyCommunity = false});

  @override
  ConsumerState<NoCommunity> createState() => _NoCommunityState();
}

class _NoCommunityState extends ConsumerState<NoCommunity> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LottieIcon(
              "join-community",
              size: 170,
              repeat: true,
              fit: BoxFit.cover,
            ),
            mediumSpacer(),
            Text(
              widget.emptyCommunity? "Join a community\n to access work": "Join a community\nToday.",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                color: ColorManager.primary,
                fontSize:
                    isMobile ? FontSizeManager.medium : FontSizeManager.large,
                fontWeight: FontWeightManager.medium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
