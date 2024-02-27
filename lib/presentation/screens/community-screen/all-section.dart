import 'package:aquae_florentis/presentation/screens/community-screen/closest-communities.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';

import 'top-communities-section.dart';

class AllSection extends StatefulWidget {
  const AllSection({super.key});

  @override
  State<AllSection> createState() => _AllSectionState();
}

class _AllSectionState extends State<AllSection> {
  @override
  void setState(VoidCallback fn) {
    if(!mounted){
      return;
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopCommunitiesSection(),
        mediumSpacer(),
        const ClosestCommunitiesSection(),
        mediumSpacer(),
        const ClosestCommunitiesSection()
      ],
    );
  }
}
