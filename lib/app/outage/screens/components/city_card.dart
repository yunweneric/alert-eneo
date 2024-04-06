import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CityOutageCard extends StatelessWidget {
  final EneoOutageModel outage;
  final double offset;
  final VoidCallback onTap;

  const CityOutageCard({
    Key? key,
    required this.outage,
    required this.offset,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: kph(10.w),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              // child: coverImage(
              //   url: outage.cityImage,
              //   context: context,
              //   height: kheight(context),
              //   alignment: Alignment(-offset.abs(), 0),
              // ),
              child: Image.asset(
                ImageAssets.outage1,
                height: kheight(context),
                fit: BoxFit.cover,
                width: kwidth(context),
                // alignment: Alignment(-offset.abs(), 0),
              ),
            ),
            Positioned(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.centerEnd,
                      // colors: [
                      //   Colors.black.withOpacity(0.4),
                      //   outage.status == true ? EneoFailsColor.primaryColor.withOpacity(0.9) : EneoFailsColor.kSuccess.withOpacity(0.9),
                      // ],

                      colors: [Colors.black.withOpacity(0.4), EneoFailsColor.primaryColor.withOpacity(0.9)],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // alignment: Alignment.bottomLeft,
              child: CardContent(outage: outage),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final EneoOutageModel outage;

  const CardContent({Key? key, required this.outage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kpadding(20.w, 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (outage.region != null)
            if (outage.region!.trim().isNotEmpty)
              Text(
                "Region - ${outage.region}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: EneoFailsColor.kWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          if (outage.ville != null)
            if (outage.ville!.trim().isNotEmpty)
              Text(
                "City - ${outage.ville}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: EneoFailsColor.kWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          if (outage.quartier != null)
            if (outage.quartier!.trim().isNotEmpty)
              Text(
                "Quartar - ${outage.quartier}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: EneoFailsColor.kWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          khSpacer(10.h),
          Text(
            outage.observations ?? "--",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: EneoFailsColor.kWhite),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
