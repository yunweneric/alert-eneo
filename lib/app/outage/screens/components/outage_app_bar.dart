import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_regions/eneo_outage_regions.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/bottom_sheets.dart';
import 'package:eneo_fails/shared/utils/icon_asset.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OutageAppBar extends StatefulWidget {
  final double top;
  final FocusNode focusNode;
  final VoidCallback onTapSearch;
  const OutageAppBar({super.key, required this.top, required this.focusNode, required this.onTapSearch});

  @override
  State<OutageAppBar> createState() => _OutageAppBarState();
}

class _OutageAppBarState extends State<OutageAppBar> {
  final eneoOutageBloc = getIt.get<EneoOutageBloc>();
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: kPadding(20.w, 10.h),
      background: Image.asset(ImageAssets.outage1, fit: BoxFit.fill),
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 700),
        child: widget.top < 200
            ? SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LangUtil.trans("outage.outages"), style: Theme.of(context).textTheme.displayMedium),
                      GestureDetector(
                        onTap: () {
                          widget.onTapSearch();
                          widget.focusNode.requestFocus();
                        },
                        child: Icon(Icons.search, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            : Builder(builder: (context) {
                EneoOutageRegion? selectedRegion = context.read<EneoOutageBloc>().selectedRegion;
                return GestureDetector(
                  onTap: () => AppSheet.showRegionSheet(
                    context: context,
                    outageRegions: context.read<EneoOutageBloc>().eneoOutageRegion,
                    selectedOutageRegions: selectedRegion,
                    onChanged: (region) => eneoOutageBloc.add(SearchEneoOutageByRegionEvent(region: region)),
                  ),
                  child: Container(
                    padding: kPadding(10.w, 8.h),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: radiusM()),
                    child: Row(
                      children: [
                        Expanded(
                          child: selectedRegion == null
                              ? Text(
                                  LangUtil.trans("outage.choose_locality"),
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.sp),
                                )
                              : Row(
                                  children: [
                                    SvgPicture.asset(IconAssets.location_pin, color: Theme.of(context).primaryColorDark, width: 20),
                                    kwSpacer(8.w),
                                    Text(
                                      selectedRegion.name,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                        ),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                );
              }),
      ),
    );
  }
}
