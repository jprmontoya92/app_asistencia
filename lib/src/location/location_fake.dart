
 import 'package:flutter/services.dart';

class LocationFake{

static const platform = const MethodChannel('samples.flutter.io/location');


bool mocklocation = false;
String mensaje ;

Future<void> _getMockLocation() async{
  bool b;
  try{
    final bool result = await platform.invokeMethod('getLocation');
    b = result;
  } on PlatformException catch(e){
    b = false;
  }
  mocklocation = b;
}

 gpsFake(){
  _getMockLocation();

  if(mocklocation == true){
    mensaje = 'Tu ubicacion es falsa';
  }

  return mocklocation;
}
}

