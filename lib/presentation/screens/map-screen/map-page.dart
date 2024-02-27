// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:aquae_florentis/data/location.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/map-screen/search-map-page.dart';
import 'package:aquae_florentis/presentation/screens/splash-screen/splash-screen.dart';
import 'package:aquae_florentis/presentation/widgets/error-screen.dart';
import 'package:aquae_florentis/presentation/widgets/loading-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

late GoogleMapController controller;

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key, this.initialLatLng});
  final LatLng? initialLatLng;

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  bool isLoading = true;
  bool serviceEnabled = true;
  String? placeAddress;
  LatLng? initialCameraPosition;
  LatLng? selectedLong;
  Set<Marker> markers = {};

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        kUiOverlayStyle.copyWith(statusBarColor: Colors.transparent));

    initialCameraPosition = widget.initialLatLng;
    if (initialCameraPosition == null) {
      getCurrentLocation();
    } else {
      isLoading = false;
      markers.add(Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: const MarkerId("Default Marker"),
        position: LatLng(
            widget.initialLatLng!.latitude, widget.initialLatLng!.longitude),
      ));
    }
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(kUiOverlayStyle);
    super.dispose();
  }

  Future<void> getCurrentLocation() async {
    Location? location = await LocationService.askPermission();
    if (location == null) {
      setState(() {
        isLoading = false;
        serviceEnabled = false;
      });
      return;
    }
    final locationData = await location.getLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      initialCameraPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      markers.add(Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: const MarkerId("Default Marker"),
        position: LatLng(
            initialCameraPosition!.latitude, initialCameraPosition!.longitude),
      ));
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      extendBody: true,
      body: isLoading || !serviceEnabled || initialCameraPosition == null
          ? SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: isLoading
                  ? const LoadingScreen(
                      label: "Initiating Maps...",
                    )
                  : const ErrorScreen(
                      label: "Ensure location service is enabled",
                    ),
            )
          : mapWidget(),
      floatingActionButton: selectedLong != null
          ? FloatingActionButton(
              onPressed: () => Navigator.pop(context, {"latlng": selectedLong, "place name":placeAddress!}),
              foregroundColor: Colors.blue,
              backgroundColor: Colors.white,
              child: const Icon(
                CupertinoIcons.check_mark,
                size: IconSizeManager.regular,
              ),
            )
          : null,
      bottomNavigationBar: initialCameraPosition != null
          ? BottomBar(
              onAddLocation: addLocation,
            )
          : null,
    );
  }

  Widget mapWidget() {
    return GoogleMap(
      onMapCreated: (_controller) {
        controller = _controller;
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(
            initialCameraPosition!.latitude, initialCameraPosition!.longitude),
        zoom: 18,
      ),
      indoorViewEnabled: true,
      zoomControlsEnabled: false,
      markers: markers,
      onTap: (latlng)async{
        final json = await LocationService.getLocationJsonFromLatLng(latlng: latlng);
        String placeAddress = json["results"][0]["formatted_address"];
        addLocation({"latlng": latlng, "place name":placeAddress});

      },
    );
  }

  void addLocation(Map<String,dynamic> map) async {
    final iconMarker =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    if (markers.last.markerId.value == "selected marker") {
      markers.remove(markers.last);
      return;
    }
    final latlng = map["latlng"] as LatLng;
    setState(() {
      placeAddress = map["place name"];
      markers.add(Marker(
          markerId: const MarkerId("selected marker"),
          icon: iconMarker,
          position: latlng));
      selectedLong = latlng;
    });
  }
}

class BottomBar extends ConsumerStatefulWidget {
  final void Function(Map<String,dynamic>) onAddLocation;
  const BottomBar({
    super.key,
    required this.onAddLocation,
  });

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(SizeManager.large * 1.6)),
      child: Container(
        height: ValuesManager.bottomBarHeight * 1.5,
        padding: const EdgeInsets.symmetric(horizontal: SizeManager.medium),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(SizeManager.large * 1.6)),
            boxShadow: kElevationToShadow[3]),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeManager.regular),
            color: const Color.fromARGB(64, 226, 226, 226),
          ),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 0, horizontal: SizeManager.regular * 1.5),
            title: const Text("Search Place"),
            titleTextStyle: GoogleFonts.quicksand(
                color: ColorManager.secondary,
                fontSize: FontSizeManager.regular * 0.9,
                fontWeight: FontWeightManager.medium),
            tileColor: Colors.transparent,
            onTap: () {
              SystemChrome.setSystemUIOverlayStyle(kUiOverlayStyle);
              showModalBottomSheet(
                isScrollControlled: true,
                showDragHandle: true,
                useSafeArea: true,
                backgroundColor: ColorManager.background,
                context: context,
                builder: (context) {
                  return const SearchMapPage();
                },
              ).then((value) async {
                SystemChrome.setSystemUIOverlayStyle(kUiOverlayStyle.copyWith(
                    statusBarColor: Colors.transparent));
                if (value != null) {
                  final placeJson = value as Map<String, String>;
                  final latlng = await LocationService.getLatLngFromPlace(
                      placeId: placeJson["place id"].toString());
                  if (latlng != null) {
                    widget.onAddLocation({
                      "place name": placeJson["place name"],
                      "place id": placeJson["place id"],
                      "latlng": latlng
                    });
                    controller.animateCamera(CameraUpdate.newLatLng(latlng));
                  }
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
