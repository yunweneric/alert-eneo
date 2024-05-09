import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/notification/data/repository/local_notification_repository.dart';
import 'package:eneo_fails/app/notification/model/base_notification_model/base_notification_model.dart';
import 'package:eneo_fails/app/notification/model/notification_types.dart';
import 'package:eneo_fails/shared/data/models/user_outage_model.dart';
import 'package:eneo_fails/shared/utils/json_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final LocalNotificationRepository _localNotificationRepository;
  NotificationBloc(this._localNotificationRepository) : super(NotificationInitial()) {
    on<InitializeNotificationEvent>((event, emit) async {
      bool hasPermission = await Permission.notification.isGranted;
      if (!hasPermission) await Permission.notification.request();
      _localNotificationRepository.initializeNotifications();
      emit(AllowNotificationComplete());
    });
    on<ShowUserBackgroundOutageNotificationEvent>((event, emit) async {
      String deviceLocale = PlatformDispatcher.instance.locale.languageCode;
      final assetLoader = JsonAssetLoader();
      final en = await assetLoader.load('assets/translations', Locale("en"));
      final fr = await assetLoader.load('assets/translations', Locale("fr"));
      final Map<String, dynamic> localMap = deviceLocale == "en" ? en : fr;
      BaseNotificationModel model = BaseNotificationModel(
        data: event.outage.toJson(),
        title: event.outage.hasElectricity == true ? localMap['notifications']['outage_title_available'] : localMap['notifications']['outage_title_failure'],
        description: event.outage.hasElectricity == true ? localMap['notifications']['outage_in_description'] : localMap['notifications']['outage_out_description'],
        type: NotificationType.EneoOutage,
      );
      _localNotificationRepository.showNotification(model);
    });
  }
}
