import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/routes/route_names.dart';
import 'package:eneo_fails/shared/data/services/local_storage_service.dart';
import 'package:eneo_fails/shared/data/services/local_storage_service.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PageItem {
  final String title;

  PageItem({required this.title});
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  List<PageItem> items = [
    PageItem(title: "When is the next \nEneo Power Outage?"),
    PageItem(title: "Find out power outage\nin other places"),
    PageItem(title: "Know when \nElectricity will be back!"),
    PageItem(title: "Get Notified \nAhead of time"),
    PageItem(title: "Now... \nLet's Get Started!"),
  ];

  @override
  void initState() {
    routeUser();
    super.initState();
  }

  void routeUser() async {
    LocalStorageService localStorageService = getIt.get<LocalStorageService>();
    bool hasInit = await localStorageService.getInit();
    Future.delayed(Duration(seconds: 2), () => context.go(hasInit ? AppRoutes.home : AppRoutes.start));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: EneoFailsColor.kDark,
      ),
      child: Scaffold(
        body: Container(
          height: kHeight(context),
          width: kWidth(context),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(child: CupertinoActivityIndicator(color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }

  Container backDrop({required BuildContext context, required Widget child}) {
    return Container(
      color: EneoFailsColor.kDark,
      height: kHeight(context),
      width: kWidth(context),
      child: Stack(
        children: [
          // FadeInImage(
          //   fadeInDuration: Duration(seconds: 8),
          //   placeholder: AssetImage("${ImageAssets.outage}${currentIndex}.jpg"),
          //   image: AssetImage("${ImageAssets.outage}${currentIndex}.jpg"),
          // ),
          Container(
            height: 400.h,
            width: kWidth(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("${ImageAssets.outage}${currentIndex}.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              height: 700.h,
              width: kWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [EneoFailsColor.kDark.withOpacity(0), EneoFailsColor.kDark.withOpacity(0.8), EneoFailsColor.kDark],
                ),
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: Container(
              child: child,
              height: kHeight(context) / 1.2,
              width: kWidth(context),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 30,
            right: 30,
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        onboardLine(isActive: currentIndex == 0 ? true : false),
                        onboardLine(isActive: currentIndex == 1 ? true : false),
                        onboardLine(isActive: currentIndex == 2 ? true : false),
                        onboardLine(isActive: currentIndex == 3 ? true : false),
                        onboardLine(isActive: currentIndex == 4 ? true : false),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: currentIndex == 4 ? kPadding(15.w, 12.w) : kPadding(15.w, 15.w),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: radiusM()),
                    child: currentIndex == 4 ? Text("Get Started") : Icon(Icons.arrow_forward, color: EneoFailsColor.kWhite, size: 20),
                  )
                ],
              ),
              height: kHeight(context) / 5,
              width: kWidth(context),
              // color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  Widget onboardLine({required bool isActive}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: isActive ? 30.w : 10.w,
      height: 10.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: radiusL(),
        color: isActive ? EneoFailsColor.kWhite : EneoFailsColor.kWhite.withOpacity(0.5),
      ),
    );
  }
}
