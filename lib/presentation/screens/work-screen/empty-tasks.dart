import 'package:aquae_florentis/presentation/providers/work-provider.dart';
import 'package:aquae_florentis/presentation/widgets/lottie-widget.dart';
import 'package:flutter/material.dart';

class EmptyTasks extends StatefulWidget {
  final WorkPageType workPageType;
  const EmptyTasks({super.key, required this.workPageType});

  @override
  State<EmptyTasks> createState() => _EmptyTasksState();
}

class _EmptyTasksState extends State<EmptyTasks> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: SizedBox(
      width: double.maxFinite,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieIcon(
              "empty-task",
              size: 160,
              repeat: true,
              fit: BoxFit.cover,
            ),
          ]),
    ));
  }
}