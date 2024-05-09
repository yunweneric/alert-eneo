import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eneo_fails/app/notification/model/base_notification_model/base_notification_model.dart';
import 'package:eneo_fails/app/notification/model/notification_types.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/log_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  int id = 0;

  // final _notificationService = FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // static GlobalKey<NavigatorState>? navigatorKey;
  static BuildContext? current_context;

  String? selectedNotificationPayload;

  /// A notification action which triggers a url launch event
  static const String urlLaunchActionId = 'id_1';

  /// A notification action which triggers a App navigation event
  static const String navigationActionId = 'id_3';

  /// Defines a iOS/MacOS notification category for text input actions.
  static const String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  static const String darwinNotificationCategoryPlain = 'plainCategory';

  Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future initialize() async {
    await configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final List<DarwinNotificationCategory> darwinNotificationCategories = <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text('text_1', 'Action 1', buttonTitle: 'Send', placeholder: 'Placeholder'),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.destructive},
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.foreground},
          ),
          DarwinNotificationAction.plain(
            'id_4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.authenticationRequired},
          ),
        ],
        options: <DarwinNotificationCategoryOption>{DarwinNotificationCategoryOption.hiddenPreviewShowTitle},
      )
    ];

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) {
        logI([id, title, body, payload]);
      },
      notificationCategories: darwinNotificationCategories,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  AndroidNotificationDetails simpleAndroidNotificationDetails = AndroidNotificationDetails(
    'eneo_alert_android_notification_id',
    'eneo_alert_android_notification_name',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'eneo_alert_ticker',
    colorized: true,
  );

  DarwinNotificationDetails simpleIOSNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    threadIdentifier: 'eneo_alert_ios_notification_id',
    categoryIdentifier: 'eneo_alert_android_notification_description',
    interruptionLevel: InterruptionLevel.timeSensitive,
  );

  Future<void> showSimpleNotification({required String title, required String description, String? payload}) async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: this.simpleAndroidNotificationDetails,
      iOS: simpleIOSNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id++,
      LangUtil.trans(title),
      LangUtil.trans(description),
      notificationDetails,
      payload: payload,
    );
  }

  // *-----------------------------------------------------------------------------------------------------------------------

  static void notificationTapBackground(NotificationResponse notificationResponse) async {
    Map<String, dynamic> response = json.decode(notificationResponse.payload!);
    BaseNotificationModel notification = BaseNotificationModel.fromJson(response);
    String notificationType = notification.type;

    if (notificationType == NotificationType.EneoOutage) {
      // final kycDetails = KycNotification.fromJson(notification.data);
    }
  }
}
