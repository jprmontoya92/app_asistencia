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

      if(password.length <= 3){
        sink.addError("Hasta 4 caracteres");
      }else{
        
        sink.add(password); // lo deja fluir
      }


    }
  );
}