import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/community-widget.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/loading-screen.dart';
import 'package:aquae_florentis/presentation/widgets/search-bar.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/page-header.dart';

class AllCommunities extends ConsumerStatefulWidget {
  const AllCommunities({super.key});

  @override
  ConsumerState<AllCommunities> createState() => _AllCommunitiesState();
}

class _AllCommunitiesState extends ConsumerState<AllCommunities> {
  List<Community> communities = [];
  List<Community> allCommunities = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllCommunities();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: ColorManager.tertiary,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: isMobile ? null : double.maxFinite,
          height: isMobile
              ? allCommunities.isEmpty
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
          child: allCommunities.isEmpty
              ? const LoadingScreen()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const PageHeader(
                    text: "Communities",
                  ),
                  extraLargeSpacer(),
                  SearchBarWidget(
                      controller: controller,
                      label: "search",
                      onChanged: search),
                  mediumSpacer(),
                  ...List.generate(
                      communities.length,
                      (index) => Column(
                            children: [
                              CommunityWidget(community: communities[index]),
                              mediumSpacer()
                            ],
                          ))
                ]),
        ),
      ),
    );
  }

  void search(String string) {
    if (string.trim().isEmpty) {
      setState(() {
        communities = allCommunities;
      });
      return;
    }
    final queriedCommunities = allCommunities.where((community) {
      // Search based on 3 categories...
      // Role
      // location
      // name
      final nameCriteria = community.name
          .toLowerCase()
          .trim()
          .contains(string.toLowerCase().trim());
      final locationCriteria = community.addressFormat
          .toLowerCase()
          .trim()
          .contains(string.toLowerCase().trim());
      final roleCriteria =
          TaskTypeConverter.convertToString(taskType: community.role)
              .toLowerCase()
              .trim()
              .contains(string.toLowerCase().trim());

      return nameCriteria || locationCriteria || roleCriteria;
    }).toList();

    setState(() {
      communities = queriedCommunities;
    });
  }

  Future<void> fetchAllCommunities() async {
    final allCommunities = await AppFireStore.allCommunities();
    setState(() {
      communities = allCommunities;
      this.allCommunities = allCommunities;
    });
  }
}
