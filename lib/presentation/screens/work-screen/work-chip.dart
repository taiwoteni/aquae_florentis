import 'package:aquae_florentis/presentation/providers/work-provider.dart';
import 'package:aquae_florentis/presentation/widgets/menu-chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkChip extends ConsumerStatefulWidget {
  const WorkChip({super.key});

  @override
  ConsumerState<WorkChip> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<WorkChip> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: MenuChip(
        items: [
          MenuChipItem(
              onPressed: () => ref.read(workTaskTypeProvider.notifier).state =
                  WorkPageType.pending,
              isSelected:
                  ref.watch(workTaskTypeProvider) == WorkPageType.pending,
              label: "Pending"),
          MenuChipItem(
              onPressed: () => ref.read(workTaskTypeProvider.notifier).state =
                  WorkPageType.completed,
              isSelected:
                  ref.watch(workTaskTypeProvider) == WorkPageType.completed,
              label: "Completed")
        ],
      ),
    );
  }
}
