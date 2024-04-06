import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/screens/components/city_card.dart';
import 'package:eneo_fails/app/outage/screens/components/city_card_shimmer.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeOutagePageView extends StatefulWidget {
  const HomeOutagePageView({super.key});

  @override
  State<HomeOutagePageView> createState() => _HomeOutagePageViewState();
}

class _HomeOutagePageViewState extends State<HomeOutagePageView> {
  double? offset;
  double pageOffset = 0;
  bool loadingOutages = true;
  bool hasElectricity = true;
  int activeIndex = 0;
  PageController? pageController;
  NavigationBarBloc navigationBarBloc = getIt.get<NavigationBarBloc>();
  EneoOutageBloc eneoOutageBloc = getIt.get<EneoOutageBloc>();

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.95);
    eneoOutageBloc.add(GetOutEneoOutageEvent(regionId: "2"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EneoOutageBloc, EneoOutageState>(
      bloc: eneoOutageBloc,
      builder: (context, state) {
        if (state is EneoOutageFetchLoaded) {
          loadingOutages = false;
        }
        if (state is EneoOutageFetchError) {
          loadingOutages = false;
        }
        return Column(
          children: [
            kh20Spacer(),
            Padding(
              padding: kph(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Outages!", style: Theme.of(context).textTheme.displayMedium),
                      Text(
                        "Some outages around your city!",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => navigationBarBloc.add(NavigationBarChangeIndexEvent(activeIndex: 0)),
                    child: Chip(
                      label: Text("View All", style: Theme.of(context).textTheme.bodySmall),
                    ),
                  )
                ],
              ),
            ),
            kh10Spacer(),
            if (context.read<EneoOutageBloc>().outages.length == 0 && loadingOutages == false)
              Container(
                margin: kAppPading(),
                width: kwidth(context),
                height: kheight(context) / 2,
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: radiusM()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageAssets.no_data, width: 200),
                    Text("Outage data unavailable"),
                  ],
                ),
              ),
            // if (context.read<EneoOutageBloc>().outages.length > 0 || loadingOutages == false)
            Builder(builder: (context) {
              List<EneoOutageModel> items = context.read<EneoOutageBloc>().outages;
              int count = loadingOutages ? 5 : items.length;
              if (count > 10) {
                items = items.sublist(0, 10);
              }
              return Container(
                height: kheight(context) / 2.2,
                child: PageView.builder(
                  itemCount: loadingOutages ? 5 : items.length,
                  controller: pageController,
                  onPageChanged: ((value) {
                    setState(() => activeIndex = value);
                  }),
                  itemBuilder: (context, page) {
                    return loadingOutages
                        ? CityOutageShimmerCard(offset: pageOffset - page)
                        : CityOutageCard(
                            onTap: () => {},
                            offset: pageOffset - page,
                            outage: items[page],
                          );
                  },
                ),
              );
            }),
            kh10Spacer(),
            Container(
              margin: kAppPading(),
              // color: Colors.amber,
              width: kwidth(context) / 2,
              alignment: Alignment.center,
              height: 3.h,
              child: Builder(builder: (context) {
                List<int> items = List.generate(10, (index) => index);
                return Center(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: loadingOutages ? 5 : items.length,
                    itemBuilder: (context, page) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: activeIndex == page ? 20.w : 10.w,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: radiusM(),
                          color: activeIndex == page ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
