import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/screens/components/outage_list_shimmer.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/utils/icon_asset.dart';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:eneo_fails/shared/utils/util_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OutageListPage extends StatefulWidget {
  const OutageListPage({super.key});

  @override
  State<OutageListPage> createState() => _OutageListPageState();
}

class _OutageListPageState extends State<OutageListPage> {
  EneoOutageBloc eneoOutageBloc = getIt.get<EneoOutageBloc>();
  bool loadingOutages = true;
  ScrollController? controller;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // eneoOutageBloc.add(GetOutEneoOutageEvent(regionId: "7"));
    eneoOutageBloc.add(SearchEneoOutageEvent(localite: ''));
    focusNode.addListener(() {
      if (!focusNode.hasFocus) scrollTo(0.h);
      print("Action and inactive ${focusNode.hasFocus}");
    });
    controller = ScrollController();
    super.initState();
  }

  scrollTo(double offset) {
    controller?.animateTo(offset,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () => focusNode.unfocus(),
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.h,
              pinned: true,
              snap: false,
              floating: true,
              backgroundColor: Theme.of(context).cardColor,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                double top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  titlePadding: kpadding(20.w, 10.h),
                  background:
                      Image.asset(ImageAssets.outage1, fit: BoxFit.fill),
                  title: AnimatedSwitcher(
                    duration: Duration(milliseconds: 700),
                    child: top < 200
                        ? SafeArea(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Eneo Outages",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  GestureDetector(
                                    onTap: () {
                                      scrollTo(0.h);
                                      focusNode.requestFocus();
                                    },
                                    child:
                                        Icon(Icons.search, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: kpadding(0.w, 20.h),
                            child: Container(
                              // color: Colors.teal,
                              height: 35.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: searchController,
                                      focusNode: focusNode,
                                      onTap: () => scrollTo(100.h),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        fillColor: Theme.of(context).cardColor,
                                        filled: true,
                                        hintText: "Search for outages...",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 10.sp),
                                        contentPadding: kpadding(10.w, 0.h),
                                        // prefixIcon: Icon(Icons.search),
                                      ),
                                    ),
                                  ),
                                  kwSpacer(10.w),
                                  GestureDetector(
                                    onTap: () {
                                      String locality =
                                          searchController.text.trim();
                                      if (locality.isNotEmpty) {
                                        focusNode.unfocus();
                                        eneoOutageBloc.add(
                                            SearchEneoOutageEvent(
                                                localite: locality));
                                      }
                                    },
                                    child: Container(
                                      // padding: kpadding(5.w, 5.w),
                                      height: 35.h, width: 35.h,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: radiusVal(5.r),
                                      ),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              IconAssets.search,
                                              color: Theme.of(context)
                                                  .primaryColorDark)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                );
              }),
            ),
            BlocConsumer<EneoOutageBloc, EneoOutageState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is EneoOutageFetchLoaded ||
                    state is EneoOutageSearchLoaded) {
                  loadingOutages = false;
                }
                if (state is EneoOutageFetchError ||
                    state is EneoOutageSearchError) {
                  loadingOutages = false;
                }
                if (state is EneoOutageFetchLoading ||
                    state is EneoOutageSearchLoading) {
                  loadingOutages = true;
                }
                if (context.read<EneoOutageBloc>().searchOutages.length == 0 &&
                    loadingOutages == false)
                  return SliverToBoxAdapter(
                    child: Container(
                      padding: kAppPading(),
                      margin: kAppPading(),
                      width: kwidth(context),
                      height: kheight(context) / 2.2,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: radiusM()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.no_data, width: 200),
                          Text("No construction program planned in your area",
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                return Builder(builder: (context) {
                  List<EneoOutageModel> items =
                      context.read<EneoOutageBloc>().searchOutages;
                  return SliverList(
                    delegate: loadingOutages
                        ? SliverChildBuilderDelegate(
                            (builder, int index) => Padding(
                                  padding: kAppPading(),
                                  child: Column(
                                    children: [
                                      OutageListShimmer(),
                                      kh10Spacer(),
                                    ],
                                  ),
                                ),
                            childCount: 10)
                        : SliverChildBuilderDelegate((builder, int index) {
                            EneoOutageModel? outage = items[index];
                            return outageCard(context, outage);
                          }, childCount: items.length),
                  );
                });
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 100.h),
            )
          ],
        ),
      ),
    );
  }

  Widget outageCard(BuildContext context, EneoOutageModel outage) {
    return Padding(
      padding: kAppPading(),
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(borderRadius: radiusVal(10.r)),
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: radiusVal(5.r)),
                  padding: kpadding(10.w, 10.w),
                  child: SvgPicture.asset(IconAssets.outage_pin,
                      color: Theme.of(context).primaryColorDark),
                ),
                kwSpacer(10.w),
                Expanded(
                    child: Text(
                        "${outage.region} ${outage.ville} - ${outage.quartier}")),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kh10Spacer(),
                Text(outage.observations ?? "No observations provided!"),
                kh10Spacer(),
                Row(
                  children: [
                    kh10Spacer(),
                    outageChip(
                      context: context,
                      icon: IconAssets.calendar,
                      title: UtilHelper.formatDate(outage.progDate),
                    ),
                    kwSpacer(10.w),
                    outageChip(
                      context: context,
                      icon: IconAssets.clock,
                      title:
                          "${outage.progHeureDebut ?? ""} - ${outage.progHeureFin ?? ""}",
                    ),
                  ],
                ),
              ],
            ),
          ),
          kh10Spacer()
        ],
      ),
    );
  }

  Chip outageChip(
      {required String title,
      required BuildContext context,
      required String icon}) {
    return Chip(
      label: Text(title, style: Theme.of(context).textTheme.bodySmall),
      avatar: SvgPicture.asset(icon, color: Theme.of(context).primaryColorDark),
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
