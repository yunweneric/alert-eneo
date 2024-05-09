import 'package:eneo_fails/app/outage/data/models/eneo_outage_regions/eneo_outage_regions.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/log_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AppSheet {
  static baseBottomSheet({required BuildContext context, bool? enableDrag, bool? isDismissible, required Widget child}) {
    return showBarModalBottomSheet(
      // return showModalBottomSheet(
      overlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).cardColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Theme.of(context).cardColor,
      ),
      backgroundColor: Theme.of(context).cardColor,
      context: context,
      barrierColor: EneoFailsColor.kDark.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      ),
      useRootNavigator: false,
      isDismissible: isDismissible ?? true,
      enableDrag: enableDrag ?? true,
    );
  }

  static simpleModal({
    required BuildContext context,
    required double height,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    AlignmentGeometry? alignment,
    bool? isDismissible = true,
    bool? enableDrag,
  }) {
    return baseBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      child: PopScope(
        canPop: isDismissible ?? true,
        onPopInvoked: (didPop) {
          if (didPop)
            Future.delayed(Duration(milliseconds: 400), () {
              return SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
                  systemNavigationBarIconBrightness: Brightness.light,
                  systemNavigationBarDividerColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              );
            });
          logI(didPop);
        },
        child: Container(
          child: child,
          alignment: alignment ?? Alignment.center,
          height: height,
          padding: padding,
          margin: margin,
          // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: decoration,
        ),
      ),
    );
  }

  static showErrorSheet({required BuildContext context, required String desc, required String title, Function? onOkay}) {
    return simpleModal(
      context: context,
      height: 400.h,
      padding: kPadding(20.w, 10.h),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
              size: 90,
            ),
            kh20Spacer(),
            Text(title, style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
            kh20Spacer(),
            Text(desc, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  static showSuccessSheet({required BuildContext context, required String desc, required String title, Function? onOkay}) {
    return simpleModal(
      context: context,
      height: 400.h,
      padding: kPadding(20.w, 10.h),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: EneoFailsColor.kSuccess,
              size: 90,
            ),
            kh20Spacer(),
            Text(title, style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
            kh20Spacer(),
            Text(desc, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  static showRegionSheet({
    required BuildContext context,
    required List<EneoOutageRegion> outageRegions,
    required EneoOutageRegion? selectedOutageRegions,
    required Function(EneoOutageRegion)? onChanged,
  }) {
    return simpleModal(
      context: context,
      height: 400.h,
      padding: kPadding(20.w, 10.h),
      child: Container(
        child: ListView.builder(
          itemCount: outageRegions.length,
          itemBuilder: (c, i) {
            return GestureDetector(
              onTap: () {
                context.pop();
                onChanged!(outageRegions[i]);
              },
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    leading: Text(outageRegions[i].name, style: Theme.of(context).textTheme.displaySmall),
                    trailing: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: outageRegions[i].id == selectedOutageRegions?.id ? Theme.of(context).primaryColor : Theme.of(context).highlightColor,
                          width: 2.w,
                        ),
                      ),
                      height: 20.h,
                      width: 20.h,
                      child: CircleAvatar(
                        radius: 10.r,
                        backgroundColor: outageRegions[i].id == selectedOutageRegions?.id ? Theme.of(context).primaryColor : Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                  khSpacer(5.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
