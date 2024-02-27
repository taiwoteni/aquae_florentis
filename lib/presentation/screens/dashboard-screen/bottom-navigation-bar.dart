import 'package:aquae_florentis/presentation/providers/navigation-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(SizeManager.large * 1.5)),
      child: Container(
        height: ValuesManager.bottomBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: SizeManager.medium),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(SizeManager.large * 1.5)),
            boxShadow: kElevationToShadow[3]),
        child: BottomNavigationBar(
            currentIndex: ref.watch(navigationProvider),
            onTap: (value) =>
                ref.watch(navigationProvider.notifier).state = value,
            backgroundColor: Colors.transparent,
            fixedColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: navigationItems.map((navItem) {
              bool isSelected = navigationItems.indexOf(navItem) ==
                  ref.watch(navigationProvider);
              return BottomNavigationBarItem(
                  icon: SvgIcon(
                    isSelected ? "${navItem.icon}-fill" : navItem.icon,
                    color: isSelected ? Colors.blue : ColorManager.secondary,
                    size: isSelected ? 28 : 24,
                  ),
                  label: navItem.label);
            }).toList()),
      ),
    );
  }
}
