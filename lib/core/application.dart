import 'dart:ui';

import 'package:eneo_fails/routes/router.dart';
import 'package:eneo_fails/shared/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class EneoFailsApp extends StatefulWidget {
  const EneoFailsApp({super.key});

  @override
  State<EneoFailsApp> createState() => _EneoFailsAppState();
}

class _EneoFailsAppState extends State<EneoFailsApp> {
  bool isDarkMode = false;
  @override
  void initState() {
    changeTheme();
    window.onPlatformBrightnessChanged = () => changeTheme();
    super.initState();
  }

  changeTheme() {
    final brightness = window.platformBrightness;
    setState(() => isDarkMode = brightness == Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(360, 690),
      builder: (context, child) {
        ThemeData theme = LinkoTheme.dark();
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Linko',
          routerConfig: routes,
          debugShowCheckedModeBanner: false,
          theme: theme,
        );
      },
    );
  }
}
