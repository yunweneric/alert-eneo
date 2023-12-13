import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Row(children: [Text("Douala"), kwSpacer(5.w), Icon(Icons.sunny)]),
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: activeIndex == 0 ? home(context) : searchHome(context),
            // transitionBuilder: (Widget child, Animation<double> a) {
            //   return ScaleTransition(scale: a);
            // },
          ),
          Positioned(
            bottom: 10,
            left: kwidth(context) / 3.5,
            right: kwidth(context) / 3.5,
            child: Material(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: radiusL()),
              child: Container(
                height: 50.h,
                // width: kwidth(context) / 2,
                // margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
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
                        scale: activeIndex == 0 ? 1.5 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Icon(Icons.home, color: activeIndex == 0 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => activeIndex = 1),
                      child: AnimatedScale(
                        scale: activeIndex == 1 ? 1.5 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Icon(Icons.search, color: activeIndex == 1 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container searchHome(BuildContext context) {
    return Container(
      key: ValueKey<int>(activeIndex),
      padding: kAppPading(),
      child: Column(
        children: [
          CupertinoSearchTextField(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (c, i) {
                return ListTile(
                  minLeadingWidth: 10.w,
                  title: Text("Search Item", style: Theme.of(context).textTheme.bodyMedium),
                  leading: Icon(Icons.wb_sunny),
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
