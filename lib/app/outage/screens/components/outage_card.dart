import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/shared/components/outage_chip.dart';
import 'package:eneo_fails/shared/utils/icon_asset.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:eneo_fails/shared/utils/util_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OutageCard extends StatelessWidget {
  final EneoOutageModel outage;
  const OutageCard({super.key, required this.outage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kAppPadding(),
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).cardColor,
            dense: true,
            shape: RoundedRectangleBorder(borderRadius: radiusVal(10.r)),
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: radiusVal(5.r)),
                  padding: kPadding(10.w, 10.w),
                  child: SvgPicture.asset(IconAssets.outage_pin, color: Theme.of(context).primaryColorDark),
                ),
                kwSpacer(10.w),
                Expanded(child: Text("${outage.region} ${outage.ville} - ${outage.quartier}")),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kh10Spacer(),
                Text(outage.observations ?? LangUtil.trans("outage.no_observation")),
                kh10Spacer(),
                Row(
                  children: [
                    kh10Spacer(),
                    outageChip(
                      context: context,
                      icon: IconAssets.calendar,
                      title: UtilHelper.formatDate(outage.progDate),
                    ),
                    kwSpacer(10.w),
                    outageChip(
                      context: context,
                      icon: IconAssets.clock,
                      title: "${outage.progHeureDebut ?? ""} - ${outage.progHeureFin ?? ""}",
                    ),
                  ],
                ),
              ],
            ),
          ),
          kh10Spacer()
        ],
      ),
    );
  }
}
