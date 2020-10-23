import 'package:geolocator/geolocator.dart';

class Location{

  Future getPermission() async{
    LocationPermission permission = await checkPermission();
    do{
      if(permission == LocationPermission.denied || permission ==  LocationPermission.deniedForever){
        await requestPermission();
      }
      permission = await checkPermission();
      print(permission);
    }while(permission == LocationPermission.denied || permission ==  LocationPermission.deniedForever);
  }

  Future<Position> getLocation() async{
    try{
      print('object');
      await getPermission();
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    }catch(e){
      print(e.toString());
      return null;
    }
  } 
  Future getLastKnownLocation() async{
    Position position = await getLastKnownPosition();
    return position;
  }
  
}