import 'dart:convert';

import 'package:http/http.dart' as http;


class UsuarioProvider{

  final _url ='http://1856cef55538.ngrok.io/api/auth/login';

  Future <Map<String, dynamic>> login (String rut, String password) async{

    final _body = {"usu_rut":rut, "password":password};

    final response = await http.post(_url, body: _body);

    Map<String, dynamic> decodedResp = json.decode(response.body);

    // si la respuesta viene con el id token
    if(decodedResp['error']){
    // salvar el token en el storage del fono ... con las preferencias
     return { 'error': true, 'mensaje': decodedResp['message']};      
      
    } else{
      
      return {'error': false, 'token': decodedResp['access_token'], 'usuRut': decodedResp['usu_rut']};

    }

  }

}