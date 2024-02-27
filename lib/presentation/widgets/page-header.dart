import 'package:aquae_florentis/presentation/providers/navigation-provider.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'header-text.dart';
import 'profile-bar.dart';

class PageHeader extends ConsumerStatefulWidget {
  final String? text;
  const PageHeader({
    this.text,
    super.key,
  });

  @override
  ConsumerState<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends ConsumerState<PageHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        mediumSpacer(),
        HeaderText(
          widget.text ?? navigationItems[ref.watch(navigationProvider)].label,
          fontSize: Responsive.isMobile(context)
              ? FontSizeManager.large
              : FontSizeManager.extralarge,
        ),
        const Spacer(),
        // if (navigationItems[ref.watch(navigationProvider)]
        //         .label
        //         .toLowerCase() ==
        //     "home")
        ProfileBar(
          user: ref.watch(UserProvider.userProvider)!,
        )
      ],
    );
  }
}
