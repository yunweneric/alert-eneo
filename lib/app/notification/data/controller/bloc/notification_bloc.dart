import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/notification/data/repository/local_notification_repository.dart';
import 'package:eneo_fails/app/notification/model/base_notification_model/base_notification_model.dart';
import 'package:eneo_fails/app/notification/model/notification_types.dart';
import 'package:eneo_fails/shared/data/models/user_outage_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final LocalNotificationRepository _localNotificationRepository;
  NotificationBloc(this._localNotificationRepository) : super(NotificationInitial()) {
    on<ShowUserBackgroundOutageNotificationEvent>((event, emit) {
      BaseNotificationModel model = BaseNotificationModel(
        data: event.outage.toJson(),
        title: "notifications.outage_title",
        type: NotificationType.EneoOutage,
        description: "notifications.outage_description",
      );
      _localNotificationRepository.showNotification(model);
    });
  }
}
