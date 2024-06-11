import 'package:eneo_fails/shared/components/base_shimmer.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OutageShimmerCard extends StatefulWidget {
  const OutageShimmerCard({super.key});

  @override
  State<OutageShimmerCard> createState() => _OutageShimmerCardState();
}

class _OutageShimmerCardState extends State<OutageShimmerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Shimmer.fromColors(
        highlightColor: Theme.of(context).cardColor,
        baseColor: Theme.of(context).primaryColorDark.withOpacity(0.1),
        child: Padding(
          padding: kPadding(20.w, 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  shimmerItem(8.h, 80.w, 5.r, context),
                  kwSpacer(20.w),
                  Expanded(
                      child: shimmerItem(8.h, kWidth(context), 5.r, context)),
                ],
              ),
              khSpacer(10.h),
              Row(
                children: [
                  shimmerItem(8.h, 80.w, 5.r, context),
                  kwSpacer(20.w),
                  Expanded(
                      child: shimmerItem(8.h, kWidth(context), 5.r, context)),
                ],
              ),
              khSpacer(20.h),
              shimmerItem(8.h, kWidth(context), 5.r, context),
              khSpacer(10.h),
              shimmerItem(8.h, kWidth(context), 5.r, context),
              khSpacer(10.h),
              shimmerItem(8.h, 150.w, 5.r, context),
            ],
          ),
        ),
      ),
    );
  }
}
