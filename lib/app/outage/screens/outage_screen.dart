import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/screens/components/no_outage_card.dart';
import 'package:eneo_fails/app/outage/screens/components/outage_app_bar.dart';
import 'package:eneo_fails/app/outage/screens/components/outage_list.dart';
import 'package:eneo_fails/app/outage/screens/components/outage_shimmer_card.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutageListPage extends StatefulWidget {
  const OutageListPage({super.key});

  @override
  State<OutageListPage> createState() => _OutageListPageState();
}

class _OutageListPageState extends State<OutageListPage> {
  EneoOutageBloc eneoOutageBloc = getIt.get<EneoOutageBloc>();
  bool loadingOutages = false;
  ScrollController? controller;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) scrollTo(0.h);
    });
    controller = ScrollController();
    super.initState();
  }

  scrollTo(double offset) {
    controller?.animateTo(offset, duration: Duration(milliseconds: 300), curve: Curves.linear);
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
              stretch: true,
              expandedHeight: 250.h,
              pinned: true,
              snap: false,
              floating: true,
              backgroundColor: Theme.of(context).cardColor,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  double top = constraints.biggest.height;
                  return OutageAppBar(
                    top: top,
                    focusNode: focusNode,
                    onTapSearch: () => scrollTo(0.h),
                  );
                },
              ),
            ),
            BlocConsumer<EneoOutageBloc, EneoOutageState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is EneoOutageFetchLoaded || state is EneoOutageSearchLoaded) {
                  loadingOutages = false;
                }
                if (state is EneoOutageFetchError || state is EneoOutageSearchError) {
                  loadingOutages = false;
                }
                if (state is EneoOutageFetchLoading || state is EneoOutageSearchLoading) {
                  loadingOutages = true;
                }
                if (context.read<EneoOutageBloc>().searchOutages.length == 0 && loadingOutages == false)
                  return SliverToBoxAdapter(
                    child: NoOutageCard(),
                  );
                return Builder(
                  builder: (context) {
                    List<EneoOutageModel> items = context.read<EneoOutageBloc>().searchOutages;

                    return SliverToBoxAdapter(
                      child: AnimatedSwitcher(
                        duration: Duration(seconds: 4),
                        child: loadingOutages ? OutageShimmerCard() : OutageList(items: items),
                      ),
                    );
                  },
                );
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 100.h))
          ],
        ),
      ),
    );
  }
}
