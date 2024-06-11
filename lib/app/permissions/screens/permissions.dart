import 'package:eneo_fails/app/location/data/controller/bloc/location_bloc.dart';
import 'package:eneo_fails/app/notification/data/controller/notification/notification_bloc.dart';
import 'package:eneo_fails/app/permissions/screens/location_permission.dart';
import 'package:eneo_fails/app/permissions/screens/notification_permission.dart';
import 'package:eneo_fails/routes/route_names.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppPermissionScreen extends StatefulWidget {
  const AppPermissionScreen({super.key});

  @override
  State<AppPermissionScreen> createState() => _AppPermissionScreenState();
}

class _AppPermissionScreenState extends State<AppPermissionScreen> {
  List<int> permissionScreens = [0, 1];

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  Widget builder(int currentIndex) {
    if (currentIndex == 0) {
      return LocationPermissionScreen();
    } else {
      return NotificationPermissionScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationBloc, LocationState>(
            listener: (context, state) {
              if (state is LocationPermissionComplete) {
                setState(() => currentIndex = currentIndex + 1);
              }
            },
          ),
          BlocListener<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is AllowNotificationComplete) {
                context.go(AppRoutes.home);
                // setState(() => currentIndex = currentIndex + 1);
              }
            },
          ),
        ],
        child: Padding(
          padding: kAppPadding(),
          child: PageView.builder(
            allowImplicitScrolling: false,
            itemCount: permissionScreens.length,
            itemBuilder: (context, index) {
              return builder(currentIndex);
            },
          ),
        ),
      ),
    );
  }
}
