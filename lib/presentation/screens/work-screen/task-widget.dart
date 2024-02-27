// ignore_for_file: unused_element
import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/domain/models/task-model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/dot-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
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
      child: Column(children: [
        _TaskHeader(task: widget.task),
        _TaskBody(task: widget.task,),
        _TaskFooter(task: widget.task,),
      ]),
    );
  }
}

class _TaskHeader extends StatelessWidget {
  final Task task;
  const _TaskHeader({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeManager.medium, vertical: 0),
      leading: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: task.taskColor.withOpacity(0.3)),
        child: SvgIcon(
          TaskTypeConverter.convertToSVGIcon(taskType: task.taskType),
          size: IconSizeManager.regular * 1.2,
          color: TaskTypeConverter.convertToColor(taskType: task.taskType),
        ),
      ),
      title: Text(
        TaskTypeConverter.convertToString(taskType: task.taskType),
        style: GoogleFonts.quicksand(
            fontSize: FontSizeManager.medium * 0.8,
            fontWeight: FontWeightManager.semibold,
            color: ColorManager.primary),
      ),
      subtitle: Row(
        children: [
          const Icon(
            CupertinoIcons.location_solid,
            color: Colors.blue,
            size: IconSizeManager.small,
          ),
          smallSpacer(),
          smallSpacer(),
          Text("Detroit",
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
      // trailing: Icon(
      //   CupertinoIcons.ellipsis_vertical,
      //   color: ColorManager.secondary,
      //   size: IconSizeManager.regular,
      // ),
    );
  }
}

class _TaskBody extends StatefulWidget {
  final Task task;
  const _TaskBody({super.key, required this.task});

  @override
  State<_TaskBody> createState() => __TaskBodyState();
}

class __TaskBodyState extends State<_TaskBody> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/dummy1.jpg",
      width: double.maxFinite,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}

class _TaskFooter extends StatefulWidget {
  final Task task;
  const _TaskFooter({super.key, required this.task});

  @override
  State<_TaskFooter> createState() => __TaskFooterState();
}

class __TaskFooterState extends State<_TaskFooter> {
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
          regularSpacer(),
          Row(children: [
            Text("Review : ",
                style: defaultSpanStyle.copyWith(
                    fontWeight: FontWeightManager.semibold)),
            smallSpacer(),
            RatingBar.builder(
              ignoreGestures: true,
              allowHalfRating: true,
              initialRating: widget.task.review,
              itemCount: 5,
              glowColor: widget.task.taskColor,
              unratedColor: widget.task.taskColor.withOpacity(0.3),
              itemSize: IconSizeManager.small,
              itemBuilder: (context, index) {
                return Icon(CupertinoIcons.star_fill,
                    color: widget.task.taskColor, size: IconSizeManager.small);
              },
              onRatingUpdate: (value) {},
            ),
          ]),
          regularSpacer(),
          RichText(
            text: TextSpan(style: defaultSpanStyle, children: [
              TextSpan(
                  text: "Remark : ",
                  style: defaultSpanStyle.copyWith(
                      fontWeight: FontWeightManager.semibold)),
              TextSpan(
                  text: widget.task.remark)
            ]),
          ),
        ],
      ),
    );
  }
}
