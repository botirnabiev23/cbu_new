import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late GoogleMapController mapController;
    const LatLng center = LatLng(41.337595, 69.286683);

    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return Center(
      child: SizedBox.expand(
        child: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: center,
            zoom: 15,
          ),
          markers: {
            const Marker(
              markerId: MarkerId('Tashkent'),
              position: LatLng(41.337595, 69.286683),
            ),
          },
        ),
      ),
    );
  }
}
