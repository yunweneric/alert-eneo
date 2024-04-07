// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:eneo_fails/shared/utils/language_util.dart';
// import 'package:eneo_fails/shared/utils/sizing.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:lottie/lottie.dart';

// class AppModal {
//   static baseAlert({
//     required BuildContext context,
//     Widget? title,
//     Widget? content,
//     EdgeInsets? insetPadding,
//     EdgeInsets? titlePadding,
//     EdgeInsets? actionsPadding,
//     EdgeInsets? contentPadding,
//     List<Widget>? actions,
//   }) {
//     return showGeneralDialog(
//       context: context,
//       pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => Container(),
//       transitionBuilder: (context, a1, a2, child) {
//         var curve = Curves.easeInOutCirc.transform(a1.value);
//         return Transform.scale(
//           scale: curve,
//           child: AnimatedOpacity(
//             opacity: a1.value,
//             duration: Duration(milliseconds: 200),
//             child: AlertDialog(
//               backgroundColor: Theme.of(context).cardColor,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
//               title: title,
//               content: content,
//               contentPadding: contentPadding,
//               actionsAlignment: MainAxisAlignment.center,
//               insetPadding: insetPadding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
//               titlePadding: titlePadding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
//               actionsPadding: actionsPadding ?? EdgeInsets.only(bottom: 40.h),
//               actions: actions,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static showBaseAlert({
//     required BuildContext context,
//     required Widget body,
//     bool? dismissOnBackKeyPress,
//     bool? dismissOnTouchOutside,
//   }) {
//     return AwesomeDialog(
//       context: context,
//       btnOkColor: Theme.of(context).primaryColor,
//       dialogType: DialogType.noHeader,
//       animType: AnimType.scale,
//       body: body,
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       dismissOnBackKeyPress: dismissOnBackKeyPress ?? true,
//       dismissOnTouchOutside: dismissOnTouchOutside ?? true,
//     )..show();
//   }

//   static showErrorAlert({
//     required BuildContext context,
//     required String title,
//     required String desc,
//     VoidCallback? onOkay,
//     VoidCallback? onCancel,
//     bool? isError,
//     bool? animate,
//     String? okText,
//     String? cancelText,
//     bool? dismissOnBackKeyPress,
//     bool? dismissOnTouchOutside,
//   }) {
//     return AwesomeDialog(
//       dismissOnBackKeyPress: dismissOnBackKeyPress ?? true,
//       dismissOnTouchOutside: dismissOnTouchOutside ?? true,
//       context: context,
//       dialogType: DialogType.noHeader,
//       btnOkColor: Theme.of(context).primaryColor,
//       btnOkText: okText ?? "Ok",
//       btnCancelText: cancelText ?? LangUtil.trans('global.cancel'),
//       titleTextStyle: Theme.of(context).textTheme.displayMedium,
//       descTextStyle: Theme.of(context).textTheme.bodySmall,
//       btnCancelOnPress: onCancel,
//       padding: animate == true ? EdgeInsets.symmetric(horizontal: 20.w) : EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
//       btnOkOnPress: onOkay,
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               child: Column(
//                 children: [
//                   Lottie.asset(AnimationAsset.error, width: 120.h),
//                   kh10Spacer(),
//                   Text(title, style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
//                   kh10Spacer(),
//                   Text(desc, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
//                   kh20Spacer()
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     )..show();
//   }

//   static showInfoAlert({
//     required BuildContext context,
//     required String title,
//     required String desc,
//     required VoidCallback btnOkOnPress,
//     VoidCallback? onCancel,
//     bool? dismissOnBackKeyPress,
//     bool? dismissOnTouchOutside,
//     String? okText,
//     String? cancelText,
//     void Function(DismissType)? onDismissCallback,
//   }) {
//     return AwesomeDialog(
//       context: context,
//       dialogType: DialogType.noHeader,
//       animType: AnimType.scale,
//       title: title.tr(),
//       desc: desc.tr(),
//       btnOkText: okText,
//       btnOkColor: Theme.of(context).primaryColor,
//       btnCancelText: cancelText,
//       onDismissCallback: onDismissCallback,
//       dismissOnBackKeyPress: dismissOnBackKeyPress ?? true,
//       dismissOnTouchOutside: dismissOnTouchOutside ?? true,
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//       btnOkOnPress: btnOkOnPress,
//       btnCancelOnPress: onCancel,
//     )..show();
//   }

