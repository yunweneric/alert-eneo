import 'package:eneo_fails/app/notification/data/services/local_notification_service.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/routes/route_names.dart';
import 'package:eneo_fails/shared/data/services/local_storage_service.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class PageItem {
  final String title;

  PageItem({required this.title});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  LocalStorageService localStorageService = getIt.get<LocalStorageService>();

  List<PageItem> items = [
    PageItem(title: "onboarding.title_1"),
    PageItem(title: "onboarding.title_2"),
    PageItem(title: "onboarding.title_3"),
    // PageItem(title: "Find out power outage\nin other places"),
    // PageItem(title: "Know when \nElectricity will be back!"),
    // PageItem(title: "Get Notified \nAhead of time"),
    // PageItem(title: "Now... \nLet's Get Started!"),
  ];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        // systemNavigationBarColor:Theme.of(context).primaryColorLight EneoFailsColor.kDark,
        systemNavigationBarColor: Theme.of(context).primaryColorLight,
      ),
      child: Scaffold(
        body: backDrop(
          context: context,
          child: PageView.builder(
            controller: controller,
            onPageChanged: (page) => setState(() => currentIndex = page),
            itemCount: items.length,
            itemBuilder: (c, i) {
              return Container(
                padding: kPadding(30.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      LangUtil.trans(items[i].title),
                      style: GoogleFonts.inter(fontSize: 25.sp, color: EneoFailsColor.kWhite, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            },
          ),
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
                  colors: [EneoFailsColor.kDark.withOpacity(0), EneoFailsColor.kDark.withOpacity(1), EneoFailsColor.kDark],
                ),
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: Container(child: child, height: kHeight(context) / 1.2, width: kWidth(context)),
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
                        // onboardLine(isActive: currentIndex == 3 ? true : false),
                        // onboardLine(isActive: currentIndex == 4 ? true : false),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (currentIndex == items.length - 1) {
                        bool hasPermission = await Permission.notification.isGranted;
                        if (!hasPermission) Permission.notification.request();
                        getIt.get<LocalNotificationService>().initialize();

                        context.go(AppRoutes.home);
                        localStorageService.saveInit(true);
                      } else {
                        controller.animateToPage(items.length, duration: Duration(milliseconds: 500), curve: Curves.linear);
                      }
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: currentIndex == items.length - 1 ? kPadding(15.w, 12.w) : kPadding(15.w, 15.w),
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: radiusM()),
                      child: currentIndex == items.length - 1
                          ? Text(
                              LangUtil.trans("onboarding.get_started"),
                            )
                          : Icon(Icons.arrow_forward, color: EneoFailsColor.kWhite, size: 20),
                    ),
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
      width: isActive ? 40.w : 8.w,
      height: 8.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: radiusL(),
        color: isActive ? EneoFailsColor.kWhite : EneoFailsColor.kWhite.withOpacity(0.5),
      ),
    );
  }
}
