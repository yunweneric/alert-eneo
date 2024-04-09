import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/base_shimmer.dart';
import 'package:eneo_fails/shared/data/models/user_outage_model.dart';
import 'package:eneo_fails/shared/utils/icon_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class HomeGreetings extends StatefulWidget {
  const HomeGreetings({super.key});

  @override
  State<HomeGreetings> createState() => _HomeGreetingsState();
}

class _HomeGreetingsState extends State<HomeGreetings> {
  final bool hasElectricity = false;
  bool loading = false;

  EneoOutageBloc eneoOutageBloc = getIt.get<EneoOutageBloc>();

  @override
  void initState() {
    eneoOutageBloc.add(GetOutUserEneoOutageEvent(context));
    super.initState();
  }

  String sayGreetings() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 18) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EneoOutageBloc, EneoOutageState>(
      builder: (context, state) {
        if (state is EneoOutageGetUserLoading) {
          loading = true;
        }
        if (state is EneoOutageGetUserError) {
          loading = false;
        }
        if (state is EneoOutageGetUserLoaded) {
          loading = false;
        }
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: loading
              ? Container(
                  margin: kAppPadding(),
                  padding: kPadding(20.w, 30.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: radiusM(),
                  ),
                  child: Shimmer.fromColors(
                    highlightColor: Theme.of(context).cardColor,
                    baseColor: Theme.of(context).primaryColorDark.withOpacity(0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerItem(5.h, kWidth(context) / 2, 2.r, context),
                        kh20Spacer(),
                        shimmerItem(5.h, kWidth(context), 2.r, context),
                        kh10Spacer(),
                        shimmerItem(5.h, kWidth(context), 2.r, context),
                        kh10Spacer(),
                      ],
                    ),
                  ),
                )
              : Builder(builder: (context) {
                  UserOutage? userOutage = context.read<EneoOutageBloc>().userOutage;
                  return Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Container(
                        margin: kph(20.w),
                        padding: kPadding(20.w, 15.w),
                        width: kWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: radiusM(),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sayGreetings(), style: Theme.of(context).textTheme.displayMedium),
                            kh10Spacer(),
                            Text(
                              userOutage?.hasElectricity == true ? "You seem to have electricity!" : "It seems you are out of electricity. \nNote that this information may not be too accurate",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            kh20Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset(IconAssets.location_pin, color: Theme.of(context).primaryColorDark),
                                kwSpacer(5.w),
                                Text(
                                  userOutage?.userLocation?.name ?? "No location found!",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          context.read<EneoOutageBloc>().userOutage?.hasElectricity == true ? Icons.check_circle : Icons.cancel,
                          size: 200.r,
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                        ),
                      ),
                    ],
                  );
                }),
        );
      },
    );
  }
}
