import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redback_mobile_app/Utils/size_config.dart';
import "package:flutter_polyline_points/flutter_polyline_points.dart";
import "package:redback_mobile_app/Utils/constants.dart";

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapScreenState();
  }
}

class MapScreenState extends StatefulWidget {
  const MapScreenState({super.key});

  @override
  State<MapScreenState> createState() => _MapScreenStateState();
}

class _MapScreenStateState extends State<MapScreenState> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng destination = LatLng(27.6602292, 85.308027);
  LatLng sourceLocation = LatLng(27.6599592, 85.3102498);

  List<LatLng> polylineCoordinator = [];

  void getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
    );
    print(result.points);

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinator.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolylinePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 16,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinator,
            color: Colors.green,
          ),
        },
        markers: {
          Marker(
            markerId: MarkerId(
              sourceLocation.toString(),
            ),
            position: sourceLocation,
          ),
          Marker(
            markerId: MarkerId(
              destination.toString(),
            ),
            position: destination,
          ),
        },
      ),
    );
  }
}
