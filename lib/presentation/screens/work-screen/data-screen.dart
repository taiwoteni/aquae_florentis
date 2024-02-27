import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/labeled-progressbar.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';

class WorkDataScreen extends StatefulWidget {
  const WorkDataScreen({super.key});

  @override
  State<WorkDataScreen> createState() => _WorkDataScreenState();
}

class _WorkDataScreenState extends State<WorkDataScreen> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
          horizontal: SizeManager.medium * 1.2, vertical: SizeManager.regular),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              isMobile ? SizeManager.regular * 1.2 : SizeManager.large),
          color: ColorManager.primaryDark,
          boxShadow: [
            kElevationToShadow[2]![1],
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText(
            "Task Analytics",
            headerTextStyle: HeaderTextStyle.subheader,
            color: ColorManager.primary,
            fontSize: 16,
          ),
          mediumSpacer(),
          smallSpacer(),
          const Row(
            children: [
              Expanded(
                child: LabelledProgressBar(
                  progress: 80,
                  label: "80",
                  max: 100,
                  progressColor: Colors.purple,
                  title: "Received",
                ),
              ),
              Expanded(
                child: LabelledProgressBar(
                  progress: 70,
                  label: "70",
                  progressColor: Colors.blue,
                  max: 100,
                  title: "Completed",
                ),
              ),
              Expanded(
                child: LabelledProgressBar(
                  progress: 30,
                  progressColor: Colors.orange,
                  label: "20",
                  max: 100,
                  title: "Pending",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
