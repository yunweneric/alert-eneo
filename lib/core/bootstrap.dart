import 'package:eneo_fails/core/application.dart';
import 'package:eneo_fails/core/config.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

Future bootstrap() async {
  // await Firebase.initializeApp(options: await DefaultFirebaseOptions.currentPlatform);

  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  AppConfig.init();

  ServiceLocators.register();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: EneoFailsApp(),
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