//   static showWarningAlert({
//     required BuildContext context,
//     required String title,
//     required String desc,
//     VoidCallback? onOkay,
//     VoidCallback? onCancel,
//     bool? isError,
//     bool? animate,
//   }) {
//     return AwesomeDialog(
//       context: context,
//       dialogType: animate == true ? DialogType.warning : DialogType.noHeader,
//       animType: animate == true ? AnimType.scale : AnimType.topSlide,
//       title: title.tr(),
//       btnOkText: "Ok",
//       btnCancelText: LangUtil.trans('global.cancel'),
//       btnCancelOnPress: onCancel,
//       btnOkColor: Theme.of(context).primaryColor,
//       btnCancelColor: Theme.of(context).colorScheme.error,
//       desc: desc.tr(),
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//       btnOkOnPress: onOkay,
//     )..show();
//   }

//   static showSuccessAlert({
//     required BuildContext context,
//     required String title,
//     required String description,
//     bool? canPop = false,
//     bool dismissOnTouchOutside = true,
//     bool dismissOnBackKeyPress = true,
//     void Function(DismissType)? onDismissCallback,
//     String? okText,
//     String? cancelText,
//     VoidCallback? onOkay,
//     VoidCallback? onCancel,
//   }) {
//     AwesomeDialog alert = AwesomeDialog(
//       onDismissCallback: onDismissCallback,
//       context: context,
//       dismissOnTouchOutside: dismissOnTouchOutside,
//       dismissOnBackKeyPress: dismissOnBackKeyPress,
//       dialogType: DialogType.noHeader,
//       btnOkText: okText,
//       btnCancelText: cancelText,
//       btnCancelOnPress: onCancel,
//       btnOkOnPress: onOkay,
//       btnOkColor: Theme.of(context).primaryColor,
//       animType: AnimType.scale,
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               child: Column(
//                 children: [
//                   SvgPicture.asset(SvgAsset.success_confetti),
//                   kh10Spacer(),
//                   Text(title, style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
//                   kh10Spacer(),
//                   Text(description, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
//                   kh20Spacer()
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//     );
//     alert.show();
//     if (canPop == true) {
//       Future.delayed(Duration(seconds: 2), () => alert.dismiss());
//     }
//   }

//   static showCompleteKycAlert(context, onTap) {
//     return AppModal.baseAlert(
//       context: context,
//       insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
//       actionsPadding: EdgeInsets.symmetric(horizontal: 20.w) + EdgeInsets.only(bottom: 30.h),
//       actions: [
//         submitButton(
//             context: context,
//             onPressed: () {
//               Navigator.pop(context);
//               onTap();
//             },
//             text: LangUtil.trans('global.complete_kyc')),
//       ],
//       content: Container(
//         height: 300.h,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SvgPicture.asset(SvgAsset.welcome),
//               kh20Spacer(),
//               Text(LangUtil.trans('global.complete_kyc'), textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium),
//               kh10Spacer(),
//               Text(
//                 LangUtil.trans('global.complete_kyc_desc'),
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static showSuspendAccountAlert(context) {
//     return AppModal.baseAlert(
//       context: context,
//       insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
//       actionsPadding: EdgeInsets.symmetric(horizontal: 20.w) + EdgeInsets.only(bottom: 30.h),
//       actions: [
//         submitButton(
//           context: context,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           text: LangUtil.trans('contact_admin.contact_the_admin'),
//         ),
//       ],
//       content: Container(
//         height: 250.h,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(AppIcons.warning_big),
//             kh10Spacer(),
//             Text(
//               LangUtil.trans('contact_admin.suspend_account'),
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
