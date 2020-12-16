import 'dart:convert';

import 'package:http/http.dart' as http;


class UsuarioProvider{

  final _url ='http://fd529b4ecd5b.ngrok.io/api/auth/login';

  Future <Map<String, dynamic>> login (String rut, String password) async{

    final _body = {"rut":rut, "password":password};

    final response = await http.post(_url, body: _body);

    Map<String, dynamic> decodedResp = json.decode(response.body);

    // si la respuesta viene con el id token
    if(decodedResp['error']){
    // salvar el token en el storage del fono ... con las preferencias
     return { 'error': true, 'mensaje': decodedResp['message']};      
      
    } else{
      
      return {'error': false, 'token': decodedResp['access_token'], 'usuRut': decodedResp['rut']};

    }

  }

}