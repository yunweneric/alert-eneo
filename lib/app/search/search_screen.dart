import 'dart:async';
import 'package:eneo_fails/shared/utils/image_asset.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  String? _darkMapStyle;

  bool hasMapLoaded = false;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    _loadMapStyles();
    super.initState();
  }

  Future _loadMapStyles() async {
    final darkMapStyle = await rootBundle.loadString(ImageAssets.dark_map);
    setState(() {
      _darkMapStyle = darkMapStyle;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).cardColor,
        height: kHeight(context),
        width: kWidth(context),
        child: Stack(
          children: [
            GoogleMap(
              style: _darkMapStyle,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                setState(() {
                  hasMapLoaded = true;
                });
              },
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: kToolbarHeight),
                padding: kph(20.w),
                child: TextField(
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    hintText: "Search for a location",
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    contentPadding: kPadding(20.w, 10.h),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            )
            // Expanded(child: TextField()),
          ],
        ),
      ),
    );
  }
}
