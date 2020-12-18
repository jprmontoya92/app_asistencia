import 'dart:async';

import 'package:asistencia/src/utils/rut_helper.dart';

class Validators{
      

  // siempre es conveniente indicar que informacion fluye o que infromacion entra en Strema Transformer
  final validarRut = StreamTransformer<String , String>.fromHandlers(

      
    handleData: (rut, sink){ //el sink dira que infromacion sigue fluyendo o que infromacion necsito notificar 

       if(rut != ''){
          if(RutHelper.check(rut)){
        sink.add(rut);
        }else{
          sink.addError("Rut Incorrecto");
        }

       }else{
          sink.addError("Rut Incorrecto");
       }
      
    }
  ); 


  // siemmpre es conveninete indicar que informacion fluye o que infromacion entra en el Stream TRanformer
  final validarPassword = StreamTransformer<String, String>.fromHandlers(

    handleData: (password,sink){
     /*  Pattern pattern = r'^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{8,16';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(password)){

        sink.add(password); // lo deja fluir
      }else{
        sink.addError("La contraseña debe tener entre 8 y 16 caracteres, al menos un dígito, al menos una minúscula, al menos una mayúscula y al menos un caracter no alfanumerico");
        
      }
 */
      sink.add(password);

    }
  );

    final validarFullName = StreamTransformer<String, String>.fromHandlers(

    handleData: (fullname,sink){

      if(fullname.length <= 3){
        sink.addError("Ingrese  min 4 caracteres");
      }else{
        
        sink.add(fullname); // lo deja fluir
      }


    }
  );

  final validarEmail = StreamTransformer<String, String>.fromHandlers(

    handleData: (email,sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Email no es correcto');
      }

    }
  );
}