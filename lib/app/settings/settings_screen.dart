import 'package:eneo_fails/routes/route_names.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String year = DateTime.now().year.toString();
  PackageInfo? packageInfo;
  initState() {
    getAppInfo();
    super.initState();
  }

  getAppInfo() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = _packageInfo;
    });
    print(packageInfo?.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          height: kHeight(context),
          width: kWidth(context),
          padding: kAppPadding(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kh20Spacer(),
              Text(LangUtil.trans("settings.about_app"),
                  style: Theme.of(context).textTheme.displayMedium),
              kh10Spacer(),
              Text(
                LangUtil.trans("settings.about_desc"),
                textAlign: TextAlign.center,
              ),
              kh20Spacer(),
              Card(
                child: ListTile(
                  onTap: () =>
                      Share.share(LangUtil.trans("settings.share_desc")),
                  leading: Icon(Icons.share),
                  contentPadding: kPadding(20.w, 0.h),
                  title: Text(LangUtil.trans("settings.share_app"),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              kh10Spacer(),
              Card(
                child: ListTile(
                  onTap: () => context.push(AppRoutes.donation),
                  leading:
                      Icon(Icons.favorite, color: EneoFailsColor.kDangerLight),
                  contentPadding: kPadding(20.w, 0.h),
                  title: Text(LangUtil.trans("settings.donate"),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              kh10Spacer(),
              Padding(
                padding: kph(10.w),
                child: Text(
                  LangUtil.trans("settings.donate_desc"),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              kh20Spacer(),
              Card(
                child: ListTile(
                  title: Text(LangUtil.trans("settings.disclaimer")),
                  subtitle: Text(
                    LangUtil.trans("settings.disclaimer_desc"),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              // Spacer(),
              kh20Spacer(),
              Text("©${year} Eneo Alert",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontStyle: FontStyle.italic)),
              if (packageInfo != null)
                Text(packageInfo!.version,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
}
