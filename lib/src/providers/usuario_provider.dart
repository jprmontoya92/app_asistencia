import 'dart:convert';

import 'package:http/http.dart' as http;


class UsuarioProvider{
  
  final _url ='http://54a298ca5973.ngrok.io/api/auth/';

  Future <Map<String, dynamic>> login(String rut, String password) async{
            rut = rut.substring(0, rut.length - 1);
    final _body = {"rut":rut, "password":password};

    final response = await http.post(_url+'login', body: _body);

    Map<String, dynamic> decodedResp = json.decode(response.body);

    // si la respuesta viene con el id token
    if(decodedResp['error']){
    // salvar el token en el storage del fono ... con las preferencias
     return { 'error': true, 'mensaje': decodedResp['message']};      
      
    } else{
      
      return {'error': false, 'token': decodedResp['access_token'], 'usuRut': decodedResp['rut']};

    }

  }

  Future <Map<String, dynamic>> registro(String rut, String nombre, String apellidop, String apellidom, String email1, String email2, String password, String fono) async{

       rut = rut.substring(0, rut.length - 1);
       final dv = rut.substring(rut.length - 1);

      final _body = {
                    "rut":rut,
                    "dv":dv.toUpperCase(),
                    "name":nombre.toUpperCase(), 
                    "last_name":apellidop.toUpperCase(),
                    "second_surname":apellidom.toUpperCase(),
                    "first_email":email1.toUpperCase(),
                    "second_email":email2.toUpperCase(),
                    "password":password, 
                    "phone": fono};

      final response = await http.post(_url+'signup', body: _body);
    
       Map<String, dynamic> decodedResp = json.decode(response.body);
          
        if(decodedResp['error']){

        return { 'error': true, 'mensaje': decodedResp['message']};      
          
        } else{
          
          return {'error': false, 'token': decodedResp['message']};

        }

  }

}