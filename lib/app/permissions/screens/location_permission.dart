import 'package:eneo_fails/app/location/data/controller/bloc/location_bloc.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_pin, size: 100.h),
        kh20Spacer(),
        Text(
          LangUtil.trans("permissions.location_title"),
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        kh20Spacer(),
        Text(
          LangUtil.trans("permissions.location_description"),
          textAlign: TextAlign.center,
        ),
        khSpacer(50.h),
        ElevatedButton(
          child: Text(LangUtil.trans("permissions.enable")),
          onPressed: () async {
            getIt.get<LocationBloc>().add(InitializeAndAllowLocationEvent());
          },
        ),
      ],
    );
  }
}
