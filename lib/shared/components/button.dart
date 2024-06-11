import 'package:easy_localization/easy_localization.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtons {
  static Widget submitButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
    Color? color,
    Color? textColor,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    double? width,
    double? elevation,
    BorderSide? borderSide,
    double? height,
    double? fontSize,
    Widget? icon,
    bool animate = true,
    bool isLoading = false,
    bool isReversed = false,
  }) {
    return SizedBox(
      width: width == null ? kWidth(context) : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? radiusSm(),
              side: borderSide == null ? BorderSide.none : borderSide),
          padding: padding ?? EdgeInsets.symmetric(vertical: 15.h),
          backgroundColor: color ?? Theme.of(context).primaryColor,
          elevation: elevation == null ? 0 : elevation,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? CupertinoActivityIndicator()
            : icon == null
                ? Text(
                    text,
                    style: TextStyle(
                        fontSize: fontSize ?? 14.sp,
                        color: textColor ?? EneoFailsColor.kWhite),
                  ).tr()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isReversed
                        ? [
                            Text(
                              text,
                              style: TextStyle(
                                  fontSize: fontSize ?? 12.w,
                                  color: textColor,
                                  fontWeight: FontWeight.w700),
                            ).tr(),
                            if (text != "") SizedBox(width: 5.w),
                            icon,
                          ]
                        : [
                            icon,
                            if (text != "") SizedBox(width: 8.w),
                            Text(
                              text,
                              style: TextStyle(
                                  fontSize: fontSize ?? 12.w,
                                  color: textColor,
                                  fontWeight: FontWeight.w700),
                            ).tr(),
                          ],
                  ),
      ),
    );
  }
}
