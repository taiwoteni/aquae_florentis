import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextFieldStyle { form, normal }

class InputTextField extends StatefulWidget {
  final TextFieldStyle textFieldStyle;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final String? prefixSvg;
  final int maxLines;
  final BorderRadius outlineRadius;
  final TextInputType textInputType;
  final String hint;
  final void Function(String)? onChanged;
  InputTextField({
    super.key,
    required this.hint,
    this.prefixSvg,
    this.isPassword = false,
    this.maxLines = 1,
    this.controller,
    this.prefixIcon,
    this.textFieldStyle = TextFieldStyle.normal,
    this.textInputType = TextInputType.name,
    this.onChanged,
  }) : outlineRadius = BorderRadius.circular(20);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool obscure = false;
  @override
  void initState() {
    obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormStyle = widget.textFieldStyle == TextFieldStyle.form;
    final TextStyle hinStyle = GoogleFonts.quicksand(
        fontSize: FontSizeManager.medium,
        color: ColorManager.secondary,
        fontWeight: FontWeightManager.medium);
    return TextFormField(
      controller: widget.controller,
      cursorColor: ColorManager.primaryColor,
      cursorRadius: const Radius.circular(10),
      cursorWidth: 2.4,
      maxLines: widget.maxLines,
      style: hinStyle.copyWith(
        color: ColorManager.primary,
      ),
      obscureText: obscure,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: widget.prefixIcon == null
              ? widget.prefixSvg == null
                  ? null
                  : SvgIcon(widget.prefixSvg!,
                      size: 21,
                      fit: BoxFit.contain,
                      color: ColorManager.primaryColor)
              : Icon(widget.prefixIcon,
                  size: 21, color: ColorManager.primaryColor),
          suffixIcon: widget.isPassword == false
              ? null
              : IconButton(
                  onPressed: () => setState(() => obscure = !obscure),
                  icon: Icon(
                      !obscure
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill,
                      size: 21,
                      color: ColorManager.secondary)),
          filled: true,
          fillColor: ColorManager.tertiary,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: SizeManager.medium, vertical: SizeManager.small),
          labelText: !isFormStyle ? null : widget.hint,
          hintText: isFormStyle ? null : widget.hint,
          hintStyle: hinStyle,
          labelStyle: hinStyle,
          floatingLabelBehavior: !isFormStyle
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
              borderRadius: widget.outlineRadius,
              borderSide: isFormStyle
                  ? BorderSide(color: ColorManager.accentColor, width: 2)
                  : BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: widget.outlineRadius,
              borderSide: isFormStyle
                  ? BorderSide(color: ColorManager.accentColor, width: 2)
                  : BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: widget.outlineRadius,
              borderSide: isFormStyle
                  ? BorderSide(color: ColorManager.accentColor, width: 2)
                  : BorderSide.none)),
    );
  }
}
