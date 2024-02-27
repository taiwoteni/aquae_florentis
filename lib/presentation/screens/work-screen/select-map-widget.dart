// ignore_for_file: use_build_context_synchronously

import 'package:aquae_florentis/data/location.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/screens/map-screen/map-page.dart';
import 'package:aquae_florentis/presentation/widgets/lottie-widget.dart';
import 'package:aquae_florentis/presentation/widgets/ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectMapWidget extends ConsumerStatefulWidget {
  final void Function(Map<String, dynamic>) onMapSelect;
  final double size;
  final String? mockLocation;
  const SelectMapWidget(
      {super.key,
      this.size = 85,
      this.mockLocation,
      required this.onMapSelect});

  @override
  ConsumerState<SelectMapWidget> createState() => _SelectMapWidgetState();
}

class _SelectMapWidgetState extends ConsumerState<SelectMapWidget> {
  LatLng? latlng;
  String img = "";
  bool isLoading = false;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: latlng == null
            ? ref.watch(communityProvider) != null
                ? ref.watch(communityProvider)!.primaryColor
                : Colors.blue
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          onTap: pickFromMap,
          child: img != ""
              ? CircleImage(
                  image: DecorationImage(
                      image: NetworkImage(img), fit: BoxFit.cover),
                  size: double.maxFinite)
              : isLoading
                  ? LottieIcon(
                      'loading',
                      color: Colors.white,
                      size: widget.size * 0.50,
                      fit: BoxFit.cover,
                      repeat: true,
                    )
                  : Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.white,
                      size: widget.size * 0.50,
                    ),
        ),
      ),
    );
  }

  Future<void> pickFromMap() async {
    setState(() {
      isLoading = true;
    });

    final json = await Navigator.of(context)
        .push<Map<String, dynamic>>(MaterialPageRoute(
      builder: (context) => const MapPage(),
    ));

    if (json == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final latlng = json["latlng"] as LatLng;

    final String urlImage = LocationService.getLocationPreview(
        long: latlng.longitude, lat: latlng.latitude);
    setState(() {
      this.latlng = latlng;
      img = urlImage;
    });
    widget.onMapSelect(json);
  }
}
