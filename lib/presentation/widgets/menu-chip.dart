import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuChip extends ConsumerStatefulWidget {
  final List<MenuChipItem> items;
  MenuChip({super.key, required this.items});

  @override
  ConsumerState<MenuChip> createState() => _MenuChipState();
}

class _MenuChipState extends ConsumerState<MenuChip> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? 145 : 180,
      height: isMobile ? 35 : 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeManager.small * 1.2),
          border: Border.all(color: Colors.blue)),
      child: Row(
        children: List.generate(widget.items.length, (index) {
          final bool isSelected = widget.items[index].isSelected;
          return Expanded(
              child: Container(
            child: InkWell(
              splashColor: Colors.blue,
              onTap: widget.items[index].onPressed,
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.transparent,
                  ),
                  child: Text(
                    widget.items[index].label,
                    style: GoogleFonts.varelaRound(
                      color: isSelected ? Colors.white : Colors.blue,
                      fontSize: !isMobile
                          ? FontSizeManager.regular * 0.9
                          : FontSizeManager.small * 0.9,
                    ),
                  )),
            ),
          ));
        }),
      ),
    );
  }
}

class MenuChipItem {
  final void Function()? onPressed;
  final String label;
  final bool isSelected;
  MenuChipItem(
      {required this.onPressed, this.isSelected = false, required this.label});
}
