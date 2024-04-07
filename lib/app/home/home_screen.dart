import 'package:eneo_fails/app/home/data/models/outage_model.dart';
import 'package:eneo_fails/app/outage/screens/components/outage_page_view.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:faker/faker.dart';
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
  double pageOffset = 0;
  bool loadingOutages = true;
  bool hasElectricity = true;
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.95);
    Future.delayed(Duration(seconds: 2), () {
      setState(() => loadingOutages = false);
    });
    super.initState();
  }

  NavigationBarBloc navigationBarBloc = getIt.get<NavigationBarBloc>();

  List<OutageModel> outages = List.generate(10, (index) {
    Faker faker = Faker();
    return OutageModel(
      name: faker.address.city(),
      description: faker.lorem.sentence(),
      cityImage: "https://picsum.photos/id/3${index}/800/1200",
      status: faker.randomGenerator.boolean(),
    );
  });
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
              Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    margin: kph(20.w),
                    padding: kpadding(20.w, 30.w),
                    width: kwidth(context),
                    decoration: BoxDecoration(
                      borderRadius: radiusM(),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good Morning!",
                            style: Theme.of(context).textTheme.displayMedium),
                        kh10Spacer(),
                        Text(
                          "It seems you are out of electricity. \nNote that this information may not be too accurate",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      hasElectricity ? Icons.check_circle : Icons.cancel,
                      size: 200.r,
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              kh20Spacer(),
              HomeOutagePageView(),
              // khSpacer(100.h),
            ],
          ),
        ),
      ),
    );
  }
}
