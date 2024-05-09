import 'dart:convert';

import 'package:eneo_fails/app/notification/data/services/local_notification_service.dart';
import 'package:eneo_fails/app/notification/model/base_notification_model/base_notification_model.dart';

class LocalNotificationRepository {
  final LocalNotificationService _localNotificationService;

  LocalNotificationRepository(this._localNotificationService);

  void initializeNotifications() {
    _localNotificationService.initialize();
  }

  void showNotification(BaseNotificationModel notification) {
    _localNotificationService.showSimpleNotification(
      title: notification.title,
      description: notification.description,
      payload: json.encode(notification.toJson()),
    );
  }
}
