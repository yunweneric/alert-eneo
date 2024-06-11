import 'package:eneo_fails/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SuccessPermissionScreen extends StatefulWidget {
  const SuccessPermissionScreen({super.key});

  @override
  State<SuccessPermissionScreen> createState() =>
      _SuccessPermissionScreenState();
}

class _SuccessPermissionScreenState extends State<SuccessPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, size: 80.h),
        ElevatedButton(
          child: Text("notification_allowed"),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ],
    );
  }
}
