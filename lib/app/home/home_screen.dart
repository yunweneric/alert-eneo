import 'package:eneo_fails/app/home/widgets/home_greeting.dart';
import 'package:eneo_fails/app/notification/data/services/background_service.dart';
import 'package:eneo_fails/app/outage/screens/components/home_outage_page_view.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  double? offset;
  @override
  void initState() {
    // BackGroundService.registerPeriodicTask();
    BackGroundService.initializeBackgroundService();
    BackGroundService.registerOneOffTask();
    super.initState();
  }

  NavigationBarBloc navigationBarBloc = getIt.get<NavigationBarBloc>();

  @override
  Widget build(BuildContext context) {
    // hasElectricity = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kh20Spacer(),
              HomeGreetings(),
              kh20Spacer(),
              HomeOutagePageView(),
              khSpacer(100.h),
            ],
          ),
        ),
      ),
    );
  }
}
