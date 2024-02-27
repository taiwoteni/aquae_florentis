import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/color-manager.dart';
import '../resources/font-manager.dart';
import '../resources/value-manager.dart';
import 'text-input-field.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(
    this.hint, {
    super.key,
    this.textFieldStyle = TextFieldStyle.normal,
    this.isExpanded = true,
    this.items = const [],
    this.prefixSvg,
    this.icon = Icons.arrow_drop_down_rounded,
    this.backgroundColor,
    required this.prefixIcon,
    required this.value,
    required this.onChanged,
  });
  final TextFieldStyle textFieldStyle;
  final Color? backgroundColor;
  final String? prefixSvg;
  final bool isExpanded;
  final void Function(dynamic value)? onChanged;
  final String hint;
  final List<dynamic> items;
  final String value;
  final IconData? icon, prefixIcon;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isFormStyle = widget.textFieldStyle == TextFieldStyle.form;
    final TextStyle hintStyle = GoogleFonts.quicksand(
        fontSize: FontSizeManager.medium,
        color: ColorManager.secondary,
        fontWeight: FontWeightManager.medium);
    return Container(
      padding: const EdgeInsets.only(
          right: SizeManager.medium, left: SizeManager.medium * 0.7),
      decoration: BoxDecoration(
          color: ColorManager.tertiary,
          border: Border.all(
              color: ColorManager.accentColor,
              width: 2,
              style: isFormStyle ? BorderStyle.solid : BorderStyle.none),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          widget.prefixSvg != null?SvgIcon(
            widget.prefixSvg!,
            color: ColorManager.primaryColor,
            size: 24,
          ):
          Icon(
            widget.prefixIcon,
            color: ColorManager.primaryColor,
            size: 24,
          ),
          regularSpacer(),
          Expanded(
            child: DropdownButton(
              value: widget.value != "" ? widget.value : null,
              style: hintStyle.copyWith(
                  color: ColorManager.primary,
                  fontWeight: FontWeightManager.bold),
              items: widget.items
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: hintStyle.copyWith(
                          color: ColorManager.primary,
                        ),
                      )))
                  .toList(),
              onChanged: widget.onChanged,
              isExpanded: widget.isExpanded,
              elevation: 2,
              autofocus: false,
              borderRadius: BorderRadius.circular(20),
              underline: const SizedBox(
                width: 0,
                height: 0,
              ),
              focusColor: Colors.transparent,
              hint: Text(widget.hint, style: hintStyle),
              padding: EdgeInsets.zero,
              icon: Icon(widget.icon, color: ColorManager.primaryColor),
              iconSize: 20,
              dropdownColor: widget.backgroundColor ?? ColorManager.background,
            ),
          ),
        ],
      ),
    );
  }
}
