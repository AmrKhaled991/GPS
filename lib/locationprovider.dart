
import 'package:location/location.dart';

class Locationprovid{
  Location locationManger=Location();

  Future<bool> IsServiceEnabled() async {
   var serviceEnabled = await locationManger.serviceEnabled();
    if (serviceEnabled == false) {
      serviceEnabled = await locationManger.requestService();
      return serviceEnabled;
    }
    return serviceEnabled;
  }
  Future<bool> IsPermissionGranted() async {
   var permissionStatus = await locationManger.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationManger.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    } else if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    } else {
      return permissionStatus == PermissionStatus.granted;
    }
  }

  Future<LocationData>  getcurrentlocation()async{
    var userlocation= locationManger.getLocation();
    return userlocation;
  }
  Stream<LocationData> getTreceOFuserlocation() {
    var userlocation= locationManger.onLocationChanged;
    return userlocation;
  }
}