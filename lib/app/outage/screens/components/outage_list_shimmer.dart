import 'package:eneo_fails/app/outage/screens/components/outage_shimmer_card.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';

class OutageListShimmer extends StatelessWidget {
  const OutageListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, i) {
        return Padding(
          padding: kAppPadding(),
          child: Column(
            children: [
              OutageShimmerCard(),
              kh10Spacer(),
            ],
          ),
        );
      },
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
