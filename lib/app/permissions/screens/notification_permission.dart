import 'package:eneo_fails/app/notification/data/controller/notification/notification_bloc.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.notifications_active_rounded, size: 100.h),
        kh20Spacer(),
        Text(
          LangUtil.trans("permissions.notification_title"),
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        kh10Spacer(),
        Text(
          LangUtil.trans("permissions.notification_description"),
          textAlign: TextAlign.center,
        ),
        kh20Spacer(),
        ElevatedButton(
          child: Text(LangUtil.trans("permissions.enable")),
          onPressed: () async {
            getIt.get<NotificationBloc>().add(InitializeNotificationEvent());
          },
        ),
      ],
    );
  }
}
