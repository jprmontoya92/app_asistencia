import 'dart:convert';
import 'dart:io';

import 'package:asistencia/src/location/location_fake.dart';
import 'package:asistencia/src/location/location_service.dart';
import 'package:asistencia/src/model/evento_model.dart';
import 'package:asistencia/src/model/userlocation_model.dart';
import 'package:asistencia/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http; 

class MarcajeProvider{

  final String _url = 'http://fd529b4ecd5b.ngrok.io/api/auth/events';
  final String marcaje = 'marcaje';

  final prefs = new PreferenciasUsuario(); 
  final locationServie = new LocationService();
  final locationFake = new LocationFake();
  UserLocation coord;

/*   Future <Map<String,dynamic>> consultaCodigo(String id) async{

    final _body = {"identificador":id};

    try{
      final result = await InternetAddress.lookup('google.com');

      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        
        final response = await http.post(_url+marcaje+'/validarqr', body: _body);
        Map<String, dynamic> decodeResp = jsonDecode(response.body);
          if(decodeResp['error']){
             return {'error':true, 'mensaje':decodeResp['mensaje']};
          }else{
            identificador = id;
             return {'error':false, 'mensaje':decodeResp['mensaje']};
          }
        }
      } on SocketException catch(_){

            return {'error':true, 'mensaje':'Favor, comprueba la conexión de tus datos móviles'};
      }

  } */



  Future <Map<String, dynamic>> crearEvento(String tipoMarca,  String identificador ) async{
    
  

    coord = await locationServie.getLocation();


    final _headers = {"x-Requested-With":"XMLHttpRequest", "Authorization": "Bearer "+prefs.token};
    // construyo el cuerpo para ser enviado por post
    final _body ={"type":tipoMarca, "lat":coord.latitude.toString(),"lng":coord.longitude.toString(), "rut":prefs.usuRut.toString(), "identifier_id":identificador.toString()};

        try{

          final result = await InternetAddress.lookup('google.com');
          
          if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
            // conectado
              final response = await http.post(_url+'/create', headers: _headers, body: _body);

              Map<String, dynamic> decodeResp = json.decode(response.body);
              print(decodeResp);
              if(decodeResp['error']){
                return {'error':true, 'mensaje':decodeResp['message']};

              }else{
                return {'error':false, 'mensaje':decodeResp['message']};
              }
          }

        }on SocketException catch(_){

            return {'error':true, 'mensaje':'Favor, comprueba la conexión de tus datos móviles'};
        }
    
    
  }

  Future<List<EventoModel>> cargarEventos() async{

    final _body = {"rut":prefs.usuRut};
    final _headers = {"x-Requested-With":"XMLHttpRequest", "Authorization": "Bearer "+prefs.token};

        final List<EventoModel> eventos = new List();

        final resp = await http.post(_url, headers: _headers, body: _body);
        
        final decodeData = json.decode(resp.body);

        if(decodeData == null) return [];

        decodeData['events'].forEach((event){

          final prodTemp = EventoModel.fromJson(event);

          eventos.add(prodTemp);

        });
          
        
  
  

  return eventos;
    
  }

}