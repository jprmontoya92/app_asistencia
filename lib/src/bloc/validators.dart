import 'dart:async';

class Validators{



  // siempre es conveniente indicar que informacion fluye o que infromacion entra en Strema Transformer
  final validarEmail= StreamTransformer<String , String>.fromHandlers(

    handleData: (email, sink){ //el sink dira que infromacion sigue fluyendo o que infromacion necsito notificar 

    // Expresion que valida un correo electronico 

    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp   = new RegExp(pattern); // con esta expresion regular verifico si hace march 

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError("Email no correcto");
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