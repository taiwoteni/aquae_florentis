import 'package:aquae_florentis/presentation/providers/button-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/lottie-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends ConsumerStatefulWidget {
  final String label;
  final void Function()? onTap;
  final BorderRadius? buttonRadius;
  final bool isLoadable;
  final bool expanded;
  final Color? buttonColor;
  Button(
      {super.key,
      required this.label,
      this.expanded = true,
      this.isLoadable = false,
      this.buttonRadius,
      this.buttonColor,
      this.onTap}) {
    if (isLoadable) {
      if (key == null) {
        throw Exception("isLoadable should only be true if a key is given!");
      }
    }
  }

  @override
  ConsumerState<Button> createState() => _ButtonState();
}

class _ButtonState extends ConsumerState<Button> {
  @override
  Widget build(BuildContext context) {
    bool isLoadable = widget.isLoadable;
    bool loading = false;
    if (isLoadable) {
      ButtonProvider(key: widget.key!); //To add this key to button provider
      // Key would be true since isLoadable is true and no error is thrown.
      loading = ButtonProvider.loadingValue(buttonKey: widget.key!, ref: ref);
    }
    return InkWell(
      onTap: !loading ? widget.onTap : null,
      child: Container(
        height: 45,
        width: widget.expanded ? double.maxFinite : null,
        padding: const EdgeInsets.symmetric(horizontal: SizeManager.medium),
        decoration: BoxDecoration(
            color: widget.buttonColor ?? ColorManager.accentColor,
            borderRadius: widget.buttonRadius ?? BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: !loading
            ? Text(
                widget.label,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                    color: ColorManager.background,
                    fontSize: FontSizeManager.medium,
                    fontWeight: FontWeightManager.bold),
              )
            : const LottieIcon("loading",
                repeat: true, color: Colors.white, size: 50),
      ),
    );
  }
}

class NavText extends StatelessWidget {
  const NavText(this.text,
      {super.key, required this.onPressed, this.textColor, this.fontSize = 15});
  final double fontSize;
  final Color? textColor;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: GoogleFonts.quicksand(
            fontSize: fontSize,
            color: textColor ?? ColorManager.accentColor,
            decoration: TextDecoration.underline,
            decorationColor: textColor,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
