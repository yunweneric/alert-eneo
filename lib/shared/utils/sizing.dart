import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

EdgeInsetsGeometry kAppPading() => EdgeInsets.symmetric(horizontal: 20.w);
EdgeInsetsGeometry kph(double size) => EdgeInsets.symmetric(horizontal: size);

EdgeInsetsGeometry kpadding(double width, double height) => EdgeInsets.symmetric(horizontal: width, vertical: height);

EdgeInsetsGeometry kpv(double size) => EdgeInsets.symmetric(vertical: size);

double kwidth(context) => MediaQuery.of(context).size.width;

double kheight(context) => MediaQuery.of(context).size.height;

Widget kh20Spacer() => SizedBox(height: 20.h);
Widget kh10Spacer() => SizedBox(height: 10.h);

Widget khSpacer(double height) => SizedBox(height: height);

Widget kwSpacer(double width) => SizedBox(width: width);

radiusVal(double val) => BorderRadius.circular(val);
radiusSm() => BorderRadius.circular(8.r);
radiusM() => BorderRadius.circular(10.r);
radiusL() => BorderRadius.circular(20.r);
radiusXl() => BorderRadius.circular(25.r);
radiusXxl() => BorderRadius.circular(30.r);

InputDecoration authInputDecoration({required String hintText, required BuildContext context, label, prefixIcon, suffix}) {
  return InputDecoration(
    hintText: hintText,
    labelText: label ?? hintText,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 0.0),
    border: mainBorder(),
    focusedBorder: mainfocusBorder(),
    errorBorder: errorBorder(),
    focusedErrorBorder: errorBorder(),
    hintStyle: Theme.of(context).textTheme.bodyMedium,

    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 0),
      child: prefixIcon,
    ),
    // suffix: suffix,
    // suffixText: suffix,
    // suffixStyle: TextStyle(color: kPBlueColor, fontSize: 14.sp),
  );
}

OutlineInputBorder mainBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: radiusM(),
  );
}

OutlineInputBorder mainfocusBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: radiusM(),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: radiusM(),
  );
}
