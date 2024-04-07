import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
          height: kheight(context),
          width: kwidth(context),
          padding: kAppPading(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kh20Spacer(),
              Text("About App",
                  style: Theme.of(context).textTheme.displayMedium),
              kh10Spacer(),
              Text(
                "This app is a tentative solution to the problem of power outages in Cameroon. It is not affiliated with Eneo Cameroon.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              kh20Spacer(),
              Card(
                child: ListTile(
                  leading: Icon(Icons.share),
                  contentPadding: kpadding(20.w, 0.h),
                  title: Text('Share App',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
              kh10Spacer(),
              Card(
                child: ListTile(
                  leading:
                      Icon(Icons.favorite, color: EneoFailsColor.kDangerLight),
                  contentPadding: kpadding(20.w, 0.h),
                  title: Text('Donate to support',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
              Padding(
                padding: kph(10.w),
                child: Text(
                  'Donating to this project helps us build an AI that can better predict power outage in Cameroon.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              kh20Spacer(),
              Card(
                child: ListTile(
                  title: Text('Disclaimer'),
                  subtitle: Text(
                    'The information provided here is provided by the Eneo API and is not guaranteed to be accurate.',
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
