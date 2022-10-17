import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {

  //If the user chooses to select his current location -->
  getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return 'Device does not have location Services';
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('permissions are denied');
        return 0;
        return 'Location Permissions are denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("permissions are denied permanently");
      return 1;
      return 'Location Permissions are permanently denied';
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print("Coordinates = ${position.latitude} , ${position.longitude}");
    return position;
  }

  //getting the address from the coordinates.
  getCurrentAddress(Position position) async {
    List<Placemark> placeMark =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    String Address = "";
    Address =
    "${placeMark[0].street}, ${placeMark[0].subLocality}, ${placeMark[0].locality}, ${placeMark[0].postalCode}, ${placeMark[0].administrativeArea}";
    return Address;
  }

  //If the user enters the address manually -->
  getPositionFromAddress(String Address)async{
    if(Address.isEmpty){
      return Location(latitude: 0.0, longitude: 0.0,timestamp: DateTime(DateTime.wednesday));
    }
    print('Address are - $Address');
    try{
      List<Location> locations = await locationFromAddress(Address);
      print('Locations are - $locations');
      if(locations.length != 0){
        return locations[0];
      }else{
        return Location(latitude: 0.0, longitude: 0.0,timestamp: DateTime(DateTime.wednesday));
      }
    }catch(e){
      return Location(latitude: 0.0, longitude: 0.0,timestamp: DateTime(DateTime.wednesday));
    }

  }
}
