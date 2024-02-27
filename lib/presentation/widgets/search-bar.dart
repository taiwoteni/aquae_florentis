import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatefulWidget {
  final String label;
  final EdgeInsetsGeometry? margin;
  final TextEditingController controller;
  final bool castShadow;
  final bool isDirect;
  final void Function(String value)? onChanged;
  const SearchBarWidget(
      {super.key,
      this.isDirect = true,
      required this.label,
      this.castShadow = true,
      required this.controller,
      this.margin,
      required this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(boxShadow: [
          if (widget.castShadow) kElevationToShadow[2]![1],
        ]),
        child: TextField(
          controller: controller,
          cursorColor: Colors.blue,
          cursorRadius: const Radius.circular(10),
          style: GoogleFonts.quicksand(
              color: ColorManager.primary,
              fontSize: FontSizeManager.medium * 0.8,
              fontWeight: FontWeightManager.medium),
          onChanged: widget.onChanged,
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.medium * 1.5,
                  vertical: SizeManager.small * 0.9),
              fillColor: widget.isDirect
                  ? ColorManager.background
                  : ColorManager.tertiary,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIcon: Icon(
                CupertinoIcons.search,
                color: ColorManager.secondary,
                size: IconSizeManager.regular,
              ),
              hintText: widget.label,
              hintStyle: GoogleFonts.quicksand(
                  fontSize: FontSizeManager.medium * 0.8,
                  color: ColorManager.secondary,
                  fontWeight: FontWeightManager.regular),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
