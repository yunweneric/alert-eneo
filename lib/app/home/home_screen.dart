import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/icon_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(
            backgroundColor: activeIndex == 0 ? Theme.of(context).primaryColor : EneoFailsColor.kSuccess,
            child: activeIndex == 0
                ? SvgPicture.asset(
                    IconAssets.flash_off,
                    color: Theme.of(context).primaryColorDark,
                  )
                : SvgPicture.asset(
                    IconAssets.flash,
                    color: Theme.of(context).primaryColorDark,
                  ),
          ),
          kwSpacer(10.w),
          Text("Douala, CMR", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
        ]),
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: activeIndex == 0 ? home(context) : searchHome(context),
          ),
          Positioned(
            bottom: 10,
            left: kwidth(context) / 4,
            right: kwidth(context) / 4,
            child: bottombar(context),
          ),
        ],
      ),
    );
  }

  Material bottombar(BuildContext context) {
    return Material(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: radiusXxl()),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: radiusL(),
          boxShadow: [
            BoxShadow(color: Theme.of(context).highlightColor.withOpacity(0.05), spreadRadius: 1, blurRadius: 20),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => setState(() => activeIndex = 0),
              child: AnimatedScale(
                scale: activeIndex == 0 ? 1.5 : 1.2,
                duration: Duration(milliseconds: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconAssets.home,
                      color: activeIndex == 0 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                    ),
                    khSpacer(2.h),
                    if (activeIndex == 0)
                      Container(
                        width: 20.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: radiusM(),
                          color: activeIndex == 0 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                        ),
                      )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => activeIndex = 1),
              child: AnimatedScale(
                scale: activeIndex == 1 ? 1.5 : 1.2,
                duration: Duration(milliseconds: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconAssets.search,
                      color: activeIndex == 1 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                    ),
                    khSpacer(2.h),
                    if (activeIndex == 1)
                      Container(
                        width: 20.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          color: activeIndex == 1 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                          borderRadius: radiusM(),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container searchHome(BuildContext context) {
    return Container(
      key: ValueKey<int>(activeIndex),
      padding: kAppPading(),
      child: Column(
        children: [
          CupertinoSearchTextField(
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (c, i) {
                return ListTile(
                  minLeadingWidth: 10.w,
                  title: Text("Search Item", style: Theme.of(context).textTheme.bodyMedium),
                  leading: SvgPicture.asset(IconAssets.location_pin),
                );
              },
            ),
          ),
          khSpacer(60.h),
        ],
      ),
    );
  }

  Container home(BuildContext context) {
    return Container(
      key: ValueKey<int>(activeIndex),
      child: Column(
        children: [
          kh20Spacer(),
          Center(
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.teal,
                border: Border.all(width: 30.w, color: Theme.of(context).primaryColor),
              ),
              child: Icon(Icons.check_rounded, size: 40.r),
            ),
          ),
          kh20Spacer(),
          Container(
            height: kheight(context) / 2.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (c, i) {
                return Container(
                  width: kwidth(context) / 1.2,
                  padding: kpadding(20.w, 0),
                  margin: kpadding(30.w, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: radiusM(),
                  ),
                  child: Text("${i}"),
                );
              },
            ),
          ),
          khSpacer(100.h),
        ],
      ),
    );
  }
}
