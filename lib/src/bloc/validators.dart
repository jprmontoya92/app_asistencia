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
   

      if(password.length <= 4){

        sink.addError("Ingresar min 4 caracteres");
      }else{
        sink.add(password); // lo deja fluir
        
      }
 

    }
  );

    final validarNombre = StreamTransformer<String, String>.fromHandlers(

    handleData: (nombre,sink){

      if(nombre.length <= 3){
        sink.addError("Ingrese  min 4 caracteres");
      }else{
        
        sink.add(nombre); // lo deja fluir
      }


    }
  );
    final validarApellidop = StreamTransformer<String, String>.fromHandlers(

    handleData: (apellidop,sink){

      if(apellidop.length <= 3){
        sink.addError("Ingrese  min 4 caracteres");
      }else{
        
        sink.add(apellidop); // lo deja fluir
      }


    }
  );
    final validarApellidom = StreamTransformer<String, String>.fromHandlers(

    handleData: (apellidom,sink){

      if(apellidom.length <= 3){
        sink.addError("Ingrese  min 4 caracteres");
      }else{
        
        sink.add(apellidom); // lo deja fluir
      }


    }
  );

  final validarEmail1 = StreamTransformer<String, String>.fromHandlers(

    handleData: (email1,sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email1)){
        sink.add(email1);
      }else{
        sink.addError('Email no es correcto');
      }

    }
  );
  
  final validarEmail2 = StreamTransformer<String, String>.fromHandlers(

    handleData: (email2,sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email2)){
        sink.add(email2);
      }else{
        sink.addError('Email no es correcto');
      }

    }
  );

   final validarFono = StreamTransformer<String, String>.fromHandlers(

    handleData: (fono,sink){

       /*  if(fono.length < 9 || fono.length > 9){
        sink.addError("Ingrese nueve digitos ");

        Pattern pattern = Pattern.compile('sdfsd');
      }else{
        
        sink.add(fono); // lo deja fluir
      } */

      Pattern pattern = r'^(?:[+0][1-9])?[0-9]{9}$';
      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(fono)) {
          sink.add(fono); // lo deja fluir
      }else{
        sink.addError("Ingrese nueve digitos ");
      }

    }
  );
}