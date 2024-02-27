// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget{
  double progress;
  double max;
  double height;
  Color? fillColor;
  Color? trackColor;
  ProgressWidget({
    super.key,
    this.height = 2,
    this.progress = 1,
    this.max = 1,
    this.trackColor,
    });


  @override
  State<ProgressWidget> createState()=>_ProgressWidgetState();


}
class _ProgressWidgetState extends State<ProgressWidget>{
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              color: widget.fillColor?? Colors.white,
              backgroundColor: widget.trackColor??Colors.white.withOpacity(0.55),
              minHeight: widget.height,
              value: widget.progress / widget.max,

            ),
          ),
        )
    );
  }
}