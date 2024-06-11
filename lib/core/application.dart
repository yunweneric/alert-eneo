import 'dart:ui';

import 'package:eneo_fails/app/donation/data/controller/donation/donation_bloc.dart';
import 'package:eneo_fails/app/location/data/controller/bloc/location_bloc.dart';
import 'package:eneo_fails/app/notification/data/controller/notification/notification_bloc.dart';
import 'package:eneo_fails/app/notification/data/services/background_service.dart';
import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/payment/logic/payment/payment_bloc.dart';
import 'package:eneo_fails/app/permissions/data/bloc/permissions_bloc.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/routes/router.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:eneo_fails/shared/utils/log_util.dart';
import 'package:eneo_fails/shared/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<NavigationBarBloc>()),
        BlocProvider(create: (context) => getIt.get<EneoOutageBloc>()),
        BlocProvider(create: (context) => getIt.get<DonationBloc>()),
        BlocProvider(create: (context) => getIt.get<PaymentBloc>()),
        BlocProvider(create: (context) => getIt.get<LocationBloc>()),
        BlocProvider(create: (context) => getIt.get<PermissionsBloc>()),
        BlocProvider(create: (context) => getIt.get<NotificationBloc>()),
      ],
      child: BlocConsumer<EneoOutageBloc, EneoOutageState>(
        listener: ((context, state) async {
          if (state is EneoOutageGetUserLoaded) {
            // await BackGroundService.initializeBackgroundService();
            BackGroundService.registerOneOffTask();
          }
        }),
        builder: (context, state) {
          logI(state);
          return ScreenUtilInit(
            useInheritedMediaQuery: true,
            designSize: Size(360, 690),
            builder: (context, child) {
              final hasElectricity =
                  context.read<EneoOutageBloc>().userOutage?.hasElectricity ==
                      true;
              ThemeData theme = hasElectricity
                  ? EneoOutageTheme.light()
                  : EneoOutageTheme.dark();
              return MaterialApp.router(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Alert Eneo',
                routerConfig: routes,
                debugShowCheckedModeBanner: false,
                theme: theme,
              );
            },
          );
        },
      ),
    );
  }
}
