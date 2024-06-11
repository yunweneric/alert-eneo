import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/screens/components/city_card.dart';
import 'package:eneo_fails/app/outage/screens/components/city_card_shimmer.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
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
                      Text(LangUtil.trans("outage.outages"),
                          style: Theme.of(context).textTheme.displayMedium),
                      Text(
                        LangUtil.trans("outage.some_outages"),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => navigationBarBloc
                        .add(NavigationBarChangeIndexEvent(activeIndex: 0)),
                    child: Chip(
                      label: Text(LangUtil.trans("outage.view_all"),
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  )
                ],
              ),
            ),
            kh10Spacer(),
            if (context.read<EneoOutageBloc>().outages.length == 0 &&
                loadingOutages == false)
              Container(
                margin: kAppPadding(),
                padding: kPadding(30.w, 10.h),
                width: kWidth(context),
                height: kHeight(context) / 2.3,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: radiusM()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageAssets.no_data,
                        width: 200,
                        color: Theme.of(context).primaryColor.withOpacity(0.5)),
                    kh10Spacer(),
                    Text(
                      LangUtil.trans("outage.no_outages_planned"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            // if (context.read<EneoOutageBloc>().outages.length > 0 || loadingOutages == false)
            Builder(builder: (context) {
              List<EneoOutageModel> items =
                  context.read<EneoOutageBloc>().outages;
              int count = loadingOutages ? 5 : items.length;
              if (count > 10) {
                items = items.sublist(0, 10);
              }
              return Container(
                height: kHeight(context) / 2.3,
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
              margin: kAppPadding(),
              // color: Colors.amber,
              width: kWidth(context) / 2,
              height: 3.h,
              child: Builder(builder: (context) {
                List<int> items = List.generate(10, (index) => index);
                if (!loadingOutages) {
                  items = List.generate(
                      context.read<EneoOutageBloc>().outages.length,
                      (index) => index);
                  items = items.length > 10 ? items.sublist(0, 10) : items;
                }
                return Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items.map((page) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: activeIndex == page ? 20.w : 10.w,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: radiusM(),
                          color: activeIndex == page
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                        ),
                      );
                    }).toList(),
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
