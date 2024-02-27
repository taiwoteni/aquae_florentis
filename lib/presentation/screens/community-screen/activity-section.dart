import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/communication-page.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/no-community.dart';
import 'package:aquae_florentis/presentation/widgets/loading-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/community-model.dart';

class ActivitySection extends ConsumerStatefulWidget {
  const ActivitySection({super.key});

  @override
  ConsumerState<ActivitySection> createState() => _ActivitySectionState();
}

class _ActivitySectionState extends ConsumerState<ActivitySection> {
  Community? community;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      setState(() {
        community = ref.read(communityProvider);
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen()
        : community != null
            ? const CommunicationPage()
            : const NoCommunity();
  }
}
