import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/home-screen/data-screen.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/loading-screen.dart';
import 'package:aquae_florentis/presentation/widgets/page-header.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'post-widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isLoading = false;
  Community? userCommunity;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      setState(() {
        userCommunity = ref.watch(communityProvider);
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
    final isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: ColorManager.tertiary,
      body: SingleChildScrollView(
        child: Container(
          width: isMobile ? null : double.maxFinite,
          height: !isLoading
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
          child: isLoading
              ? const LoadingScreen()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageHeader(),
                    extraLargeSpacer(),
                    const DataScreen(),
                    mediumSpacer(),
                    ...List.generate(
                        5,
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
                                        const PostWidget(),
                                        largeSpacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                if (!isMobile)
                                  Expanded(flex: 2, child: Container())
                              ],
                            ))
                  ],
                ),
        ),
      ),
      floatingActionButton: userCommunity != null
          ? Padding(
              padding: !Responsive.isMobile(context)
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.only(
                      bottom: ValuesManager.bottomBarHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {},
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

  Future<void> initialize() async {
    // ...Initialize all posts.
    // ...Handle Restriction...
    // ...Initialize Graph
  }
}
