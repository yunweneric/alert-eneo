import 'package:eneo_fails/app/home/home_screen.dart';
import 'package:eneo_fails/app/search/search_screen.dart';
import 'package:eneo_fails/app/settings/settings_screen.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:eneo_fails/shared/utils/icon_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  NavigationBarBloc navigationBarBloc = getIt.get<NavigationBarBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBarBloc, NavigationBarState>(
        builder: (context, state) {
          return Stack(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: state.activeIndex == 1
                    ? HomeScreen()
                    : state.activeIndex == 0
                        ? SearchScreen()
                        : SettingsScreen(),
              ),
              Positioned(
                bottom: 20,
                left: kwidth(context) / 4,
                right: kwidth(context) / 4,
                child: bottomBar(context, state.activeIndex),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bottomBar(BuildContext context, int activeIndex) {
    return Material(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: radiusXxl()),
      child: Container(
        // height: 60.h,
        padding: kpadding(10, 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: radiusL(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomIcon(
                context: context,
                icon: IconAssets.globe_search,
                index: 0,
                activeIndex: activeIndex),
            bottomIcon(
                context: context,
                icon: IconAssets.home,
                index: 1,
                activeIndex: activeIndex),
            bottomIcon(
                context: context,
                icon: IconAssets.settings,
                index: 2,
                activeIndex: activeIndex),
          ],
        ),
      ),
    );
  }

  GestureDetector bottomIcon(
      {required BuildContext context,
      required int index,
      required String icon,
      required int activeIndex}) {
    return GestureDetector(
      onTap: () => navigationBarBloc
          .add(NavigationBarChangeIndexEvent(activeIndex: index)),
      child: AnimatedScale(
        scale: activeIndex == index ? 1.5 : 1.2,
        duration: Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: activeIndex == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorDark,
            ),
            khSpacer(2.h),
            if (activeIndex == index)
              Container(
                width: 10.w,
                height: 1.h,
                decoration: BoxDecoration(
                  borderRadius: radiusM(),
                  color: navigationBarBloc.state.activeIndex == index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark,
                ),
              )
          ],
        ),
      ),
    );
  }
}
