import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/group-widget.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ClosestCommunitiesSection extends ConsumerStatefulWidget {
  const ClosestCommunitiesSection({super.key});

  @override
  ConsumerState<ClosestCommunitiesSection> createState() =>
      _ClosestCommunitiesSectionState();
}

class _ClosestCommunitiesSectionState
    extends ConsumerState<ClosestCommunitiesSection> {
  List<Community> communities = [];

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      getAllCommunities();
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
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeManager.medium * 1.2, vertical: SizeManager.regular),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderText(
                "Closest Comms",
                headerTextStyle: HeaderTextStyle.subheader,
                color: ColorManager.primary,
                fontSize: isMobile ? 16 : 19,
              ),
              const Spacer(),
              TextButton(
                  onPressed: null,
                  child: Text(
                    "see all",
                    style: GoogleFonts.quicksand(
                        decoration: TextDecoration.underline,
                        fontSize: isMobile
                            ? FontSizeManager.small * 1.1
                            : FontSizeManager.regular,
                        color: Colors.blue),
                  ))
            ],
          ),
          mediumSpacer(),
          SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                  communities.length,
                  (index) => Padding(
                        padding: EdgeInsets.only(
                            left: index == 0
                                ? 0
                                : isMobile
                                    ? SizeManager.regular
                                    : SizeManager.medium,
                            right: isMobile
                                ? SizeManager.regular
                                : SizeManager.medium),
                        child: GroupWidget(
                          community: communities[index],
                          index: index,
                        ),
                      )),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAllCommunities() async {
    final user = ref.watch(UserProvider.userProvider)!;
    final allComunities = await AppFireStore.allCommunities();
    // We will sort based on the following criterias.
    // Verification
    // Member Size,
    // Proximity (Only for closest)

    // For Proximity
    allComunities.sort((a, b) {
      final bClosest = b.country.toLowerCase() == user.country.toLowerCase()
          ? 1
          : b.state.toLowerCase() == user.state.toLowerCase()
              ? 2
              : b.city.toLowerCase() == user.city.toLowerCase()
                  ? 3
                  : 0;
      final aClosest = a.country.toLowerCase() == user.country.toLowerCase()
          ? 1
          : a.state.toLowerCase() == user.state.toLowerCase()
              ? 2
              : a.city.toLowerCase() == user.city.toLowerCase()
                  ? 3
                  : 0;
      return bClosest.compareTo(aClosest);
    });

    // for verification
    allComunities.sort((a, b) {
      final bVerified = b.verified ? 1 : 0;
      final aVerified = a.verified ? 1 : 0;
      return bVerified.compareTo(aVerified);
    });

    // for member size
    allComunities.sort((a, b) => b.communitySize.compareTo(a.communitySize));
    setState(() {
      communities = allComunities;
    });
  }
}
