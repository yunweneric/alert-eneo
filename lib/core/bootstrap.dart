import 'package:eneo_fails/app/notification/data/services/background_service.dart';
import 'package:eneo_fails/app/notification/data/services/local_notification_service.dart';
import 'package:eneo_fails/core/application.dart';
import 'package:eneo_fails/core/config.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

Future bootstrap(Function backGroundTask) async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  AppConfig.init();

  await ServiceLocators.register();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  bool hasPermission = await Permission.notification.isGranted;
  if (!hasPermission) Permission.notification.request();

  getIt.get<LocalNotificationService>().initialize();

  await Workmanager().initialize(backGroundTask, isInDebugMode: kDebugMode);
  BackGroundService.initializeBackgroundService();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: Builder(
        builder: (context) {
          return EneoFailsApp();
        },
      ),
      errorWidget: (error) {
        print(error);
        return Placeholder(
          child: Container(
            decoration: BoxDecoration(
              // color: EneoFailsColor.primaryColor,
              image: DecorationImage(
                image: AssetImage(ImageAssets.outage),
              ),
            ),
          ),
        );
      },
    ),
  );
}
