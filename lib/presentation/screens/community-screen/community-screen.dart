import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/profile-screen/profile-header.dart';
import 'package:aquae_florentis/presentation/screens/splash-screen/splash-screen.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/loading-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommunityScreen extends StatefulWidget {
  final Community community;
  const CommunityScreen({super.key, required this.community});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final bool isLoading = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(kUiOverlayStyle.copyWith(
        statusBarColor: widget.community.primaryColor,
        statusBarIconBrightness: Brightness.light));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(kUiOverlayStyle);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Scaffold(
        backgroundColor: ColorManager.background,
        body: SingleChildScrollView(
          child: Container(
            width: isMobile ? null : double.maxFinite,
            height: !isLoading
                ? null
                : MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top,
            child: !isLoading
                ? Column(
                    children: [ProfileHeader(community: widget.community)],
                  )
                : const LoadingScreen(),
          ),
        ),
      ),
    );
  }

  void exit() {
    SystemChrome.setSystemUIOverlayStyle(kUiOverlayStyle);
  }
}
