import 'dart:convert';

import 'package:http/http.dart' as http;


class UsuarioProvider{
  
  final _url ='http://fd529b4ecd5b.ngrok.io/api/auth/';

  Future <Map<String, dynamic>> login(String rut, String password) async{

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

  Future <Map<String, dynamic>> registro(String rut, String dv, String name, String email, String password) async{

      final _body = {"rut":rut,"dv":dv,"name":name,"email":email, "password":password};

      final response = await http.post(_url+'/signup', body: _body);
      
       Map<String, dynamic> decodedResp = json.decode(response.body);

        if(decodedResp['error']){

        return { 'error': true, 'mensaje': decodedResp['message']};      
          
        } else{
          
          return {'error': false, 'token': decodedResp['message']};

        }

  }

}