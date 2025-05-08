import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: unused_field
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId("1"),
      position: LatLng(9.3047, -75.3978),
      infoWindow: const InfoWindow(title: "Hueco en calle 20"),
    ),
    Marker(
      markerId: const MarkerId("2"),
      position: LatLng(9.3060, -75.4000),
      infoWindow: const InfoWindow(title: "Falla en alumbrado"),
    ),
  };

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Mapa de Reportes",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width < 600 ? 19 : 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white, // Ajusta el AppBar según convenga
        surfaceTintColor: Colors.transparent,
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 14,
              ),
              myLocationEnabled: true,
              markers: _markers,
            ),
    );
  }
}
