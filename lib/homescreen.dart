import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps/locationprovider.dart';
import 'package:location/location.dart';

class Homescreen extends StatefulWidget {
  static String RoutName = 'name';

  @override
  State<Homescreen> createState() => _HomescreenState();

  static const String userloc = 'user';
}

class _HomescreenState extends State<Homescreen> {
  Locationprovid locationprovider=Locationprovid();
  GoogleMapController? mapController=null;
  CameraPosition mypositon = CameraPosition(
    target: LatLng(31.2762372, 29.0068563),
    zoom: 15,
  );

  Set<Marker> markars = {
  Marker(markerId: MarkerId('lala'),position: LatLng(31.2762372, 29.0068563))
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trackuserlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.satellite,
            initialCameraPosition: mypositon,
            onMapCreated: (GoogleMapController controller) {
              mapController=controller;
            },
            myLocationButtonEnabled: true,
            compassEnabled: true,
            markers: markars,
          ),
        ],
      ),
    );
  }
  static const String montza = 'montza';
StreamSubscription<LocationData>? listlocation=null;
  void trackuserlocation() async {
    bool permission = await locationprovider.IsPermissionGranted();
    if (permission == false) return null;
    bool service = await locationprovider.IsServiceEnabled();
    if (!service) return null;
    locationprovider.locationManger.changeSettings(
      accuracy:LocationAccuracy.high,
      distanceFilter: 1,
      interval: 2000,
    );
    listlocation=locationprovider.getTreceOFuserlocation().listen((newlocation) {

      print(
        newlocation.latitude,
      );
      print(
        newlocation.longitude,
      );
      Marker usermarkar = Marker(
          markerId: MarkerId(Homescreen.userloc),
          position:
          LatLng(newlocation.latitude ?? 0, newlocation.longitude ?? 0));
      markars.add(usermarkar);
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(newlocation.latitude ?? 0, newlocation.longitude ?? 0),18));
      setState(() {});
    });
//       location=await locationprovider.getLocation();
//     Marker usermarker= Marker(markerId: MarkerId('userlocation'),position:LatLng(location?.latitude ?? 0, location!.longitude ?? 0));
//     mapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(location!.latitude ?? 0, location!.longitude ?? 0),16.151926040649414));
//     mypositon=CameraPosition(target:LatLng(location!.latitude ?? 0, location!.longitude ?? 0),zoom: 16.151926040649414 );
//     markars.add(usermarker);
//    setState(() {
//    });
//     print(
//       location?.latitude,
//           );
//           print(
//             location?.longitude,
//           );
// print(
// '---------------------------------------------'          );
//
//
 }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listlocation?.cancel();
    print('close');
  }

}
//hiiiii26.0
// I/flutter (19681): 30.006862
