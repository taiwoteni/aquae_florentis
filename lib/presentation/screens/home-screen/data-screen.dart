import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DataScreen extends ConsumerStatefulWidget {
  const DataScreen({super.key});

  @override
  ConsumerState<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends ConsumerState<DataScreen> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeManager.medium * 1.2,
                vertical: SizeManager.regular),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    isMobile ? SizeManager.regular * 1.2 : SizeManager.large),
                color: ColorManager.primaryDark,
                boxShadow: [
                  kElevationToShadow[2]![1],
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderText(
                      "Task Analytics",
                      headerTextStyle: HeaderTextStyle.subheader,
                      color: ColorManager.primary,
                      fontSize: 16,
                    ),
                    const Spacer(),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                    smallSpacer(),
                    Text(
                      "completed",
                      style: GoogleFonts.ubuntu(
                          fontSize: FontSizeManager.small,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.secondary),
                    ),
                    regularSpacer(),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                    ),
                    smallSpacer(),
                    Text(
                      "pending",
                      style: GoogleFonts.ubuntu(
                          fontSize: FontSizeManager.small,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.secondary),
                    ),
                  ],
                ),
                mediumSpacer(),
                const SizedBox(
                  height: 150,
                  child: Placeholder(),
                ),
              ],
            ),
          ),
        ),
        if (!isMobile) Expanded(flex: 2, child: Container())
      ],
    );
  }
}

class ChartSplineData {
  final String day;
  final double tasks;
  const ChartSplineData({required this.day, required this.tasks});
}
