import 'package:aquae_florentis/app/routes-manager.dart';
import 'package:aquae_florentis/domain/models/task-model.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/providers/work-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/no-community.dart';
import 'package:aquae_florentis/presentation/screens/work-screen/work-chip.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/page-header.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data-screen.dart';
import 'empty-tasks.dart';
import 'task-widget.dart';

class WorkPage extends ConsumerStatefulWidget {
  const WorkPage({super.key});

  @override
  ConsumerState<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends ConsumerState<WorkPage> {
  List<Task> pendingTasks = [];
  List<Task> completedTasks = [];
  List<Task> currentTasks = [];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final workPageType = ref.watch(workTaskTypeProvider);
    currentTasks =
        workPageType == WorkPageType.pending ? pendingTasks : completedTasks;
    final bool isEmpty =
        currentTasks.isEmpty || ref.watch(communityProvider) == null;
    return Scaffold(
      backgroundColor: ColorManager.tertiary,
      body: SingleChildScrollView(
        child: Container(
          width: isMobile ? null : double.maxFinite,
          height: isMobile
              ? isEmpty
                  ? MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewPadding.top
                  : null
              : double.maxFinite,
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
            children: ref.watch(communityProvider) == null
                ? [
                    const NoCommunity(
                      emptyCommunity: true,
                    )
                  ]
                : [
                    const PageHeader(),
                    extraLargeSpacer(),
                    const WorkDataScreen(),
                    largeSpacer(),
                    const WorkChip(),
                    mediumSpacer(),
                    HeaderText(
                      workPageType == WorkPageType.pending
                          ? "Pending Tasks"
                          : "Completed Tasks",
                      headerTextStyle: HeaderTextStyle.subheader,
                      color: ColorManager.primary,
                      fontSize: isMobile ? 16 : 19,
                    ),
                    mediumSpacer(),
                    if (currentTasks.isEmpty)
                      EmptyTasks(
                        workPageType: workPageType,
                      ),
                    ...List.generate(
                        // Don't touch the row && expanded widget.
                        // Placed there intentionally for responsiveness
                        currentTasks.length,
                        (index) => Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TaskWidget(task: currentTasks[index]),
                                        largeSpacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                if (!isMobile)
                                  Expanded(flex: 2, child: Container())
                              ],
                            )),
                  ],
          ),
        ),
      ),
      floatingActionButton: ref.watch(communityProvider) != null
          ? Padding(
              padding: !Responsive.isMobile(context)
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.only(
                      bottom: ValuesManager.bottomBarHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.createTask),
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      CupertinoIcons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
