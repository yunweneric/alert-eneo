import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoOutageCard extends StatelessWidget {
  const NoOutageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kAppPadding(),
      margin: kAppPadding(),
      width: kWidth(context),
      height: kHeight(context) / 2.2,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor, borderRadius: radiusM()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(ImageAssets.no_data,
              width: 200,
              color: Theme.of(context).primaryColor.withOpacity(0.4)),
          kh10Spacer(),
          Text(
            LangUtil.trans("outage.no_outages_planned"),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
