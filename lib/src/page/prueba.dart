
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:imei_plugin/imei_plugin.dart';

class PruebaPage extends StatefulWidget {

  static  String routeName = '';

  @override
  _PruebaPageState createState() => _PruebaPageState();
}


class _PruebaPageState extends State<PruebaPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text("hola mundo")),
    );
  }


  Future<void> info2() async{
    String imei = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    List<String> multiImei = await ImeiPlugin.getImeiMulti(); //for double-triple SIM phones
    String uuid = await ImeiPlugin.getId();

    print("IMEI : ${imei}");
    print("UUID : ${uuid}");
  }

  Future<void> info() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if(Platform.isAndroid){
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Usuario android device: ${androidInfo.device}');  // e.g. "Moto G (4)"
    print('Usuario android display: ${androidInfo.display}');  // e.g. "Moto G (4)"
    print('Usuario android  id: ${androidInfo.id}');  // e.g. "Moto G (4)"
    print('Usuario android  manufacturer: ${androidInfo.manufacturer}');  // e.g. "Moto G (4)"
    print('Usuario android  product: ${androidInfo.product}');  // e.g. "Moto G (4)"
    print('Usuario android  model: ${androidInfo.model}');  // e.g. "Moto G (4)"
    print('Usuario android  androidId: ${androidInfo.androidId}');  // e.g. "Moto G (4)"
    print('Usuario android  incremental: ${androidInfo.version.incremental}');  // e.g. "Moto G (4)"
    print('Usuario android  board: ${androidInfo.board}');  // e.g. "Moto G (4)"
    print('Usuario android  board: ${androidInfo.board}');  // e.g. "Moto G (4)"
    print('Usuario android  board: ${androidInfo.board}');  // e.g. "Moto G (4)"
    print('Usuario android  board: ${androidInfo.board}');  // e.g. "Moto G (4)"
    print('Usuario android  board: ${androidInfo.board}');  // e.g. "Moto G (4)"
    }else{
       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
         print('App corriendo en ${iosInfo.utsname.machine}'); 
    }
    

   
    
    
  }
    
}