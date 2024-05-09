part of 'notification_bloc.dart';

class NotificationEvent {}

class ShowUserBackgroundOutageNotificationEvent extends NotificationEvent {
  final UserOutage outage;
  ShowUserBackgroundOutageNotificationEvent(this.outage);
}

class InitializeNotificationEvent extends NotificationEvent {}
