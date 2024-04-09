import 'package:eneo_fails/shared/components/base_shimmer.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CityOutageShimmerCard extends StatelessWidget {
  final double offset;

  const CityOutageShimmerCard({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        highlightColor: Theme.of(context).cardColor,
        baseColor: Theme.of(context).primaryColorDark.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: kph(10.w),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: CardContent(title: "", desc: ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String title;
  final String desc;

  const CardContent({Key? key, required this.title, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding(20.w, 30.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 180.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                shimmerItem(8.h, 100.w, 5.r, context),
                khSpacer(20.h),
                shimmerItem(8.h, 150.w, 5.r, context),
                khSpacer(10.h),
                shimmerItem(8.h, 150.w, 5.r, context),
              ],
            ),
          ),
          kwSpacer(30.w),
          shimmerItem(70.w, 70.w, 50.r, context),
        ],
      ),
    );
  }
}
