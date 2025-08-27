import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';
import 'package:food_ordering_app/constants/secret_keys.dart';
import 'package:food_ordering_app/orders/model/delivery_information.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class DeliveryInformationWidget extends StatefulWidget {
  final DeliveryInformation info;
  const DeliveryInformationWidget({super.key, required this.info});

  @override
  State<DeliveryInformationWidget> createState() =>
      _DeliveryInformationWidgetState();
}

class _DeliveryInformationWidgetState extends State<DeliveryInformationWidget> {
  LatLng? userPosition;
  List<LatLng> routePoints = [];
  bool isLoading = true;
  late final LatLng deliveryPosition;

  @override
  void initState() {
    super.initState();
    deliveryPosition = LatLng(
      double.parse(widget.info.latitude),
      double.parse(widget.info.longitude),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            height: 173,
            color: Colors.grey,
            child: Builder(
              builder: (context) {
                if (userPosition != null) {
                  if (isLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  return MapWidget(
                    route: routePoints,
                    userPos: userPosition!,
                    deliveryPos: deliveryPosition,
                  );
                } else {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        getUserLocation();
                      },
                      child: Text('Get Position'),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            height: 60,
            width: double.maxFinite,
            color: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.info.contractName,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.info.contactPhone,
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                    child: SvgPicture.asset(AppSvg.call),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      userPosition = LatLng(position.latitude, position.longitude);
      setState(() {});
      fetchRoute(userPosition!, deliveryPosition);
    }
  }

  Future<void> fetchRoute(LatLng start, LatLng end) async {
    final url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson&access_token=$mapboxAccessToken';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coordinates =
            data['routes'][0]['geometry']['coordinates'] as List;

        // Convert coordinates to LatLng (Mapbox returns [lon, lat])
        setState(() {
          routePoints =
              coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
        });
      } else {
        print('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching route: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class MapWidget extends StatelessWidget {
  final List<LatLng> route;
  final LatLng userPos;
  final LatLng deliveryPos;

  const MapWidget({
    super.key,
    required this.route,
    required this.userPos,
    required this.deliveryPos,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          (userPos.latitude + deliveryPos.latitude) / 2,
          (userPos.longitude + deliveryPos.longitude) / 2,
        ),
        initialZoom: 10,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
          additionalOptions: {
            'accessToken': mapboxAccessToken,
            'id': 'mapbox/streets-v11',
          },
        ),
        PolylineLayer(
          polylines: [
            Polyline(points: route, strokeWidth: 2, color: Colors.black),
          ],
        ),
      ],
    );
  }
}
