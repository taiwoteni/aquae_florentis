import 'package:aquae_florentis/app/routes-manager.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/activity-section.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/all-section.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/menu-chip.dart';
import 'package:aquae_florentis/presentation/widgets/page-header.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  ConsumerState<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isActivitySection = ref
        .watch(communityPageProvider)
        .toString()
        .toLowerCase()
        .contains("activity");
    return Scaffold(
      backgroundColor: ColorManager.tertiary,
      body: SingleChildScrollView(
        child: Container(
          width: isMobile ? null : double.maxFinite,
          height: !isActivitySection
              ? null
              : MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top,
          padding: EdgeInsets.only(
            left: isMobile ? SizeManager.medium : SizeManager.extralarge,
            top: SizeManager.large,
            bottom: isMobile
                ? ValuesManager.bottomBarHeight + SizeManager.large
                : SizeManager.large,
            right: isMobile ? SizeManager.medium : SizeManager.extralarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(),
              extraLargeSpacer(),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeManager.medium * 1.2),
                    child: MenuChip(
                      items: [
                        MenuChipItem(
                            onPressed: () => ref
                                .watch(communityPageProvider.notifier)
                                .state = const ActivitySection(),
                            isSelected: ref
                                .watch(communityPageProvider)
                                .toString()
                                .toLowerCase()
                                .contains("activity"),
                            label: "Activity"),
                        MenuChipItem(
                            onPressed: () => ref
                                .watch(communityPageProvider.notifier)
                                .state = const AllSection(),
                            isSelected: ref
                                .watch(communityPageProvider)
                                .toString()
                                .toLowerCase()
                                .contains("all"),
                            label: "All")
                      ],
                    ),
                  )),
              ref.watch(communityPageProvider),
            ],
          ),
        ),
      ),
      floatingActionButton: isActivitySection
          ? Padding(
              padding: !isMobile
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.only(
                      bottom: ValuesManager.bottomBarHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (ref.watch(communityProvider) == null)
                    FloatingActionButton(
                      heroTag: "create-community-tag",
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.createCommunity),
                      backgroundColor: ColorManager.primaryDark,
                      foregroundColor: Colors.blue,
                      mini: true,
                      child: const Icon(
                        CupertinoIcons.add,
                        size: IconSizeManager.small,
                      ),
                    ),
                  if (ref.watch(communityProvider) == null) regularSpacer(),
                  FloatingActionButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.allCommunities),
                    backgroundColor: Colors.blue,
                    child: const SvgIcon(
                      "search",
                      size: IconSizeManager.regular,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
