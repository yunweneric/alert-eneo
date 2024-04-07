import 'package:eneo_fails/shared/components/base_shimmer.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OutageListShimmer extends StatefulWidget {
  const OutageListShimmer({super.key});

  @override
  State<OutageListShimmer> createState() => _OutageListShimmerState();
}

class _OutageListShimmerState extends State<OutageListShimmer> {
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
        child: Container(
          padding: kpadding(20.w, 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  shimmerItem(8.h, 80.w, 5.r, context),
                  kwSpacer(20.w),
                  Expanded(
                      child: shimmerItem(8.h, kwidth(context), 5.r, context)),
                ],
              ),
              khSpacer(10.h),
              Row(
                children: [
                  shimmerItem(8.h, 80.w, 5.r, context),
                  kwSpacer(20.w),
                  Expanded(
                      child: shimmerItem(8.h, kwidth(context), 5.r, context)),
                ],
              ),
              khSpacer(20.h),
              shimmerItem(8.h, kwidth(context), 5.r, context),
              khSpacer(10.h),
              shimmerItem(8.h, kwidth(context), 5.r, context),
              khSpacer(10.h),
              shimmerItem(8.h, 150.w, 5.r, context),
            ],
          ),
        ),
      ),
    );
  }
}
